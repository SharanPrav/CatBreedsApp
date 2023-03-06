//
//  BreedViewModelTests.swift
//  CatBreedsAppTests
//
//  Created by Prav Kaly on 06/03/2023.
//

import XCTest
import Combine
@testable import CatBreedsApp

final class BreedViewModelTests: XCTestCase {
    var sut: BreedsViewModel! // sut: System Under Test
    var subscriptions: AnyCancellable!
    
    func makeSut(mockService: APIMockService) {
        sut = BreedsViewModel(service:  mockService)
    }
    
    func test_isLoading_When_the_fetch_is_made() {
        let mockAPI = APIMockService(result: .success(Breed.exampleList()))
        makeSut(mockService: mockAPI)
        
        XCTAssertEqual(sut.isLoading, true)
    }
    
    func test_Empty_Array_before_data_fetch() {
        let mockAPI = APIMockService(result: .success(Breed.exampleList()))
        makeSut(mockService: mockAPI)
        
        XCTAssertEqual(sut.breeds.count, 0, "Starting with no breeds")
    }
    
    func test_get_successful_response() {
        let successServiceMock = APIMockService(result: .success([Breed.example()]))
        makeSut(mockService: successServiceMock)
        
        let expectation = expectation(description: "loading single breed")
        subscriptions = sut.$breeds.sink { (completion) in
            XCTFail()
        } receiveValue: { (breeds) in
            if breeds.count > 0 {
                expectation.fulfill()
            }
        }
        wait(for: [expectation], timeout: 0.1)
        XCTAssertEqual(sut.isLoading, false)
    }
        
    func test_List_Of_Breeds_Updated_On_Successful_Fetch() {
        let successServiceMock = APIMockService(result: .success(Breed.exampleList()))
        makeSut(mockService: successServiceMock)
                
        let expectation = expectation(description: "loading 3 breeds")
        subscriptions = sut.$breeds.sink { (completion) in
            XCTFail()
        } receiveValue: { (breeds) in
            if breeds.count == 3 {
                expectation.fulfill()
            }
        }
        wait(for: [expectation], timeout: 0.1)
        
        XCTAssertEqual(sut.breeds, Breed.exampleList(), "check if data matches")
        XCTAssertEqual(sut.isLoading, false)
    }
    
    func test_app_sends_correct_error_message() {
        let failureServiceMock = APIMockService(result: .failure(APIError.invalidURL))
        makeSut(mockService: failureServiceMock)

        let expectation = expectation(description: "check error message")
        subscriptions = sut.$errorMessage
            .filter { errorMessage in
                errorMessage != nil
            }.sink { (completion) in
                expectation.fulfill()
             }
        wait(for: [expectation], timeout: 0.1)
        
        XCTAssertEqual(sut.errorMessage, "Sorry, something went wrong") // must be Localized ideally
    }
    
    func test_empty_Breeds_Array_and_stops_Loading_onFailure() {
        let failureServiceMock = APIMockService(result: .failure(APIError.invalidURL))
        makeSut(mockService: failureServiceMock)

        let expectation = expectation(description: "check failing response conditions")
        subscriptions = sut.$errorMessage
            .filter { errorMessage in
                errorMessage != nil
            }.sink { (completion) in
                expectation.fulfill()
             }
        wait(for: [expectation], timeout: 0.1)
        
        XCTAssertEqual(sut.isLoading, false)
        XCTAssertEqual(sut.breeds.count, 0, "breeds array is empty")
    }
}

struct APIMockService: APIServicce {
    var result: Result<[Breed], APIError>

    func getCatBreeds(url: URL) -> AnyPublisher<[Breed], APIError> {
        result.publisher.eraseToAnyPublisher()
    }
}
