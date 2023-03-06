//
//  APIError.swift
//  CatBreedsApp
//
//  Created by Saranya Ravi on 06/03/2023.
//

import Foundation

enum APIError: Error {
    case invalidURL
    case url(URLError?)
    case invalidResponse(statusCode: Int)
    case parsingError
    case unknown
    
    
    static func convert(error: Error) -> APIError {
        switch error {
        case is URLError:
            return .url(error as? URLError)
        case is APIError:
            return error as! APIError
        default:
            return .unknown
        }
    }
    
    var localizedDescription: String {
        switch self {
        case .url(let error):
            return error?.localizedDescription ?? "Sorry, something went wrong"
        case .invalidResponse(_):
            return "Connection to the server failed"
        case .parsingError, .unknown, .invalidURL:
            return "Sorry, something went wrong"

        }
    }
}

