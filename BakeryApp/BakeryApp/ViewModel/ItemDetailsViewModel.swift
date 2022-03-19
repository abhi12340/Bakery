//
//  ItemDetaisViewModel.swift
//  BakeryApp
//
//  Created by Abhishek Kumar on 19/03/22.
//

import Foundation

class ItemDetailsViewModel {
    
    private var item: Item?
    private var expandableDataSource: [Expandable]
    
    init(item: Item?) {
        self.item = item
        self.expandableDataSource = [Expandable(title: item?.name, rows: nil, isExpanded: false),
                                     Expandable(title: item?.type, rows: nil, isExpanded: false),
                                     Expandable(title: "\(item?.ppu ?? 0)", rows: nil, isExpanded: false),
                                     Expandable(title: "Batters", rows: item?.batters.batter, isExpanded: true),
                                     Expandable(title: "Toppings", rows: item?.topping, isExpanded: true)]
    }
    
    func getNumberOfSection() -> Int {
        return expandableDataSource.count
    }
    
    func getDatasource() -> [Expandable] {
        return expandableDataSource
    }
    
    func updateExpandedState(at pos: Int, with state: Bool) {
        expandableDataSource[pos].isExpanded = state
    }
}
