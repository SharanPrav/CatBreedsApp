//
//  APIErrorTests.swift
//  CatBreedsAppTests
//
//  Created by Saranya Ravi on 06/03/2023.
//

import XCTest
@testable import CatBreedsApp

final class APIErrorTests: XCTestCase {
    
    func test_ErrorConversion_URLError() {
        let urlError = NSError(domain: NSURLErrorDomain, code: NSURLErrorBadURL) as Error
        XCTAssertEqual(APIError.convert(error: urlError), APIError.url(urlError as? URLError))
    }
    
    func test_ErrorConversion_APIError_unknown() {
        let otherError = NSError(domain: "ab" , code: 100) as Error
        XCTAssertEqual(APIError.convert(error: otherError), APIError.unknown)
    }
    
    func test_Localised_descriptiom_APIError_badResponse() {
        let ApiError = APIError.invalidResponse(statusCode: 100)
        XCTAssertEqual(ApiError.localizedDescription, "Connection to the server failed") // must be localised
    }
    
    func test_Localised_descriptiom_APIError_Parsing() {
        let ApiError = APIError.parsingError
        XCTAssertEqual(ApiError.localizedDescription, "Sorry, something went wrong")
    }
    
    func test_Localised_descriptiom_APIError_invalidURL() {
        let ApiError = APIError.invalidURL
        XCTAssertEqual(ApiError.localizedDescription, "Sorry, something went wrong")
    }
    
    func test_Localised_descriptiom_APIError_unknown() {
        let ApiError = APIError.unknown
        XCTAssertEqual(ApiError.localizedDescription, "Sorry, something went wrong")
    }
}
