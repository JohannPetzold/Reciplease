//
//  RecipeTests.swift
//  RecipeTests
//
//  Created by Johann Petzold on 06/09/2021.
//

import XCTest
@testable import Reciplease
import UIKit

class RecipeTests: XCTestCase {

    func testGivenIngredientsShouldGetRecipeWhenUsingCompare() {
        let recipe = Recipe(title: "Test", ingredients: ["Test1","Test2"], preparationTime: 20, score: 20)
        let recipe2 = Recipe(title: "Test2", imageData: Data(), ingredients: ["Test2", "Test4"], preparationTime: 30, score: 20)
        let ingredients = ["Test1", "Test2", "Test3"]
        
        XCTAssertTrue(recipe.canBeCook(with: ingredients))
        XCTAssertFalse(recipe2.canBeCook(with: ingredients))
    }
}
