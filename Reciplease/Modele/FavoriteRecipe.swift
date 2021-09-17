//
//  FavoriteRecipe.swift
//  Reciplease
//
//  Created by Johann Petzold on 14/09/2021.
//

import Foundation
import CoreData
import UIKit

class FavoriteRecipe: NSManagedObject {
    
    func getDataFromRecipe(recipe: Recipe) {
        self.title = recipe.title
        self.image = recipe.imageData
        self.imageUrl = recipe.imageUrl
        self.ingredients = recipe.ingredients.description.data(using: String.Encoding.utf16)
        self.detailIngredients = recipe.detailIngredients.description.data(using: String.Encoding.utf16)
        self.preparationTime = Int16(recipe.preparationTime)
        self.score = Int32(recipe.score)
    }
}
