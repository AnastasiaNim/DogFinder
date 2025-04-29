//
//  RootView.swift
//  DogFinder
//
//  Created by Anastasia N.  on 01.04.2025.
//

import SwiftUI

struct RootView: View {
    @StateObject private var favoritesManager = BreedFavoritesManager()
    
    @State var selectedTab = 0
    
    var body: some View {
        NavigationStack {
            TabView(selection: $selectedTab) {
                Group {
                    HomeSсreen()
                        .tabItem {
                            Image(systemName: "dog")
                            Text("Pets")
                        }
                        .tag(0)
                    
                    FavoritesScreen()
                        .tabItem {
                            Image(systemName: "star.fill")
                            Text("Favorite")
                        }
                        .tag(1)
                }
                .toolbarBackground(.white, for: .tabBar)
                .toolbarBackground(.visible, for: .tabBar)
                .environmentObject(favoritesManager)
            }
            .navigationDestination(for: HomeLink.self) { type in
                makeHomeDestination(type)
            }
            .navigationDestination(for: FavoritesLink.self) { type in
                makeFavoritesDestination(type)
            }
            .onAppear {
                favoritesManager.fetchBreeds()
            }
        }
    }
}

#Preview {
    RootView()
        .environmentObject(BreedFavoritesManager())
}

extension RootView {
    
    @ViewBuilder
    private func makeHomeDestination(_ type: HomeLink) -> some View {
        
        switch type {
        case .details(let breed):
            BreedDetails(dog: breed)
                .environmentObject(favoritesManager)
        case .search:
            HomeSearchScreen()
        }
    }
    
    @ViewBuilder
    private func makeFavoritesDestination(_ type: FavoritesLink) -> some View {
        switch type {
        case .details(let breed):
            BreedDetails(dog: breed)
                .environmentObject(favoritesManager)
        }
    }
}

enum HomeLink: Hashable {
    case details(Breed), search
}

enum FavoritesLink: Hashable {
    case details(Breed)
}



