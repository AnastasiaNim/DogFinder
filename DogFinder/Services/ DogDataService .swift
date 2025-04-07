//
//   DogAPIService .swift
//  DogFinder
//
//  Created by Anastasia N.  on 25.03.2025.
//

import Foundation
import Combine


class DogDataService {
    
    
    static let baseURL = "https://api.thedogapi.com/v1"
    
    
    static func search(query: String) -> AnyPublisher<[Breed], Error> {
        let url: URL = URL(string: Self.baseURL + "/breeds/search?q=\(query)")!
        return NetworkingManager.download(url: url)
            .decode (type: [Breed].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    static func list(page: Int = 0, size: Int = 10) -> AnyPublisher<[Breed], Error> {
        let url: URL = URL(string: Self.baseURL + "/breeds?limit=\(size)&page=\(page)")!
        return NetworkingManager.download (url: url)
            .decode (type: [Breed].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}

