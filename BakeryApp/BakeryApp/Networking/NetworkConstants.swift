//
//  NetworkConstants.swift
//  BakeryApp
//
//  Created by Abhishek Kumar on 18/03/22.
//

import Foundation

struct NetworkConstants {
    
    static let baseurl = "https://jsonkeeper.com/"
    static let requestHeaderContentTypeValue = "application/json"
    static let requestHeaderContentTypeKey = "Content-Type"
    static let relativePath = "b/6CG9"
    
    // MARK: - Request Timeout
    static let requestTimeout = 30.0
    static let responseTimeOut = 30.0
}
