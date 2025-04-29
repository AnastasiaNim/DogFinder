//
//  HomeViewModel.swift
//  DogFinder
//
//  Created by Anastasia N.  on 25.03.2025.
//

import Foundation
import Combine


class HomeViewModel: ObservableObject {
    
    @Published var breeds: [Breed] = []
    @Published var isLoading: Bool = false
    
    
    private var currentPage: Int = 0
    private var cancellable: AnyCancellable?
    
    
    deinit {
        cancellable?.cancel()
    }
    
    
    func fetchBreeds(for page: Int = 0, for size: Int = 10) {
        
        self.isLoading = true
        print("\(page)")
        cancellable = DogDataService.list(page: page, size: size)
        
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] (returnedBreeds) in
                self?.isLoading = false
                self?.breeds.append(contentsOf: returnedBreeds)
            })
        
    }
    
    func fetchFirstPage() {
        guard breeds.isEmpty  else { return }
        currentPage = 0
        fetchBreeds(for: currentPage)
    }
    
    
    func needsFetchNextPage(id: Int) -> Bool {
        return breeds.last?.id == id
    }
    
    func fetchNextPage() {
        guard !isLoading else { return }
        currentPage += 1
        fetchBreeds(for: currentPage)
    }
    
    
}






