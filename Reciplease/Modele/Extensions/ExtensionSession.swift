//
//  ExtensionSession.swift
//  Reciplease
//
//  Created by Johann Petzold on 17/09/2021.
//

import Foundation
import Alamofire

protocol NetworkSession {
    
    func requestData(apiUrl: String, parameters: [String: String], completion: @escaping (_ recipes: [RecipeJSON]?, _ nextUrl: String?) -> Void)
}

extension Session: NetworkSession {
    
    func requestData(apiUrl: String, parameters: [String : String], completion: @escaping ([RecipeJSON]?, String?) -> Void) {
        let request = Session.default.request(apiUrl, parameters: parameters)
        request.responseDecodable(of: RecipesJSON.self) { response in
            guard let recipes = response.value else {
                completion(nil, nil)
                return
            }
            let nextUrl = recipes._links.next.href
            completion(recipes.hits, nextUrl)
        }
    }
}
