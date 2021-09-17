//
//  APIRequest.swift
//  APIRequest
//
//  Created by Johann Petzold on 07/09/2021.
//

import Foundation

struct APIRequest {
    
    static var apiURL = "https://api.edamam.com/api/recipes/v2"
    
    enum apiKey: String {
        case type = "type"
        case query = "q"
        case appId = "app_id"
        case appKey = "app_key"
    }
    
    enum apiValue: String {
        case type = "public"
    }
    
    static func createParameters(with ingredients: [String]) -> [String: String] {
        var result: [String: String] = [:]
        result[apiKey.type.rawValue] = apiValue.type.rawValue
        result[apiKey.query.rawValue] = APIRequest.queryIngredients(ingredients: ingredients)
        result[apiKey.appId.rawValue] = APPID
        result[apiKey.appKey.rawValue] = APPKEY
        
        return result
    }
    
    static func queryIngredients(ingredients: [String]) -> String {
        guard ingredients.count > 0 else { return "" }
        var result = ""
        for x in 0..<ingredients.count {
            result += ingredients[x]
            if x < ingredients.count - 1 {
                result += ", "
            }
        }
        return result
    }
}
