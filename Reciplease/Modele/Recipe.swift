//
//  Recipe.swift
//  Reciplease
//
//  Created by Johann Petzold on 03/09/2021.
//

import Foundation

class Recipe {
    
    var title: String
    var imageData: Data?
    var imageUrl: String = ""
    var ingredients: [String] = []
    var detailIngredients: [String] = []
    var preparationTime: Int
    var score: Int
    
    init(title: String, imageData: Data? = nil, imageUrl: String = "", ingredients: [String], preparationTime: Int, score: Int) {
        self.title = title
        self.imageData = imageData
        self.ingredients = ingredients
        self.preparationTime = preparationTime
        self.score = score
    }
    
    init(recipeJson: RecipeData) {
        title = recipeJson.label
        for ingredient in recipeJson.ingredients {
            ingredients.append(ingredient.text)
        }
        detailIngredients = recipeJson.ingredientLines
        preparationTime = 0
        score = 0
        imageUrl = recipeJson.image
    }
    
    init(favoriteRecipe: FavoriteRecipe) {
        title = favoriteRecipe.title ?? ""
        imageData = favoriteRecipe.image ?? nil
        imageUrl = favoriteRecipe.imageUrl ?? ""
        if let favoriteIngredients = favoriteRecipe.ingredients {
            do {
                ingredients = try JSONDecoder().decode([String].self, from: favoriteIngredients)
            } catch {
                ingredients = []
            }
        }
        if let favoriteDetailIngredients = favoriteRecipe.detailIngredients {
            do {
                detailIngredients = try JSONDecoder().decode([String].self, from: favoriteDetailIngredients)
            } catch {
                detailIngredients = []
            }
        }
        preparationTime = Int(favoriteRecipe.preparationTime)
        score = Int(favoriteRecipe.score)
    }
    
    func canBeCook(with ingredients: [String]) -> Bool {
        for ingredient in self.ingredients {
            if !ingredients.contains(ingredient) {
                return false
            }
        }
        print("DEBUG: \(self.title) can be cook")
        return true
    }
    
    static func getTestRecipe1() -> Recipe {
        let recipe = Recipe(title: "Test", imageData: Data(), imageUrl: "test", ingredients: ["Test1", "Test2"], preparationTime: 20, score: 20)
        return recipe
    }
}
