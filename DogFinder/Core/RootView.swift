//
//  RootView.swift
//  DogFinder
//
//  Created by Anastasia N.  on 01.04.2025.
//

import SwiftUI

struct RootView: View {
    
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
            }
            .navigationDestination(for: HomeLink.self) { type in
                makeHomeDestination(type)
            }
            .navigationDestination(for: FavoritesLink.self) { type in
                makeFavoritesDestination(type)
            }
            // navigationDestination нужно указывать всегда внутри вью которая обернута NavigationStack и важно все в одном файле! не получится вынести отдельно например внутри HomeSсreen, указываем все типы что используем далее
        }
    }
}

#Preview {
    RootView()
}

extension RootView {

    //вынес для удобства в функцию @ViewBuilder он нужен так как типы разные на выходе
    //подключаем так теперь при выборе прокидывется определенный тип и рендер и инит только в процессе перехода один раз
    @ViewBuilder
    private func makeHomeDestination(_ type: HomeLink) -> some View {
        
        switch type {
        case .details(let breed):
            BreedDetails(dog: breed)
        case .search:
            HomeSearchScreen()
        }
    }
    
    @ViewBuilder
    private func makeFavoritesDestination(_ type: FavoritesLink) -> some View {
        switch type {
        case .details(let breed):
            BreedDetails(dog: breed)
        }
    }
}


//описание всех нашей навигации в виде типа Hashable так будем все заранее знать кто куда ведет в нашем случае имеем два корневых экрана home и favorites и они подразделяются на details и search и details все это Hashable тип (все это может пригодится для глобально роутинга например через класс потом изучим)
// это удобно и все заранее конструируем

enum HomeLink: Hashable {
    case details(Breed), search
}

enum FavoritesLink: Hashable {
    case details(Breed)
}



