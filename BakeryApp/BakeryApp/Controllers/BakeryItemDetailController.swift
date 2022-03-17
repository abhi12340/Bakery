//
//  BakeryItemDetailController.swift
//  BakeryApp
//
//  Created by Abhishek Kumar on 18/03/22.
//

import UIKit

class BakeryItemDetailController: UIViewController {

    weak var bakeryItemDetailChildCoordinator: BakeryItemDetailChildCoordinator?
    var titleValue: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        navigationItem.title = titleValue
        let button = UIButton(frame: CGRect(origin: view.center, size: CGSize(width: 150, height: 50)))
        button.setTitle("Dissmiss", for: .normal)
        view.addSubview(button)
        button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
    }

    @objc func buttonTapped(_ sender: UIButton) {
        bakeryItemDetailChildCoordinator?.dismissItemDetails()
    }
}
