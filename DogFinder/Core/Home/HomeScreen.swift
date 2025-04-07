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
            vm.fetchBreeds()
        }
    }
}


// в превью навигация не будет работать на этих экранах это нормально потому что путь описан только в root view, если хочешь чтоб работало надо обернуть в NavigationStack и описать пути
#Preview {
    NavigationStack {
        HomeSсreen()
            .navigationDestination(for: HomeLink.self) { type in
                switch type {
                case .details(let breed):
                    BreedDetails(dog: breed)
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
    
    // сделал как кнопку пример как в озоне переход на отдельный экран поиска disabled так чтоб не работала строка поиска
    private var searchBarButton: some View {
        NavigationLink(value: HomeLink.search) {
            SearchBarView(searchText: $searchText)
                .disabled(true)
        }
    }
    
    // в текущем ваниенте есть баг в листе так как id одинаковые когда  при скролле доабвляем новые странице так как они у нас мок и не отличаются (можно поправить так ForEach(vm.breeds.indices, id: \.self либо оставить как было по id уже для теста нормлаьно с инетом)
    
    private var listBreeds: some View {
        LazyVStack(alignment: .leading, spacing: 0, pinnedViews: [.sectionHeaders]) {
            //сделал тут секцию чтоб знала как можно сделать липкий хеадер
            Section(content: {
                
                //поправил баг с id теперь id это индекс в массиве
                // фиксит баг если у нас одинакоые id придут
                // но способ неоч так как постоянно берем массив indices индексов
                //убери как начнешь делать инет верни как было на ForEach(vm.breeds) { breed in
                ForEach(vm.breeds) { breed in
                    // переделал навигацию передает только значение то что мы ходим прокинуть Hashable тип
                    NavigationLink(value: HomeLink.details(breed)) {
                        BreedRowView(breed: breed)
                            .padding(.bottom, 20)
                    }
                    .buttonStyle(PlainButtonStyle())
                    .onAppear {
                        ///👍🥖
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
    
    // вынес это в статику, тогда не нужно создавать строку постоянно снова при ините экрана
    private static let greetingText: String = "Find your perfect match! Choose a dog breed to explore available companions."
}
