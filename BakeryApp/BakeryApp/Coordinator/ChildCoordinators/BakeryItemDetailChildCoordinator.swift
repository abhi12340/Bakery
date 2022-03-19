//
//  BakeryItemDetailChildCoordinator.swift
//  BakeryApp
//
//  Created by Abhishek Kumar on 18/03/22.
//


import Foundation
import UIKit

class BakeryItemDetailChildCoordinator : ChildCoordinator {

    weak var parentCoordinator: ParentCoordinator?
    var navigationController: UINavigationController
    var item: Item?
    init(with _navigationController: UINavigationController){
        self.navigationController = _navigationController
    }

    func configureChildViewController() {
        let itemDetail = BakeryItemDetailController()
        itemDetail.setupInital(data: item)
        itemDetail.isModalInPresentation = true
        itemDetail.bakeryItemDetailChildCoordinator = self
        self.navigationController.present(itemDetail, animated: true, completion: nil)
    }
    
    func passParameter(value: Decodable) {
        guard let parameter = value as? ItemDetailParameter else { return }
        item = parameter.item
    }
    
    func dismissItemDetails() {
        parentCoordinator?.removeChildCoordinator(child: self)
        navigationController.presentedViewController?.dismiss(animated: true, completion: nil)
    }
}
