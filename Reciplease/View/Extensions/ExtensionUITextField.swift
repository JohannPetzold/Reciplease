//
//  ExtensionUITextField.swift
//  Reciplease
//
//  Created by Johann Petzold on 03/09/2021.
//

import Foundation
import UIKit

extension UITextField {
    
    // Add bottom line
    func addBottomLine(shortLine: CGFloat, bottomPosition: CGFloat) {
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: shortLine / 2, y: self.frame.size.height + bottomPosition, width: self.frame.size.width - shortLine, height: 1)
        bottomLine.backgroundColor = UIColor.gray.withAlphaComponent(0.5).cgColor
        borderStyle = .none
        layer.addSublayer(bottomLine)
    }
}
