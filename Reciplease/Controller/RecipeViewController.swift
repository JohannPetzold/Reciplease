//
//  RecipeViewController.swift
//  Reciplease
//
//  Created by Johann Petzold on 02/09/2021.
//

import UIKit

class RecipeViewController: ManageFavoriteViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var infosLabel: UILabel!
    @IBOutlet weak var ingredientsLabel: UILabel!
    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var favoriteButton: FavoriteBarButton!
    @IBOutlet weak var viewRecipeButton: RoundedButton!
    
    var recipe: Recipe!
    private let dbHelper = CoreDataHelper(context: AppDelegate.viewContext)
    private var recipeUrl: URL? = nil
    private var segueIdentifier = "WebRecipe"
    private var cellIdentifier = "IngredientCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setup()
    }
    
}

// MARK: - Configure
extension RecipeViewController {
    
    private func setup() {
        titleLabel.text = recipe.title
        configureInfosLabel()
        configureIngredientsLabel()
        configureImage()
        configureViewRecipeButton()
        dbHelper.isInDatabase(recipe: recipe, completion: { result in
            favoriteButton.modifyState(result)
        })
    }
    
    private func configureIngredientsLabel() {
        var text = "Ingredient"
        if recipe.ingredients.count > 0 {
            if recipe.ingredients.count > 1 {
                text += "s"
            }
            text += " (\(recipe.ingredients.count))"
        }
        ingredientsLabel.text = text
    }
    
    private func configureInfosLabel() {
        var text = ""
        if recipe.yield > 0 {
            text = "\(recipe.yield) People"
            
        }
        if recipe.preparationTime > 0 {
            text += text.isEmpty ? recipe.preparationTime.getStringTime() : " - " + recipe.preparationTime.getStringTime()
        }
        infosLabel.text = text
    }
    
    private func configureImage() {
        if let data = recipe.imageData {
            recipeImage.image = UIImage(data: data)
        }
        recipeImage.layer.cornerRadius = 10
    }
    
    private func configureViewRecipeButton() {
        recipeUrl = URL(string: recipe.sourceUrl)
        viewRecipeButton.isEnabled = (recipeUrl != nil)
        viewRecipeButton.alpha = viewRecipeButton.isEnabled ? 1 : 0.4
    }
}

// MARK: - Manage Favorite
extension RecipeViewController {
    
    @IBAction func favoriteButtonPressed(_ sender: FavoriteBarButton) {
        manageFavorite(dbHelper: dbHelper, recipe: recipe, button: favoriteButton)
    }
}

// MARK: - Navigation
extension RecipeViewController {
    
    @IBAction func webRecipePressed(_ sender: UIButton) {
        openLink()
    }
    
    private func openLink() {
        guard let url = recipeUrl else { return }
        performSegue(withIdentifier: segueIdentifier, sender: url)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == segueIdentifier, let webVC = segue.destination as? WebRecipeViewController {
            if let senderUrl = sender as? URL {
                webVC.url = senderUrl
                webVC.recipe = recipe
            }
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
