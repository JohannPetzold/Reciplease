//
//  ResponseDataMock.swift
//  RecipleaseTests
//
//  Created by Johann Petzold on 19/09/2021.
//

import Foundation
@testable import Reciplease

class ResponseDataMock {
    
    static func loadRecipesData(filename: String) -> RecipesJSON? {
        let bundle = Bundle(for: ResponseDataMock.self)
        guard let url = bundle.url(forResource: filename, withExtension: "json") else { return nil }
        guard let data = try? Data(contentsOf: url) else { return nil }
        guard let recipe = try? JSONDecoder().decode(RecipesJSON.self, from: data) else { return nil }
        return recipe
    }
}
