//
//  BreedsViewModel.swift
//  CatBreedsApp
//
//  Created by Saranya Ravi on 06/03/2023.
//

import Foundation
import Combine


class BreedsViewModel: ObservableObject {

    private let service: APIServicce!
    private var subscriptions: AnyCancellable!

    @Published var breeds : [Breed] = []
    @Published var errorMessage: String? = nil
    @Published var isLoading: Bool = false

    init(service: APIServicce) {
        self.service = service
        displayCatBreeds()
    }
    
    func displayCatBreeds() {
        fetchAndDisplayCatBreeds()
    }
    
    private func fetchAndDisplayCatBreeds() {
        guard let url = URL(string: "https://api.thecatapi.com/v1/breeds/?limit=15") else {
            errorMessage = APIError.invalidURL.localizedDescription
            return
        }
        
        isLoading.toggle()
        errorMessage = nil
        
        subscriptions = service.getCatBreeds(url: url)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: {[weak self] status in
            switch status {
            case .failure(let error):
                self?.isLoading.toggle()
                self?.errorMessage = error.localizedDescription
            case .finished: break
            }
        }, receiveValue: { [weak self] breeds in
            self?.isLoading.toggle()
            self?.breeds = breeds
        })
    }
}
