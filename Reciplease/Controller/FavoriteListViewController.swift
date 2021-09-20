//
//  FavoriteListViewController.swift
//  Reciplease
//
//  Created by Johann Petzold on 02/09/2021.
//

import UIKit

class FavoriteListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
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
            self.favorites = recipes
            tableView.reloadData()
        }
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
        cell.configure(recipe: recipe)
        cell.loadImage(from: favorites[indexPath.row]) { _ in }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: segueIdentifier, sender: favorites[indexPath.row])
    }
}
