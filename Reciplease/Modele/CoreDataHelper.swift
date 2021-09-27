//
//  CoreDataHelper.swift
//  CoreDataHelper
//
//  Created by Johann Petzold on 15/09/2021.
//

import Foundation
import CoreData

class CoreDataHelper {
    
    private let context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    // Save recipe into database
    func saveRecipe(recipe: Recipe, completion: (_ success: Bool) -> Void) {
        let favorite = FavoriteRecipe(context: context)
        favorite.getDataFromRecipe(recipe: recipe)
        do {
            try context.save()
            completion(true)
        } catch {
            completion(false)
        }
    }
    
    // Delete recipe from database
    func deleteRecipe(recipe: Recipe, completion: (_ success: Bool) -> Void) {
        let request: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "FavoriteRecipe")
        request.predicate = NSPredicate(format: "title == %@", recipe.title)
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: request)
        do {
            try context.execute(deleteRequest)
            completion(true)
        } catch {
            completion(false)
        }
    }
    
    // Check if recipe is in database
    func isInDatabase(recipe: Recipe, completion: (_ result: Bool) -> Void) {
        let request: NSFetchRequest<FavoriteRecipe> = FavoriteRecipe.fetchRequest()
        request.predicate = NSPredicate(format: "title == %@", recipe.title)
        guard let result = try? context.fetch(request) else {
            completion(false)
            return
        }
        if result.first?.title == recipe.title {
            completion(true)
        } else {
            completion(false)
        }
    }
    
    // Get all recipes stored in database
    func getAllRecipes(completion: (_ recipes: [Recipe]) -> Void) {
        let request: NSFetchRequest<FavoriteRecipe> = FavoriteRecipe.fetchRequest()
        guard let favorites = try? context.fetch(request) else {
            completion([])
            return
        }
        var recipes = [Recipe]()
        for favorite in favorites {
            recipes.append(Recipe(favoriteRecipe: favorite))
        }
        completion(recipes)
    }
}
