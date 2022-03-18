//
//  NetworkProtocol.swift
//  BakeryApp
//
//  Created by Abhishek Kumar on 18/03/22.
//

import Foundation

protocol NetworkProtocol {
    func request<T: Codable>(routerRequest: URLRequestConvertible,
                             type: T.Type,
                             completionHandler: @escaping(Result<T, NetworkError>) -> ())
}
