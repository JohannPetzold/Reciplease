//
//  Favorite.swift
//  Reciplease
//
//  Created by Johann Petzold on 03/09/2021.
//

import Foundation

class Favorite {
    
    static var shared = Favorite()
    private init() { }
    
    var recipes: [Recipe] = []
}
