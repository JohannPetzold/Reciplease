//
//  ExtensionUIImage.swift
//  Reciplease
//
//  Created by Johann Petzold on 03/09/2021.
//

import Foundation
import UIKit

extension UIImage {
    
    // Generate UIImage form generic images in Assets
    static func getGenericMealImage() -> UIImage? {
        let random = Int.random(in: 1...6)
        return UIImage(named: "GenericMeal\(random)")
    }
}
