//
//  NetworkManager.swift
//  BakeryApp
//
//  Created by Abhishek Kumar on 18/03/22.
//

import Foundation

final class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() {
        
    }
    
    private let sessionManager: URLSession = {
        let config = URLSessionConfiguration.default
        config.requestCachePolicy = .reloadIgnoringLocalCacheData
        config.timeoutIntervalForRequest = NetworkConstants.requestTimeout
        config.timeoutIntervalForResource = NetworkConstants.responseTimeOut
        return URLSession(configuration: config)
    }()
    
    private var task: URLSessionTask?
    
    func request<T: Codable>(routerRequest: URLRequestConvertible, type: T.Type,
                    completionHandler: @escaping (Result<T, NetworkError>) -> ()) {
        do {
            let request = try routerRequest.asURLRequest()
            task = sessionManager.dataTask(with: request) { data, response, error in
                guard let httpResponse = response as? HTTPURLResponse,
                      200...299 ~= httpResponse.statusCode else {
                    completionHandler(.failure(.responseError))
                    return
                }
                do {
                    guard let data = data,
                          let decodedJson = try routerRequest
                          .jsonParser(tyeof: T.self, data: data) else {
                        return
                    }
                    completionHandler(.success(decodedJson))
                    
                } catch let error {
                    completionHandler(.failure(.parsingError(error)))
                }
            }
        } catch {
            completionHandler(.failure(.invalidURL))
        }
        task?.resume()
    }
}
