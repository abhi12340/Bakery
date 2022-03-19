//
//  PaddingLabel.swift
//  BakeryApp
//
//  Created by Abhishek Kumar on 19/03/22.
//

import UIKit

class PaddingLabel: UILabel {
    
    let topInset: CGFloat
    let bottomInset: CGFloat
    let leftInset: CGFloat
    let rightInset: CGFloat
    
    init(topInset: CGFloat = 5.0,
         bottomInset: CGFloat = 5.0,
         leftInset: CGFloat = 7.0,
         rightInset: CGFloat = 7.0) {
        self.topInset = topInset
        self.bottomInset = bottomInset
        self.leftInset = leftInset
        self.rightInset = rightInset
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("failed to init")
    }
    
    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets(top: topInset,
                                  left: leftInset,
                                  bottom: bottomInset,
                                  right: rightInset)
        super.drawText(in: rect.inset(by: insets))
    }
    
    override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        return CGSize(width: size.width + leftInset + rightInset,
                      height: size.height + topInset + bottomInset)
    }
    
    override var bounds: CGRect {
        didSet {
            preferredMaxLayoutWidth = bounds.width - (leftInset + rightInset)
        }
    }
    
}
