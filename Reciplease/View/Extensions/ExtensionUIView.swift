//
//  ExtensionUIView.swift
//  Reciplease
//
//  Created by Johann Petzold on 03/09/2021.
//

import Foundation
import UIKit

extension UIView {
    
    // Add black shadow gradient to the view with specific width and height
    static func addShadowGradient(width: CGFloat, height: CGFloat) -> UIView {
        let gradient = CAGradientLayer()
        gradient.frame = CGRect(x: 0, y: 0, width: width, height: height)
        let startColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0).cgColor
        let middleColor = UIColor.black.withAlphaComponent(0.1).cgColor
        let endColor = UIColor.black.withAlphaComponent(0.8).cgColor
        gradient.colors = [startColor, middleColor, endColor]
        let view = UIView()
        view.layer.insertSublayer(gradient, at: 0)
        return view
    }
}
