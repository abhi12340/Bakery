//
//  HttpMethods.swift
//  BakeryApp
//
//  Created by Abhishek Kumar on 18/03/22.
//

import Foundation

import Foundation


typealias HTTPHeaders = [String: String]

typealias Parameters = [String: Any]

enum HTTPMethod: String {
    case get  = "GET"
    case post = "POST"
}
