//
//  UIButton+Render.swift
//  FriendList
//
//  Created by Rita Huang on 2025/6/8.
//


import UIKit

extension UIButton {
    
    func setGradientBackground(startColor: UIColor, endColor: UIColor) {
        self.layer.sublayers?.removeAll(where: { $0.name == "gradientLayer" })
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.name = "gradientLayer"
        gradientLayer.frame = self.bounds
        gradientLayer.cornerRadius = self.layer.cornerRadius
        gradientLayer.colors = [startColor.cgColor, endColor.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
}
