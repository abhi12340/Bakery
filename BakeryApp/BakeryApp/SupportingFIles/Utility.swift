//
//  Utility.swift
//  BakeryApp
//
//  Created by Abhishek Kumar on 19/03/22.
//

import UIKit

struct Utility {
    
    static func showAlert(with message: String) -> UIAlertController {
        let alertController = UIAlertController(title: "Alert",
                                      message: message,
                                      preferredStyle: .alert)
        let action = UIAlertAction(title: "Dismiss", style: .cancel)
        alertController.addAction(action)
        return alertController
    }
}
