//
//  CoreDataHelperTests.swift
//  CoreDataHelperTests
//
//  Created by Johann Petzold on 15/09/2021.
//

import XCTest
@testable import Reciplease
import CoreData

class CoreDataHelperTests: XCTestCase {

    func testWhenUsingSaveRecipeThenCompletionIsTrue() {
        let helper = CoreDataHelper(context: TestCoreDataStack().persistentContainer.newBackgroundContext())
        let recipe = Recipe.getTestRecipe1()
        
        let expectation = expectation(description: "Wait for context")
        helper.saveRecipe(recipe: recipe) { success in
            XCTAssertEqual(success, true)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testWhenUsingSaveRecipeWithBadContextThenCompletionIsFalse() {
        let helper = CoreDataHelper(context: TestCoreDataStack().badPersistentContainer.newBackgroundContext())
        let recipe = Recipe.getTestRecipe1()
        
        let expectation = expectation(description: "Wait for context")
        helper.saveRecipe(recipe: recipe) { success in
            XCTAssertEqual(success, false)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testWhenUsingDeleteThenCompletionIsTrue() {
        let helper = CoreDataHelper(context: TestCoreDataStack().persistentContainer.newBackgroundContext())
        let recipe = Recipe.getTestRecipe1()
        
        let expectation = expectation(description: "Wait for context")
        helper.deleteRecipe(recipe: recipe) { success in
            XCTAssertEqual(success, true)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testWhenUsingDeleteWithBadContextThenCompletionIsFalse() {
        let helper = CoreDataHelper(context: TestCoreDataStack().badPersistentContainer.newBackgroundContext())
        let recipe = Recipe.getTestRecipe1()
        
        let expectation = expectation(description: "Wait for context")
        helper.deleteRecipe(recipe: recipe) { success in
            XCTAssertEqual(success, false)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testWhenRecipeIsInDatabaseThenCompletionIsTrue() {
        let helper = CoreDataHelper(context: TestCoreDataStack().persistentContainer.newBackgroundContext())
        let recipe = Recipe.getTestRecipe1()
        
        let expectation = expectation(description: "Wait for context")
        helper.saveRecipe(recipe: recipe) { success in
            if success {
                helper.isInDatabase(recipe: recipe) { result in
                    XCTAssertEqual(result, true)
                    expectation.fulfill()
                }
            }
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testWhenRecipeIsNotInDatabaseThenCompletionIsFalse() {
        let helper = CoreDataHelper(context: TestCoreDataStack().persistentContainer.newBackgroundContext())
        let recipe = Recipe.getTestRecipe1()
        
        let expectation = expectation(description: "Wait for context")
        helper.isInDatabase(recipe: recipe) { result in
            XCTAssertEqual(result, false)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testWhenBadContextThenIsInDatabaseCompletionIsFalse() {
        let helper = CoreDataHelper(context: TestCoreDataStack().badPersistentContainer.newBackgroundContext())
        let recipe = Recipe.getTestRecipe1()
        
        let expectation = expectation(description: "Wait for context")
        helper.isInDatabase(recipe: recipe) { result in
            XCTAssertEqual(result, false)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testWhenUsingGetAllRecipesWithStoredDataThenCompletionIsRecipes() {
        let helper = CoreDataHelper(context: TestCoreDataStack().persistentContainer.newBackgroundContext())
        let recipe = Recipe.getTestRecipe1()
        
        let expectation = expectation(description: "Wait for context")
        helper.saveRecipe(recipe: recipe) { success in
            if success {
                helper.getAllRecipes { recipes in
                    XCTAssertEqual(recipes.first?.title, recipe.title)
                    expectation.fulfill()
                }
            }
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetAllRecipesCompletionShouldBeEmptyWithBadContext() {
        let helper = CoreDataHelper(context: TestCoreDataStack().badPersistentContainer.newBackgroundContext())
        
        let expectation = expectation(description: "Wait for context")
        helper.getAllRecipes { recipes in
            XCTAssertEqual(recipes.count, 0)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
}
