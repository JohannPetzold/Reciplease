//
//  ExtensionRecipe.swift
//  RecipleaseTests
//
//  Created by Johann Petzold on 28/09/2021.
//

import Foundation
@testable import Reciplease

extension Recipe {
    
    static func getTestRecipe1() -> Recipe {
        let recipe = Recipe(title: "Test", imageData: Data(), imageUrl: "test", ingredients: ["Test1", "Test2"], preparationTime: 20, score: 20, yield: 4)
        return recipe
    }
}
