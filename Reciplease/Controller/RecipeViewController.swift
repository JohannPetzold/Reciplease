//
//  RecipeViewController.swift
//  Reciplease
//
//  Created by Johann Petzold on 02/09/2021.
//

import UIKit

class RecipeViewController: UIViewController {

    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var likeLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var favoriteButton: UIBarButtonItem!
    
    var recipe: Recipe!
    private var cellIdentifier = "IngredientCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        
        configure()
    }
    
    private func configure() {
        titleLabel.text = recipe.title
        likeLabel.text = "\(recipe.score)"
        durationLabel.text = recipe.preparationTime.getStringTime()
        recipeImage.image = recipe.image
        recipeImage.addShadowGradient(width: self.view.bounds.width, height: self.view.bounds.width / 2)
        modifyFavoriteButton()
    }
}

// MARK: - Favorite
extension RecipeViewController {
    
    @IBAction func favoriteButtonPressed(_ sender: UIBarButtonItem) {
        manageFavorite()
    }
    
    private func manageFavorite() {
        if Favorite.shared.recipes.contains(where: { tabRecipe in
            tabRecipe.title == recipe.title
        }) {
            Favorite.shared.recipes.removeAll { tabRecipe in
                tabRecipe.title == recipe.title
            }
        } else {
            Favorite.shared.recipes.append(recipe)
        }
        modifyFavoriteButton()
    }
    
    private func modifyFavoriteButton() {
        if Favorite.shared.recipes.contains(where: { tabRecipe in
            tabRecipe.title == recipe.title
        }) {
            favoriteButton.image = UIImage(systemName: "star.fill")
            favoriteButton.tintColor = .green
        } else {
            favoriteButton.image = UIImage(systemName: "star")
            favoriteButton.tintColor = .gray
        }
    }
}

// MARK: - UITableViewDataSource
extension RecipeViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // TODO: Add precise ingredients
        return recipe.ingredients.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? IngredientTableViewCell else {
            return UITableViewCell()
        }

        // TODO: Add precise ingredients
        let ingredient = recipe.ingredients[indexPath.row]
        cell.configure(ingredient: ingredient)

        return cell
    }
}
