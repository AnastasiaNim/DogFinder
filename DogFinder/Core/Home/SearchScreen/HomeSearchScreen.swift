//
//  HomeSearchScreen.swift
//  DogFinder
//
//  Created by Anastasia N.  on 01.04.2025.
//

import SwiftUI

struct HomeSearchScreen: View {
    @Environment(\.dismiss) var dismiss
    @StateObject private var searchVM = SearchScreenViewModel()
    @FocusState private var isInputFocused: Bool
    
    var body: some View {
        ZStack {
            Color.secondary.opacity(0.2).ignoresSafeArea()
            
            VStack (alignment: .leading) {
                HStack (spacing: 0) {
                    backButton
                    searchSection
                }
                
                switch searchVM.searchState {
                case .idle:
                    searchNotStarted
                case .searching:
                    searchProcess
                case .result(let breeds):
                    searchResults(breeds)
                case .noResults:
                    noResult
                    
                }
                
            }
            .frame(maxHeight: .infinity, alignment: .top)
            .padding(10)
            .animation(.easeInOut, value: searchVM.searchState)
            
        }
        .navigationBarBackButtonHidden()
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                isInputFocused = true
            }
        }
    }
}



#Preview {
    HomeSearchScreen()
    
}

extension HomeSearchScreen {
    
    private var backButton: some View {
        Button {
            dismiss()
        } label: {
            Image(systemName: "chevron.left")
                .font(.system(size: 23).weight(.semibold))
                .foregroundStyle(.secondary)
                .padding(.trailing, 5)
                .padding(.bottom)
        }
    }
    
    private var searchSection: some View {
        SearchBarView(searchText: $searchVM.searchText)
            .focused($isInputFocused)
    }
    
    private var searchNotStarted: some View {
        VStack (spacing: 5) {
            Text("Find your friend!")
            Text("🐾")
                .font(.title)
        }
        .font(.headline)
        .frame(maxWidth: .infinity, alignment: .center)
    }
    
    private var searchProcess: some View {
        ProgressView()
            .padding(30)
            .scaleEffect(1.5)
            .frame(maxWidth: .infinity, alignment: .center)
    }
    
    private func searchResults(_ breeds: [Breed]) -> some View {
        ScrollView {
            LazyVStack {
                ForEach(breeds) { breed in
                    NavigationLink(value: HomeLink.details(breed)) {
                        SearchBreed(breed: breed)
                    }
                }
            }
        }
        .transition(.move(edge: .bottom).combined(with: .opacity))
        
    }
    
    private var noResult: some View {
        VStack {
            Text("Unfortunately nothing was found.")
            Text("👹")
        }
        .font(.headline)
        .padding()
        .frame(maxWidth: .infinity, alignment: .center)
    }
}

struct SearchBreed: View {
    let breed: Breed
    var body: some View {
        HStack {
            ImageLoader(url: breed.imageURL)
                .frame(width: 50, height: 50)
                .cornerRadius(20)
            
            Text(breed.name)
                .font(.callout)
                .foregroundStyle(Color.black)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .foregroundStyle(Color.secondary)
        }
        .padding()
        .frame(maxWidth: .infinity)
        .frame(height: 70)
        .background(
            Color.white, in: RoundedRectangle(cornerRadius: 20)
        )
    }
}



#Preview {
    ZStack {
        
        Color.gray
        SearchBreed(breed: Breed.mockBreeds.first!)
    }
}
