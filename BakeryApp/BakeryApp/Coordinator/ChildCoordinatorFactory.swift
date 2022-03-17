//
//  ChildCoordinatorFactory.swift
//  BakeryApp
//
//  Created by Abhishek Kumar on 18/03/22.
//

import Foundation
import UIKit

enum ChildCoordinatorType {
    case items
    case itemDetails
}


class ChildCoordinatorFactory {

    static func create(with _navigationController: UINavigationController, type: ChildCoordinatorType) -> ChildCoordinator {

        switch type {
        case .items:
            return BakeryItemMenuChildCoordinator(with: _navigationController)
        case .itemDetails:
            return BakeryItemDetailChildCoordinator(with: _navigationController)
        }
    }
}
