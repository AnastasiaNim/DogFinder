//
//  HomeView.swift
//  DogFinder
//
//  Created by Anastasia N.  on 26.03.2025.
//

import SwiftUI


struct HomeSсreen: View {
    @StateObject private var vm = HomeViewModel()
    @State private var selectedBreed: Breed? = nil
    @State private var searchText: String = ""
    
    var body: some View {
        ZStack {
            Color.secondary.opacity(0.2).ignoresSafeArea()
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    title
                    listBreeds
                }
                .padding()
            }
        }
        .onAppear {
            vm.fetchFirstPage()
        }
    }
}


#Preview {
    NavigationStack {
        HomeSсreen()
            .navigationDestination(for: HomeLink.self) { type in
                switch type {
                case .details(let breed):
                    BreedDetails(dog: breed)
                        .environmentObject(BreedFavoritesManager())
                case .search:
                    HomeSearchScreen()
                }
            }
    }
}

extension HomeSсreen {
    
    private var title: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text("Discover")
                .font(.leckerliOne(size: 35))
            titlePresence
        }
    }
    
    private var titlePresence: some View {
        Text("Find your perfect match! Choose a dog breed to explore available companions."
            .attributed(highlights: ["Choose a dog breed"]))
        .font(.system(size: 20))
        .foregroundStyle(.secondary)
    }
    
    private var searchBarButton: some View {
        NavigationLink(value: HomeLink.search) {
            SearchBarView(searchText: $searchText)
                .disabled(true)
        }
    }
    
    private var listBreeds: some View {
        LazyVStack(alignment: .leading, spacing: 0, pinnedViews: [.sectionHeaders]) {
            
            Section(content: {
                ForEach(vm.breeds) { breed in
                    NavigationLink(value: HomeLink.details(breed)) {
                        BreedRowView(breed: breed)
                            .padding(.bottom, 20)
                    }
                    .buttonStyle(PlainButtonStyle())
                    .onAppear {
                        if vm.needsFetchNextPage(id: breed.id) {
                            vm.fetchNextPage()
                        }
                    }
                }
                
            }, header: {
                searchBarButton
            })
            
        }
    }
}

extension HomeSсreen {
    
    private static let greetingText: String = "Find your perfect match! Choose a dog breed to explore available companions."
}
