//
//  BreedFavoritesManager.swift
//  DogFinder
//
//  Created by Anastasia N.  on 22.04.2025.
//

import Foundation

class BreedFavoritesManager: ObservableObject {
    private let breedCoreDataService: BreedCoreDataService
    
    init() {
        breedCoreDataService = .init(context: CoreDataService.shared.viewContext)
        fetchBreeds()
    }
    
    @Published private(set) var breeds: [Breed] = []
    
    func fetchBreeds() {
        breeds = breedCoreDataService.getBreedsList()
    }
    
    func hasAddedBreed(_ breedId: Int) -> Bool {
        return breeds.contains(where: { $0.id == breedId })
    }
    
    func addBreed(_ breed: Breed) {
        guard !hasAddedBreed(breed.id) else { return }
        breedCoreDataService.addBreed(breed)
        fetchBreeds()
    }
    
    func removeBreed(_ breedId: Int) {
        guard hasAddedBreed(breedId) else { return }
        breedCoreDataService.removeBreed(id: breedId)
        fetchBreeds()
    }
}
