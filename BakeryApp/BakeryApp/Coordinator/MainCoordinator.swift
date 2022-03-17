//
//  MainCoordinator.swift
//  BakeryApp
//
//  Created by Abhishek Kumar on 18/03/22.
//

import Foundation
import UIKit

class MainCoordinator : ParentCoordinator {

    var navigationController: UINavigationController
    var childCoordinator: [ChildCoordinator] = [ChildCoordinator]()

    init(with _navigationController : UINavigationController){
        self.navigationController = _navigationController
    }

    func configureRootViewController() {

        let itemListChildCoordinator = ChildCoordinatorFactory.create(with: self.navigationController, type: .items)
        childCoordinator.append(itemListChildCoordinator)
        itemListChildCoordinator.parentCoordinator = self
        itemListChildCoordinator.configureChildViewController()
        
    }

    func removeChildCoordinator(child: ChildCoordinator) {
        for(index, coordinator) in childCoordinator.enumerated() {
            if(coordinator === child) {
                childCoordinator.remove(at: index)
                break
            }
        }
    }
}
