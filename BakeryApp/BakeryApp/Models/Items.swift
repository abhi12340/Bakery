//
//  Items.swift
//  BakeryApp
//
//  Created by Abhishek Kumar on 18/03/22.
//

import Foundation

// MARK: - WelcomeElement
struct Item: Codable {
    let id, type, name: String
    let ppu: Double
    let batters: Batters
    let topping: [Topping]
}

// MARK: - Batters
struct Batters: Codable {
    let batter: [Topping]
}

// MARK: - Topping
struct Topping: Codable {
    let id, type: String
}

typealias Items = [Item]
