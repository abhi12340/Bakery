//
//  BakeryURLRequest.swift
//  BakeryApp
//
//  Created by Abhishek Kumar on 18/03/22.
//

import Foundation

protocol URLRequestConvertible {
    func asURLRequest() throws -> URLRequest
}

extension URLRequestConvertible {
    
    func encode(urlRequest: inout URLRequest, with parameters: Parameters, isSortedDesc: Bool = false) throws {
        guard let url = urlRequest.url else {throw  NetworkError.invalidURL}
        
        if var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false), !parameters.isEmpty {
            urlComponents.queryItems = parameters
                .sorted { isSortedDesc ? $0.key > $1.key : $0.key < $1.key}
                .map { URLQueryItem(name: $0.key, value: String(describing: $0.value)) }
            urlRequest.url = urlComponents.url
        }
    }
    
    func jsonParser<T: Codable>(tyeof: T.Type, data: Data) throws -> T? {
        do {
            let object = try JSONDecoder().decode(tyeof.self, from: data)
            return object
        } catch let error {
            throw NetworkError.parsingError(error)
        }
    }
    
    func encode<T: Codable>(urlRequest: inout URLRequest,
                                          with object: T)  throws {
        do {
            let jsonData = try JSONEncoder().encode(object.self)
            urlRequest.httpBody = jsonData
        } catch {
            throw NetworkError.responseError
        }
    }
}
