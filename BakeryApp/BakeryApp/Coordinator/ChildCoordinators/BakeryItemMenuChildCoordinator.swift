//
//  BakeryItemMenuChildCoordinator.swift
//  BakeryApp
//
//  Created by Abhishek Kumar on 18/03/22.
//

import Foundation
import UIKit

class BakeryItemMenuChildCoordinator : ChildCoordinator {

    weak var parentCoordinator: ParentCoordinator?
    var navigationController: UINavigationController

    init(with _navigationController: UINavigationController){
        self.navigationController = _navigationController
    }

    func configureChildViewController() {

        let itemVC = BakeryItemMenuController()
        itemVC.bakeryItemMenuChildCoordinator = self
        self.navigationController.pushViewController(itemVC, animated: false)
    }

    func presentItemDetailVC(item: Item) {
        guard let parentCoordinator = parentCoordinator else {
            fatalError("Parent coordinator is nil")
        }
        let itemDetailsCoordinator = ChildCoordinatorFactory.create(with: parentCoordinator.navigationController, type: .itemDetails)
        itemDetailsCoordinator.passParameter(value: ItemDetailParameter(item: item))
        parentCoordinator.childCoordinator.append(itemDetailsCoordinator)
        itemDetailsCoordinator.parentCoordinator = parentCoordinator
        itemDetailsCoordinator.configureChildViewController()
    }
    
    func presentAlert(message: String) {
        self.navigationController.present(Utility.showAlert(with: message), animated: true,
                                          completion: nil)
    }
}
