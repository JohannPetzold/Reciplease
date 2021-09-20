//
//  APIServiceTests.swift
//  RecipleaseTests
//
//  Created by Johann Petzold on 19/09/2021.
//

import XCTest
@testable import Reciplease

class APIServiceTests: XCTestCase {

    let recipeNextUrl = "https://api.edamam.com/api/recipes/v2?q=%22Chicken%22&app_key=91978e8bb198efaff212aaf566f93721&_cont=CHcVQBtNNQphDmgVQntAEX4BYldtBAAGRmxGC2ERYVJ2BwoVX3cVBWQSY1EhBQcGEmNHVmMTYFEgDQQCFTNJBGQUMQZxVhFqX3cWQT1OcV9xBB8VADQWVhFCPwoxXVZEITQeVDcBaR4-SQ%3D%3D&type=public&app_id=1729ac39"
    
    func testGivenGoodSessionWhenFetchingRecipesThenGetArrayOfRecipe() {
        guard let recipesJson = ResponseDataMock.loadRecipesData(filename: "Recipes") else { return }
        let recipes = recipesJson.hits
        let nextUrl = recipesJson._links.next.href
        let sessionMock = NetworkSessionMock(recipesJson: recipes, nextUrl: nextUrl)
        let service = APIService(session: sessionMock)
        
        service.fetchRecipes(with: []) { recipes, nextUrl in
            XCTAssertEqual(recipes?.first?.title, "Chicken Vesuvio")
            XCTAssertEqual(recipes?.first?.yield, 4)
            XCTAssertEqual(nextUrl, self.recipeNextUrl)
        }
    }
    
    func testGivenBadSessionWhenFetchingRecipesThenGetNil() {
        let sessionMock = NetworkSessionMock(recipesJson: nil, nextUrl: nil)
        let service = APIService(session: sessionMock)
        
        service.fetchRecipes(with: []) { recipes, nextUrl in
            XCTAssertNil(recipes)
            XCTAssertNil(nextUrl)
        }
    }
    
    func testGivenGoodSessionWhenFetchingRecipesFromUrlThenGetArrayOfRecipe() {
        guard let recipesJson = ResponseDataMock.loadRecipesData(filename: "Recipes") else { return }
        let recipes = recipesJson.hits
        let nextUrl = recipesJson._links.next.href
        let sessionMock = NetworkSessionMock(recipesJson: recipes, nextUrl: nextUrl)
        let service = APIService(session: sessionMock)
        
        service.fetchRecipesFromUrl(urlString: nextUrl) { recipes, nextUrl in
            XCTAssertEqual(recipes?.first?.title, "Chicken Vesuvio")
            XCTAssertEqual(recipes?.first?.yield, 4)
            XCTAssertEqual(nextUrl, self.recipeNextUrl)
        }
    }
    
    func testGivenBadSessionWhenFetchingRecipesWithUrlThenGetNil() {
        let sessionMock = NetworkSessionMock(recipesJson: nil, nextUrl: nil)
        let service = APIService(session: sessionMock)
        
        service.fetchRecipesFromUrl(urlString: "") { recipes, nextUrl in
            XCTAssertNil(recipes)
            XCTAssertNil(nextUrl)
        }
    }
}
