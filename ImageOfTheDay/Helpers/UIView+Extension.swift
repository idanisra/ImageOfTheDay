//
//  UIView+Extension.swift
//  ImageOfTheDay
//
//  Created by Idan Israel on 18/04/2023.
//

import UIKit

extension UIView {
    
    func addShadows(shadowColor: CGColor = UIColor.black.cgColor, shadowOpacity: Float = 0.24, shadowRadius: CGFloat = 4) {
        layer.shadowColor = shadowColor
        layer.shadowOpacity = shadowOpacity
        layer.shadowOffset = .zero
        layer.shadowRadius = shadowRadius
        layer.shouldRasterize = true
        layer.rasterizationScale = UIScreen.main.scale
    }
}
