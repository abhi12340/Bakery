//
//  ItemRouter.swift
//  BakeryApp
//
//  Created by Abhishek Kumar on 18/03/22.
//

import Foundation

enum ItemRequest: URLRequestConvertible {
    
    case get
    
    func asURLRequest() throws -> URLRequest {
        var method: HTTPMethod {
            switch self {
            case .get:
                return .get
            }
        }
        
        var params: Parameters {
            switch self {
            case .get:
                return [:]
            }
        }
        
        var httpHeader: HTTPHeaders {
            switch self {
            case .get:
                return [NetworkConstants.requestHeaderContentTypeKey :           NetworkConstants.requestHeaderContentTypeValue]
            }
        }
        
        var url: URL {
            let url = URL(string: NetworkConstants.baseurl)!
            switch self {
            case .get:
                return url.appendingPathComponent(NetworkConstants.relativePath)
            }
        }
        
        var urlRequest = URLRequest(url: url, cachePolicy:
                                            .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 10.0)
        urlRequest.httpMethod = method.rawValue
        urlRequest.allHTTPHeaderFields = httpHeader
        try encode(urlRequest: &urlRequest, with: params)
        return urlRequest
    }
}
