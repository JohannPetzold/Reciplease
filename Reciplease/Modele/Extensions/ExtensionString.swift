//
//  ExtensionString.swift
//  ExtensionString
//
//  Created by Johann Petzold on 06/09/2021.
//

import Foundation

extension String {
    
    func noAccent() -> String {
        return self.folding(options: .diacriticInsensitive, locale: .current)
    }
}
