//
//  BreedTests.swift
//  CatBreedsAppTests
//
//  Created by Saranya Ravi on 06/03/2023.
//

import XCTest

import XCTest
@testable import CatBreedsApp

final class BreedTests: XCTestCase {
    var sut: Breed!
    
    func test_ImageURL_is_computed_correctly() {
        sut = Breed(id: "1", name: "", origin: "", temperament: "", reference_image_id: "ABC")
        
        let url = URL.init(string: imagePath + sut.reference_image_id + imageExtension)
        XCTAssertEqual(sut.imageUrl, url)
    }
}
