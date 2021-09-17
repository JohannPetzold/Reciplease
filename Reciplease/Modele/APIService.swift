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
    
    func fetchRecipes(with ingredients: [String], completion: @escaping (_ recipes: [Recipe]?) -> Void) {
        let parameters = APIRequest.createParameters(with: ingredients)
        session.requestData(apiUrl: APIRequest.apiURL, parameters: parameters) { recipes in
            if let recipesJson = recipes {
                var result = [Recipe]()
                for recipe in recipesJson {
                    result.append(Recipe(recipeJson: recipe.recipe))
                }
                completion(result)
            } else {
                completion(nil)
            }
        }
    }
}
