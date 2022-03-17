//
//  NetworkError.swift
//  BakeryApp
//
//  Created by Abhishek Kumar on 18/03/22.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case responseError
    case parsingError(Error)
    case unknown
}

extension NetworkError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return NSLocalizedString("Invalid URL", comment: "Invalid URL")
        case .responseError:
            return NSLocalizedString("Unexpected status code", comment: "Invalid response")
        case .unknown:
            return NSLocalizedString("Unknown error", comment: "Unknown error")
        case .parsingError(let error):
            return NSLocalizedString("\(error)", comment: "parsing error")
        }
    }
}
