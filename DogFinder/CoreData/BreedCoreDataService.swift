//
//  BreedCoreDataService.swift
//  DogFinder
//
//  Created by Anastasia N.  on 21.04.2025.
//

import Foundation
import CoreData

final class BreedCoreDataService {
    let context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    func getBreedsList() -> [Breed] {
        let request = BreedEntity.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        do {
            return try context.fetch(request).map{$0.breed}
        } catch let error {
            print("Error fetching Portfolio Entitis. \(error.localizedDescription)")
            return []
        }
    }
    
    func addBreed(_ breed: Breed) {
        breed.makeBreedEntity(context: context)
        save()
    }
    
    func removeBreed(id: Int) {
        guard let breed = getBreed(id: id) else { return }
        
        context.delete(breed)
        save()
    }
    
    func getBreed(id: Int) -> BreedEntity? {
        let request = BreedEntity.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", NSNumber(value: id))
        request.fetchLimit = 1
        do {
            return try context.fetch(request).first
        } catch {
            print("Get error: \(error.localizedDescription)")
            return nil
        }
    }
    
    private func save() {
        do {
            try context.save()
        } catch {
            print("Save error: \(error.localizedDescription)")
        }
    }
}

extension BreedEntity {
    
    var breed: Breed {
        .init(weight: .init(imperial: self.wImperial ?? "", metric: self.wMetric ?? ""),
              height: .init(imperial: self.hImperial ?? "", metric: self.hMetric ?? ""),
              id: Int(self.id),
              name: self.name ?? "",
              bredFor: self.bredFor ?? "",
              lifeSpan: self.lifeSpan ?? "",
              temperament: self.temperament ?? "",
              origin: self.origin ?? "",
              imageId: self.imageID ?? "")
    }
    
}

extension Breed {
    
    @discardableResult
    func makeBreedEntity(context: NSManagedObjectContext) -> BreedEntity {
        
        let breedEntity = BreedEntity(context: context)
        breedEntity.id = Int64(id)
        breedEntity.name = name
        breedEntity.imageID = imageId
        breedEntity.lifeSpan = lifeSpan
        breedEntity.hMetric = height.metric
        breedEntity.wMetric = weight.metric
        breedEntity.hImperial = height.imperial
        breedEntity.wImperial = weight.imperial
        breedEntity.temperament = temperament
        breedEntity.origin = origin
        
        
        return breedEntity
    }
    
}
