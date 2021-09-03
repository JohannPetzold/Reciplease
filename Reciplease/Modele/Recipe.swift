//
//  Recipe.swift
//  Reciplease
//
//  Created by Johann Petzold on 03/09/2021.
//

import Foundation
import UIKit

class Recipe {
    
    var title: String
    var image: UIImage?
    var ingredients: [String]
    var preparationTime: Int
    var score: Int
    
    init(title: String, image: UIImage? = nil, ingredients: [String], preparationTime: Int, score: Int) {
        self.title = title
        self.ingredients = ingredients
        self.preparationTime = preparationTime
        self.score = score
        
        if image == nil {
            self.image = UIImage.getGenericMealImage()
        } else {
            self.image = image
        }
    }
    
    // Testing Data
    static var recipeList: [Recipe] = [
        Recipe(title: "Pizza", ingredients: ["Mozzarella", "Basilic", "Tomatoes"], preparationTime: 15, score: 300),
        Recipe(title: "Pasta Salad", ingredients: ["Pasta", "Salad", "Tomatoes"], preparationTime: 20, score: 450),
        Recipe(title: "Tomato Soup", image: UIImage(named: "Tomato Soup"), ingredients: ["Cream", "Tomatoes", "Feta"], preparationTime: 15, score: 490)
    ]
}
