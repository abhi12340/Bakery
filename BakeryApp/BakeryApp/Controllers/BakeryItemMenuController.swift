//
//  BakeryItemMenuController.swift
//  BakeryApp
//
//  Created by Abhishek Kumar on 18/03/22.
//

import UIKit

class BakeryItemMenuController: UIViewController {

    weak var bakeryItemMenuChildCoordinator : BakeryItemMenuChildCoordinator?
    
    var viewmodel: ItemMenuViewModel!
    
    var itemlist = [Item]()
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        viewmodel = ItemMenuViewModel(networkService: NetworkManager.shared)
        super.viewDidLoad()
        view.backgroundColor = .white
        setupBinding()
        viewmodel.getItems()
    }
    
    func setupBinding() {
        viewmodel.datasource.subscribe { [weak self] result in
            self?.itemlist = result
            print(result.map { $0.name })
        }.disposed(by: disposeBag)
    }
}
