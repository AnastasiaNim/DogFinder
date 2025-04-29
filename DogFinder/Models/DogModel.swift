//
//  Breed.swift
//  DogFinder
//
//  Created by Anastasia N.  on 20.03.2025.
//

import Foundation

struct Breed: Codable, CustomStringConvertible, Identifiable, Hashable {

    let weight, height: Size
    let id: Int
    let name: String
    let bredFor, lifeSpan: String?
    let temperament, origin: String?
    let imageId: String?
    
    var description: String {
        "\(name) dog can reach a height between \(height.imperial) inches, and weight between \(weight.imperial) lbs."
    }
    var highlightDescription: AttributedString {
        description.attributed(highlights: [height.imperial, weight.imperial], font: .system(size: 15).bold())
    }
        
    var imageURL: URL? {
        guard let imageId else { return nil }
        return URL(string: "https://cdn2.thedogapi.com/images/\(imageId).jpg")
    }
    
    enum CodingKeys: String, CodingKey {
        case weight, height, id, name, temperament, origin
        case bredFor = "bred_for"
        case lifeSpan = "life_span"
        case imageId = "reference_image_id"
    }
    
    init(from decoder: any Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try values.decode(Int.self, forKey: .id)
        self.weight = try values.decode(Size.self, forKey: .weight)
        self.height = try values.decode(Size.self, forKey: .height)
        self.name = try values.decode(String.self, forKey: .name)
        self.bredFor = try values.decodeIfPresent(String.self, forKey: .bredFor)
        self.lifeSpan = try values.decodeIfPresent(String.self, forKey: .lifeSpan)
        self.temperament = try values.decodeIfPresent(String.self, forKey: .temperament)
        self.origin = try values.decodeIfPresent(String.self, forKey: .origin)
        self.imageId = try? values.decodeIfPresent(String.self, forKey: .imageId)
    }
    
    init(weight: Size,
         height: Size,
         id: Int,
         name: String,
         bredFor: String? = nil,
         lifeSpan: String? = nil,
         temperament: String? = nil,
         origin: String? = nil,
         imageId: String? = nil) {
        self.weight = weight
        self.height = height
        self.id = id
        self.name = name
        self.bredFor = bredFor
        self.lifeSpan = lifeSpan
        self.temperament = temperament
        self.origin = origin
        self.imageId = imageId
    }
}

struct Size: Codable, Hashable {
    let imperial, metric: String
}

extension Breed {
    
    static let mockBreeds: [Breed] = [
        Breed(
            weight: Size(imperial: "6 - 13", metric: "3 - 6"),
            height: Size(imperial: "9 - 11.5", metric: "23 - 29"),
            id: 1,
            name: "Affenpinscher",
            bredFor: "Small rodent hunting, lapdog",
            lifeSpan: "10 - 12 years",
            temperament: "Stubborn, Curious, Playful, Adventurous, Active, Fun-loving",
            origin: "Germany, France",
            imageId: "BJa4kxc4X"
        ),
        
        Breed(
            weight: Size(imperial: "50 - 60", metric: "23 - 27"),
            height: Size(imperial: "25 - 27", metric: "64 - 69"),
            id: 2,
            name: "Afghan Hound",
            bredFor: "Coursing and hunting",
            lifeSpan: "10 - 13 years",
            temperament: "Aloof, Clownish, Dignified, Independent, Happy",
            origin: "Afghanistan, Iran, Pakistan",
            imageId: "hMyT4CDXR"
        ),
        
        Breed(
            weight: Size(imperial: "44 - 66", metric: "20 - 30"),
            height: Size(imperial: "30", metric: "76"),
            id: 3,
            name: "African Hunting Dog",
            bredFor: "A wild pack animal",
            lifeSpan: "11 years",
            temperament: "Wild, Hardworking, Dutiful",
            origin: "",
            imageId: "rkiByec47"
        ),
        
        Breed(
            weight: Size(imperial: "40 - 65", metric: "18 - 29"),
            height: Size(imperial: "21 - 23", metric: "53 - 58"),
            id: 4,
            name: "Airedale Terrier",
            bredFor: "Badger, otter hunting",
            lifeSpan: "10 - 13 years",
            temperament: "Outgoing, Friendly, Alert, Confident, Intelligent, Courageous",
            origin: "United Kingdom, England",
            imageId: "1-7cgoZSh"
        ),
        
        Breed(
            weight: Size(imperial: "90 - 120", metric: "41 - 54"),
            height: Size(imperial: "28 - 34", metric: "71 - 86"),
            id: 5,
            name: "Akbash Dog",
            bredFor: "Sheep guarding",
            lifeSpan: "10 - 12 years",
            temperament: "Loyal, Independent, Intelligent, Brave",
            origin: "",
            imageId: "26pHT3Qk7"
        )
    ]
}


