//
//  ManageFavoriteViewController.swift
//  Reciplease
//
//  Created by Johann Petzold on 27/09/2021.
//

import UIKit

class ManageFavoriteViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func manageFavorite(dbHelper: CoreDataHelper, recipe: Recipe, button: FavoriteBarButton) {
        dbHelper.isInDatabase(recipe: recipe) { result in
            if result {
                dbHelper.deleteRecipe(recipe: recipe) { success in
                    button.modifyState(!success)
                }
            } else {
                dbHelper.saveRecipe(recipe: recipe) { success in
                    button.modifyState(success)
                }
            }
        }
    }
}
