//
//  RecipeListViewController.swift
//  Reciplease
//
//  Created by Johann Petzold on 02/09/2021.
//

import UIKit
import Alamofire

class RecipeListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var ingredients: [String]!
    private var service = APIService(session: AF)
    private var recipes = [Recipe]()
    private var nextUrl: String?
    private var segueIdentifier = "RecipeDetail"
    private var cellIdentifier = "RecipeCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        
        getRecipesFromIngredients()
    }
}

// MARK: - Recipes
extension RecipeListViewController {
    
    private func getRecipesFromIngredients() {
        if ingredients.count > 0 {
            service.fetchRecipes(with: ingredients) { result, nextUrl in
                if let newRecipes = result {
                    self.nextUrl = nextUrl
                    self.recipes = newRecipes
                    self.tableView.reloadData()
                } else {
                    // TODO: Display empty list message
                }
            }
        }
    }
    
    private func loadMoreRecipes() {
        guard let url = nextUrl else { return }
        service.fetchRecipes(apiUrl: url) { result, nextUrl in
            if let newRecipes = result {
                self.nextUrl = nextUrl
                self.recipes.append(contentsOf: newRecipes)
                self.tableView.reloadData()
            }
        }
    }
}

// MARK: - Navigation
extension RecipeListViewController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == segueIdentifier, let detailVC = segue.destination as? RecipeViewController {
            if let recipe = sender as? Recipe {
                detailVC.recipe = recipe
            }
        }
    }
}

// MARK: - UITableViewDataSource & UITableViewDelegate
extension RecipeListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? RecipeTableViewCell else {
            return UITableViewCell()
        }
        
        let recipe = recipes[indexPath.row]
        cell.configure(recipe: recipe)
        cell.loadImage(from: recipes[indexPath.row]) { imageData in
            if let data = imageData {
                self.recipes[indexPath.row].imageData = data
            }
        }
        
        if nextUrl != nil && indexPath.row == recipes.count - 1 {
            loadMoreRecipes()
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: segueIdentifier, sender: recipes[indexPath.row])
    }
}
