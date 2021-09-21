//
//  APIService.swift
//  Reciplease
//
//  Created by Johann Petzold on 17/09/2021.
//

import Foundation

class APIService {
    
    private let session: NetworkSession
    
    init(session: NetworkSession) {
        self.session = session
    }
    
    // Get recipes from NetworkSession with given url and ingredients
    func fetchRecipes(apiUrl: String = APIRequest.apiURL, with ingredients: [String] = [], completion: @escaping (_ recipes: [Recipe]?, _ nextUrl: String?) -> Void) {
        let parameters = ingredients.isEmpty ? [:] : APIRequest.createParameters(with: ingredients)
        session.requestData(apiUrl: apiUrl, parameters: parameters) { recipes, nextUrl in
            if let recipesJson = recipes {
                var result = [Recipe]()
                for recipe in recipesJson {
                    result.append(Recipe(recipeJson: recipe.recipe))
                }
                completion(result, nextUrl)
            } else {
                completion(nil, nil)
            }
        }
    }
}
