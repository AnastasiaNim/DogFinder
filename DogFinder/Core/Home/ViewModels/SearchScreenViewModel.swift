//
//  SearchScreenViewModel.swift
//  DogFinder
//
//  Created by Anastasia N.  on 09.04.2025.
//

import Foundation
import Combine

class SearchScreenViewModel: ObservableObject {
    
    
    @Published var breeds: [Breed] = []
    
    @Published var searchText: String = ""
    @Published var searchState: SearchState = .idle
    @Published var isLoading: Bool = false
    
    private var searchCancellable: AnyCancellable?
    private var resultCancellable: AnyCancellable?
    
    init() {
        searchBreeds()
    }
    
    private var currentPage: Int = 0
    
    enum SearchState {
        case idle
        case searching
        case result([Breed])
        case noResults
    }
    
    func searchBreeds() {
        searchCancellable =  $searchText
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .removeDuplicates()
            .sink { [weak self] query in
                guard let self = self else { return }
                
                let clearQuery = query.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
                guard !clearQuery.isEmpty else {
                    searchState = .idle
                    return
                }
                resultCancellable?.cancel()
                searchState = .searching
                searchResults(for: query)
                
            }
    }
    
    private func searchResults(for querty: String) {
        resultCancellable = DogDataService.search(query: querty)
            .sink(receiveCompletion: NetworkingManager.handleCompletion) { [weak self] breeds in
                guard let self = self else { return }
                if breeds.isEmpty {
                    searchState = .noResults
                } else {
                    let sortedBreeds = sortedResultsByPrefix(query: querty, breeds)
                    self.breeds = sortedBreeds
                    self.searchState = .result(sortedBreeds)
                }
            }
    }
    
    private func sortedResultsByPrefix(query: String, _ breeds: [Breed]) -> [Breed] {
        let matched = breeds.filter{ $0.name.lowercased().hasPrefix(query)}
        let unmatched = breeds.filter { !$0.name.lowercased().hasPrefix(query) }
        
        return matched + unmatched
    }
    
 
    
}




