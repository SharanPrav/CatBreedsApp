//
//  Breed.swift
//  CatBreedsApp
//
//  Created by Saranya Ravi on 06/03/2023.
//

import Foundation

let imagePath = "https://cdn2.thecatapi.com/images/"
let imageExtension = ".jpg"

struct Breed: Identifiable, Codable, Hashable {
    var id: String
    
    let name: String
    let origin: String
    let temperament: String
    let reference_image_id: String
    
    var imageUrl: URL? {
        let urlString = imagePath + reference_image_id + imageExtension
        return URL.init(string: urlString)
    }
    
    static func example() -> Breed {
        Breed(id: "1", name: "cat", origin: "Netherlands", temperament: "Happy", reference_image_id: "")
    }
    
    static func exampleList() -> [Breed] {
       [ Breed(id: "1", name: "cat", origin: "Netherlands", temperament: "Happy", reference_image_id: "a"),
        Breed(id: "2", name: "cat", origin: "Ireland", temperament: "Happy", reference_image_id: "b"),
        Breed(id: "3", name: "cat", origin: "Scotland", temperament: "Happy", reference_image_id: "c") ]
    }
}

