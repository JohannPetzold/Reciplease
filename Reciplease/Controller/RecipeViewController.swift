//
//  RecipeViewController.swift
//  Reciplease
//
//  Created by Johann Petzold on 02/09/2021.
//

import UIKit
import SafariServices

class RecipeViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var infosLabel: UILabel!
    @IBOutlet weak var ingredientsLabel: UILabel!
    @IBOutlet weak var recipeImage: UIImageView!
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
        
        dbHelper.isInDatabase(recipe: recipe, completion: { result in
            modifyFavoriteButton(isOn: result)
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
            favoriteButton.tintColor = UIColor(named: "GreenColor1")
        } else {
            favoriteButton.image = UIImage(systemName: "star")
            favoriteButton.tintColor = .gray
        }
    }
}

// MARK: - Navigation
extension RecipeViewController {
    
    @IBAction func webRecipePressed(_ sender: UIButton) {
        openLink()
    }
    
    private func openLink() {
        guard let url = URL(string: recipe.sourceUrl) else {
            // TODO: Display error message
            return
        }
        let configuration = SFSafariViewController.Configuration()
        let safariVC = SFSafariViewController(url: url, configuration: configuration)
//        self.navigationController?.pushViewController(safariVC, animated: true)
        present(safariVC, animated: true, completion: nil)
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
