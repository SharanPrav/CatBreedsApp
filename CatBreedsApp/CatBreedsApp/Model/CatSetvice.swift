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
    func getCatBreeds(url: URL) -> AnyPublisher<[Breed], APIError> {
        var request = URLRequest(url: url)
        request.addValue(apiValue, forHTTPHeaderField: apiKey)
        request.httpMethod = "GET"

        return URLSession.shared.dataTaskPublisher(for: request)
                                .map(\.data)
                                .decode(type: [Breed].self, decoder: JSONDecoder())
                                .mapError({ error in APIError.convert(error:error) })
                                .eraseToAnyPublisher()
    }
}
