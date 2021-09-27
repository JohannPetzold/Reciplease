//
//  FavoriteListViewController.swift
//  Reciplease
//
//  Created by Johann Petzold on 02/09/2021.
//

import UIKit

class FavoriteListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var emptyListView: UIView!
    
    private let dbHelper = CoreDataHelper(context: AppDelegate.viewContext)
    private var favorites = [Recipe]()
    private var segueIdentifier = "RecipeDetail"
    private var cellIdentifier = "RecipeCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadFavorites()
    }
}

// MARK: - Configure
extension FavoriteListViewController {
    
    private func loadFavorites() {
        dbHelper.getAllRecipes { recipes in
            if recipes.isEmpty {
                displayEmptyListView(true)
            } else {
                displayEmptyListView(false)
            }
            self.favorites = recipes
            tableView.reloadData()
        }
    }
}

// MARK: - Empty List
extension FavoriteListViewController {
    
    private func displayEmptyListView(_ display: Bool) {
        emptyListView.isHidden = !display
    }
}

// MARK: - Navigation
extension FavoriteListViewController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == segueIdentifier, let detailVC = segue.destination as? RecipeViewController {
            if let recipe = sender as? Recipe {
                detailVC.recipe = recipe
            }
        }
    }
}

// MARK: - UITableViewDataSource
extension FavoriteListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favorites.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? RecipeTableViewCell else {
            return UITableViewCell()
        }
        let recipe = favorites[indexPath.row]
        cell.configureCell(recipe: recipe) { _ in }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: segueIdentifier, sender: favorites[indexPath.row])
    }
}
