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
    @IBOutlet weak var noRecipeErrorView: UIView!
    @IBOutlet weak var footerTableView: UIView!
    @IBOutlet weak var listActivityView: UIActivityIndicatorView!
    @IBOutlet weak var recipesActivityView: UIActivityIndicatorView!
    
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


// MARK: - Error
extension RecipeListViewController {
    
    private func displayNoRecipeError(_ display: Bool) {
        noRecipeErrorView.isHidden = !display
    }
}

// MARK: - Recipes
extension RecipeListViewController {
    
    private func getRecipesFromIngredients() {
        if ingredients.count > 0 {
            recipesLoading(true)
            service.fetchRecipes(with: ingredients) { result, nextUrl in
                self.recipesLoading(false)
                if let newRecipes = result {
                    self.nextUrl = nextUrl
                    self.recipes = newRecipes
                    self.tableView.reloadData()
                } else {
                    self.displayNoRecipeError(true)
                }
            }
        }
    }
    
    private func loadMoreRecipes() {
        guard let url = nextUrl else { return }
        showListLoadingView(true)
        service.fetchRecipes(apiUrl: url) { result, nextUrl in
            if let newRecipes = result {
                self.nextUrl = nextUrl
                
                let startRow = self.recipes.count
                self.recipes.append(contentsOf: newRecipes)
                var paths = [IndexPath]()
                for row in startRow...self.recipes.count - 1 {
                    paths.append(IndexPath(row: row, section: 0))
                }
                
                self.tableView.beginUpdates()
                self.tableView.insertRows(at: paths, with: .fade)
                self.tableView.endUpdates()
            }
            self.showListLoadingView(false)
        }
    }
    
    private func showListLoadingView(_ state: Bool) {
        footerTableView.isHidden = !state
        if state {
            listActivityView.startAnimating()
        } else {
            listActivityView.stopAnimating()
        }
    }
    
    private func recipesLoading(_ state: Bool) {
        if state {
            recipesActivityView.startAnimating()
        } else {
            recipesActivityView.stopAnimating()
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
        
        cell.resetCellData()
        let recipe = recipes[indexPath.row]
        cell.configureCell(recipe: recipe) { imageData in
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
