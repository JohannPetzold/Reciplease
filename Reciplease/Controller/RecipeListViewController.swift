//
//  RecipeListViewController.swift
//  Reciplease
//
//  Created by Johann Petzold on 02/09/2021.
//

import UIKit

class RecipeListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var ingredients: [String]!
    private var segueIdentifier = "RecipeDetail"
    private var cellIdentifier = "RecipeCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        
        // TODO: Compare ingredients with recipes ingredients
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
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
        return Recipe.recipeList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? RecipeTableViewCell else {
            return UITableViewCell()
        }
        
        let recipe = Recipe.recipeList[indexPath.row]
        cell.configure(recipe: recipe)
        cell.addShadow(width: self.view.frame.width)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: segueIdentifier, sender: Recipe.recipeList[indexPath.row])
    }
}
