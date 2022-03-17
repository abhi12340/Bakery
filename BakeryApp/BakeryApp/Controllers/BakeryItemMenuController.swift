//
//  BakeryItemMenuController.swift
//  BakeryApp
//
//  Created by Abhishek Kumar on 18/03/22.
//

import UIKit

class BakeryItemMenuController: UIViewController {

    weak var bakeryItemMenuChildCoordinator : BakeryItemMenuChildCoordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Item Menu"
        view.backgroundColor = .red
        let button = UIButton(frame: CGRect(origin: view.center, size: CGSize(width: 150, height: 50)))
        button.setTitle("Click", for: .normal)
        view.addSubview(button)
        button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
    }

    @objc func buttonTapped(_ sender: UIButton) {
        bakeryItemMenuChildCoordinator?.presentItemDetailVC(itemName: "Pizza")
    }
}
