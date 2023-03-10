//
//  CatSetvice.swift
//  CatBreedsApp
//
//  Created by Saranya Ravi on 06/03/2023.
//

import Foundation
import Combine


protocol APIServicce {
    func getCatBreeds(url: URL) -> AnyPublisher<[Breed], APIError>
}

struct CatServcie: APIServicce {
    
    /* If I had time I wanted to implement this with Generic type
    func fetchData<T: Decodable>(_ type: T.Type, url: URL) -> AnyPublisher<T, APIError> { }
    } */
    
    func getCatBreeds(url: URL) -> AnyPublisher<[Breed], APIError> {
        
        var request = URLRequest(url: url)
        request.addValue(apiValue, forHTTPHeaderField: apiKey)
        request.httpMethod = "GET"

        return URLSession.shared.dataTaskPublisher(for: request)
            .tryMap({ (data, response) -> Data in
                if let response = response as? HTTPURLResponse,
                   !(200...299).contains(response.statusCode) {
                    throw APIError.invalidResponse(statusCode: response.statusCode)
                } else {
                    return data
                }
            })
            .decode(type: [Breed].self, decoder: JSONDecoder())
            .mapError({ error in APIError.convert(error:error) })
            .eraseToAnyPublisher()
    }
}
