//
//  ItemCell.swift
//  BakeryApp
//
//  Created by Abhishek Kumar on 19/03/22.
//

import UIKit

protocol ItemCellDelegate: AnyObject {
    func showDetails(indexPath: IndexPath?)
}

class ItemCell: UICollectionViewCell {
    
    static let identifier = "ItemCell"
    
    weak var delegate: ItemCellDelegate?
    
    private var currentIndexPath: IndexPath?
    
    private lazy var itemName: PaddingLabel = {
        $0.textAlignment = .left
        $0.contentMode = .scaleAspectFit
        return $0
    }(PaddingLabel())
    
    private lazy var type: PaddingLabel = {
        $0.textAlignment = .left
        $0.contentMode = .scaleAspectFit
        return $0
    }(PaddingLabel())
    
    lazy var button: UIButton = {
        $0.setTitle("Show Details", for: .normal)
        $0.backgroundColor = .link
        $0.setTitleColor(UIColor.white, for: .normal)
        $0.layer.cornerRadius = 18
        $0.contentMode = .scaleAspectFit
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.addTarget(self, action: #selector(touchDownAnimation(_:)), for: .touchDown)
        $0.addTarget(self, action: #selector(touchupInside(_:)), for: .touchUpInside)
        return $0
    }(UIButton())
    
    private lazy var stackview: UIStackView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.axis = .vertical
        $0.spacing = 20
        $0.distribution = .fill
        return $0
    }(UIStackView(arrangedSubviews: [itemName, type]))
    
    lazy var backgroundImageView: UIImageView = {
        $0.clipsToBounds = true
        $0.contentMode = .scaleAspectFill
        return $0
    }(UIImageView(image: UIImage(named: "bakery")!))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupview()
    }
    
    required init?(coder: NSCoder) {
        fatalError("failed to init")
    }
    
    override func prepareForReuse() {
        type.text = nil
        backgroundImageView.image = nil
        itemName.text = nil
    }
}


extension ItemCell {
    
    private func setupview() {
        self.dropShadow()
        backgroundView = backgroundImageView
        addSubview(stackview)
        addSubview(button)
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([stackview.leadingAnchor.constraint(equalTo: self.leadingAnchor,
                                                                        constant: 10),
                                     stackview.trailingAnchor.constraint(equalTo: self.trailingAnchor,
                                                                         constant: -10),
                                     stackview.topAnchor.constraint(equalTo: self.topAnchor,
                                                                    constant: 20),
                                     stackview.bottomAnchor.constraint(lessThanOrEqualTo: button.topAnchor,
                                                                       constant: 20)])
        NSLayoutConstraint.activate([button.leadingAnchor.constraint(equalTo: self.leadingAnchor,
                                                                     constant: 10),
                                     button.bottomAnchor.constraint(equalTo: self.bottomAnchor,
                                                                    constant: -15),
                                     button.widthAnchor.constraint(equalToConstant: 150)])
    }
    
    func setup(data: ItemCellDetail) {
        currentIndexPath = data.indexPath
        let placeHolderName = NSMutableAttributedString(string: "Item name ",
                                                    attributes: [.font: UIFont.systemFont(ofSize: 16, weight: .bold),
                                                                 .foregroundColor: UIColor.white])
        let name = NSAttributedString(string: data.name,
                                      attributes: [.font: UIFont.systemFont(ofSize: 18, weight: .bold), .foregroundColor: UIColor.white])
        placeHolderName.append(name)
        itemName.attributedText = placeHolderName
        
        let placeHolderType = NSMutableAttributedString(string: "Item Type ",
                                                        attributes: [.font: UIFont.systemFont(ofSize: 16, weight: .bold), .foregroundColor: UIColor.white])
        let type = NSAttributedString(string: data.type, attributes: [.font: UIFont.systemFont(ofSize: 18, weight: .bold), .foregroundColor: UIColor.white])
        placeHolderType.append(type)
        self.type.attributedText = placeHolderType
    }
    
    @objc func touchDownAnimation(_ sender: UIButton) {
        sender.animateButtonDown()
    }
    
    @objc func touchupInside(_ sender: UIButton) {
        sender.animateButtonUp()
        delegate?.showDetails(indexPath: currentIndexPath)
    }
}
