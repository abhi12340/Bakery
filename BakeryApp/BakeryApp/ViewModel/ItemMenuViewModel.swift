//
//  ItemMenuViewModel.swift
//  BakeryApp
//
//  Created by Abhishek Kumar on 18/03/22.
//

import Foundation

class ItemMenuViewModel {
    
    private let networkService: NetworkProtocol
    
    init(networkService: NetworkProtocol) {
        self.networkService = networkService
    }
    
    var datasource = Variable<[Item]>([])
    var error = Variable<String>("")
    
    func getItems() {
        networkService.request(routerRequest: ItemRequest.get,
                                      type: Items.self) { [weak self] result in
            switch result {
            case .success(let items):
                self?.datasource.value = items
            case .failure(let error):
                self?.error.value = error.localizedDescription
            }
        }
    }
}
