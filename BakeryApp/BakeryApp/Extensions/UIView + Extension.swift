//
//  UIView + Extension.swift
//  BakeryApp
//
//  Created by Abhishek Kumar on 19/03/22.
//

import UIKit

extension UIView  {
    
    func dropShadow() {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOpacity = 1
        layer.shadowOffset = CGSize(width: -1, height: 1)
        layer.shadowRadius = 2
        layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = UIScreen.main.scale
    }
    
    
    func animateButtonDown() {

        UIView.animate(withDuration: 0.1, delay: 0.0, options: [.allowUserInteraction, .curveEaseIn], animations: {
            self.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        }, completion: nil)
    }

    func animateButtonUp() {

        UIView.animate(withDuration: 0.1, delay: 0.0, options: [.allowUserInteraction, .curveEaseOut], animations: {
            self.transform = CGAffineTransform.identity
        }, completion: nil)
    }
}
