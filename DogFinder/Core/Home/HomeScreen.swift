//
//  HomeView.swift
//  DogFinder
//
//  Created by Anastasia N.  on 26.03.2025.
//

import SwiftUI

struct HomeView: View {
    
    @State var selectedTab = 0
    
    var body: some View {
        NavigationStack {
            TabView(selection: $selectedTab) {
                Group {
                    BreedView()
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
            }
        }
    }
}

#Preview {
    NavigationStack {
        HomeView()
    }
}


