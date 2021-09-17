//
//  FavoriteRecipeTests.swift
//  RecipleaseTests
//
//  Created by Johann Petzold on 14/09/2021.
//

import XCTest
import UIKit
import CoreData
@testable import Reciplease

class FavoriteRecipeTests: XCTestCase {

    func testGivenFavoriteRecipeWhenSavingIntoCoreDataThenShouldFetch() {
        let context = TestCoreDataStack().persistentContainer.viewContext
        let favorite = FavoriteRecipe(context: context)
        favorite.getDataFromRecipe(recipe: Recipe.getTestRecipe1())
        try! context.save()
        
        let request: NSFetchRequest<FavoriteRecipe> = FavoriteRecipe.fetchRequest()
        request.predicate = NSPredicate(format: "title == %@", "Test")
        let result = try? context.fetch(request)
        let finalRecipe = result?.first
        
        XCTAssertEqual(finalRecipe?.title, favorite.title)
        XCTAssertEqual(finalRecipe?.ingredients, favorite.ingredients)
    }
}
