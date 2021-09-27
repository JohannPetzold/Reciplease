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
    var yield: Int
    var sourceUrl: String
    
    init(title: String, imageData: Data? = nil, imageUrl: String = "", ingredients: [String], preparationTime: Int, score: Int, yield: Int, sourceUrl: String = "") {
        self.title = title
        self.imageData = imageData
        self.ingredients = ingredients
        self.preparationTime = preparationTime
        self.score = score
        self.yield = yield
        self.sourceUrl = sourceUrl
    }
    
    // Init from JSON data
    init(recipeJson: RecipeData) {
        title = recipeJson.label
        for ingredient in recipeJson.ingredients {
            ingredients.append(ingredient.text)
        }
        detailIngredients = recipeJson.ingredientLines
        preparationTime = Int(recipeJson.totalTime)
        score = 0
        imageUrl = recipeJson.image
        yield = Int(recipeJson.yield)
        sourceUrl = recipeJson.url
    }
    
    // Init from CoreData Recipe
    init(favoriteRecipe: FavoriteRecipe) {
        title = favoriteRecipe.title ?? ""
        imageData = favoriteRecipe.image ?? nil
        imageUrl = favoriteRecipe.imageUrl ?? ""
        if let favoriteIngredients = favoriteRecipe.ingredients {
            if let newIngredients = try? JSONDecoder().decode([String].self, from: favoriteIngredients) {
                ingredients = newIngredients
            }
        }
        if let favoriteDetailIngredients = favoriteRecipe.detailIngredients {
            if let newDetailIngredients = try? JSONDecoder().decode([String].self, from: favoriteDetailIngredients) {
                detailIngredients = newDetailIngredients
            }
        }
        preparationTime = Int(favoriteRecipe.preparationTime)
        score = Int(favoriteRecipe.score)
        yield = Int(favoriteRecipe.yield)
        sourceUrl = favoriteRecipe.sourceUrl ?? ""
    }
    
    // Recipe for Units Tests
    static func getTestRecipe1() -> Recipe {
        let recipe = Recipe(title: "Test", imageData: Data(), imageUrl: "test", ingredients: ["Test1", "Test2"], preparationTime: 20, score: 20, yield: 4)
        return recipe
    }
}
