//
//  NetworkSessionMock.swift
//  RecipleaseTests
//
//  Created by Johann Petzold on 19/09/2021.
//

import Foundation
@testable import Reciplease

class NetworkSessionMock: NetworkSession {
    
    var recipesJson: [RecipeJSON]?
    var nextUrl: String?
    
    init(recipesJson: [RecipeJSON]?, nextUrl: String?) {
        self.recipesJson = recipesJson
        self.nextUrl = nextUrl
    }
    
    func requestData(apiUrl: String, parameters: [String : String], completion: @escaping ([RecipeJSON]?, String?) -> Void) {
        completion(recipesJson, nextUrl)
    }
}
