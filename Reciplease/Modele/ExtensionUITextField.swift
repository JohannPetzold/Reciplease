//
//  ExtensionUITextField.swift
//  Reciplease
//
//  Created by Johann Petzold on 03/09/2021.
//

import Foundation
import UIKit

extension UITextField {
    
    // Add bottom line. Change shortLine and bottomPixel to customize
    func addBottomLine() {
        let shortLine: CGFloat = 8
        let bottomPixel: CGFloat = 2
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: shortLine / 2, y: self.frame.size.height + bottomPixel, width: self.frame.size.width - shortLine, height: 1)
        bottomLine.backgroundColor = UIColor.gray.withAlphaComponent(0.5).cgColor
        borderStyle = .none
        layer.addSublayer(bottomLine)
    }
}
