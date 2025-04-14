//
//  HomeSearchScreen.swift
//  DogFinder
//
//  Created by Anastasia N.  on 01.04.2025.
//

import SwiftUI

struct HomeSearchScreen: View {
    
    @StateObject private var searchVM = SearchScreenViewModel()
    
    var body: some View {
        ZStack {
            Color.secondary.opacity(0.2).ignoresSafeArea()
            
            VStack (alignment: .leading) {
                
                SearchBarView(searchText: $searchVM.searchText)
                
                switch searchVM.searchState {
                case .idle:
                    
                    Text("Find your friend!")
                        .font(.headline)
                        .frame(maxWidth: .infinity, alignment: .center)
                        
                case .searching:
                    ProgressView()
                        .padding(30)
                        .scaleEffect(1.5)
                        .frame(maxWidth: .infinity, alignment: .center)
                case .result(let breeds):
                    
                    ScrollView {
                        LazyVStack {
                            ForEach(breeds) { breed in
                                NavigationLink(value: HomeLink.details(breed)) {
                                    SearhBreed(breed: breed)
                                }
                            }
                        }
                    }
                case .noResults:
                    Text("Unfortunately nothing was found")
                    
                }
            }
            .frame(maxHeight: .infinity, alignment: .top)
            .padding()
        }
    }
}


#Preview {
    HomeSearchScreen()
}

extension HomeSearchScreen {
}
    
 struct SearhBreed: View {
    let breed: Breed
    var body: some View {
        HStack {
            ImageLoader(url: breed.imageURL)
                .frame(width: 50, height: 50)
                .cornerRadius(25)
            
            Text(breed.name)
        }
            .padding()
            .frame(maxWidth: .infinity)
            .frame(height: 100)
            .background(
                Color.white, in: RoundedRectangle(cornerRadius: 20)
            )
        
            
    }
}
    
    

