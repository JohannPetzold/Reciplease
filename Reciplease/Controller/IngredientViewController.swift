//
//  ViewController.swift
//  Reciplease
//
//  Created by Johann Petzold on 02/09/2021.
//

import UIKit

class IngredientViewController: UIViewController {

    @IBOutlet weak var ingredientTextField: UITextField!
    @IBOutlet weak var ingredientTableView: UITableView!

    private var ingredients = [String]()
    private var segue = "RecipeList"
    private var cellIdentifier = "IngredientCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ingredientTextField.delegate = self
        ingredientTableView.dataSource = self
        
        configure()
    }
}

// MARK: - Configure
extension IngredientViewController {
    
    private func configure() {
        ingredientTextField.addBottomLine(shortLine: 8, bottomPosition: 2)
    }
}

// MARK: - Add Ingredient
extension IngredientViewController {
    
    @IBAction func addButtonPressed(_ sender: UIButton) {
        addIngredientToList()
    }
    
    private func addIngredientToList() {
        guard let ingredient = ingredientTextField.text, ingredient != "" else { return }
        if !ingredients.contains(ingredient) {
            ingredients.append(ingredient.noAccent().capitalized)
            ingredientTextField.text = nil
            ingredientTableView.reloadData()
        } else {
            // TODO: Display Error Message
        }
    }
}

// MARK: - Clear List
extension IngredientViewController {
    
    @IBAction func clearButtonPressed(_ sender: UIButton) {
        clearIngredientList()
    }
    
    private func clearIngredientList() {
        if ingredients.count > 0 {
            ingredients.removeAll()
            ingredientTableView.reloadData()
        }
    }
}

// MARK: - Navigation
extension IngredientViewController {
    
    @IBAction func searchRecipe(_ sender: UIButton) {
        if ingredients.count > 0 {
            performSegue(withIdentifier: segue, sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == self.segue {
            if let recipeVC = segue.destination as? RecipeListViewController {
                recipeVC.ingredients = ingredients
            }
        }
    }
}

// MARK: - Keyboard
extension IngredientViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        addIngredientToList()
        return true
    }
    
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        ingredientTextField.resignFirstResponder()
    }
}

// MARK: - UITableViewDataSource
extension IngredientViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ingredients.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? IngredientTableViewCell else {
            return UITableViewCell()
        }
        
        let ingredient = ingredients[indexPath.row]
        cell.configure(ingredient: ingredient)
        
        return cell
    }
}
