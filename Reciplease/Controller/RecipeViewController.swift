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
    let dbHelper = CoreDataHelper(context: AppDelegate.viewContext)
    private var cellIdentifier = "IngredientCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configure()
    }
    
    private func configure() {
        titleLabel.text = recipe.title
        likeLabel.text = "\(recipe.score)"
        durationLabel.text = recipe.preparationTime.getStringTime()
        if let data = recipe.imageData {
            recipeImage.image = UIImage(data: data)
        }
        recipeImage.addShadowGradient(width: self.view.bounds.width, height: self.view.bounds.width / 2)
        dbHelper.isInDatabase(recipe: recipe, completion: { result in
            modifyFavoriteButton(isOn: result)
        })
    }
}

// MARK: - Favorite
extension RecipeViewController {
    
    @IBAction func favoriteButtonPressed(_ sender: UIBarButtonItem) {
        manageFavorite()
    }
    
    private func manageFavorite() {
        dbHelper.isInDatabase(recipe: recipe, completion: { result in
            modifyFavoriteButton(isOn: !result)
            if result {
                dbHelper.deleteRecipe(recipe: recipe) { success in
                    if !success {
                        // TODO: Display error message
                    }
                }
            } else {
                dbHelper.saveRecipe(recipe: recipe) { success in
                    if !success {
                        // TODO: Display error message
                    }
                }
            }
        })
    }
    
    private func modifyFavoriteButton(isOn: Bool) {
        if isOn {
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
        return recipe.detailIngredients.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? IngredientTableViewCell else {
            return UITableViewCell()
        }

        let ingredient = recipe.detailIngredients[indexPath.row]
        cell.configure(ingredient: ingredient)

        return cell
    }
}
