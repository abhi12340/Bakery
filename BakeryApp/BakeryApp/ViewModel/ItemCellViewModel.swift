//
//  ItemCellViewModel.swift
//  BakeryApp
//
//  Created by Abhishek Kumar on 19/03/22.
//

import Foundation

struct ItemCellDetail {
    let name: String
    let type: String
    let indexPath: IndexPath
}

struct ItemCellViewModel {
    
    let item: Item
    let indexPath: IndexPath
    
    var itemCellDetail: ItemCellDetail {
        return ItemCellDetail(name: item.name,
                              type: item.type,
                              indexPath: indexPath)
    }
    
}
