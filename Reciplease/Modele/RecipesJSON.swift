//
//  RecipesJson.swift
//  Reciplease
//
//  Created by Johann Petzold on 08/09/2021.
//

import Foundation

class RecipesJSON: Decodable {
    var from: Int
    var to: Int
    var count: Int
    var _links: Links
    var hits: [RecipeJSON]
}

class Links: Decodable {
    var next: NextLink
}

class NextLink: Decodable {
    var href: String
}

class RecipeJSON: Decodable {
    var recipe: RecipeData
}

class RecipeData: Decodable {
    var label: String
    var image: String
    var source: String
    var url: String
    var ingredientLines: [String]
    var ingredients: [Ingredient]
    var totalTime: Double
    var yield: Double
}

class Ingredient: Decodable {
    var text: String
}
