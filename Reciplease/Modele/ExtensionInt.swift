//
//  ExtensionInt.swift
//  Reciplease
//
//  Created by Johann Petzold on 03/09/2021.
//

import Foundation

extension Int {
    
    // Display self in hour and min
    func getStringTime() -> String {
        var time = ""
        if self / 60 > 1 {
            let hour = self / 60
            time += "\(hour)h"
        }
        if self % 60 > 0 {
            let min = self % 60
            time += "\(min)min"
        }
        return time
    }
}
