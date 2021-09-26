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
    @IBOutlet weak var clearButton: RoundedButton!
    @IBOutlet weak var searchButton: RoundedButton!
    @IBOutlet weak var inListErrorLabel: UILabel!
    
    private var ingredients = [String]()
    private var segue = "RecipeList"
    private var cellIdentifier = "IngredientCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
}

// MARK: - Configure
extension IngredientViewController {
    
    private func setup() {
        ingredientTextField.delegate = self
        ingredientTableView.dataSource = self
        searchButtonState()
        clearButtonState()
    }
    
    private func searchButtonState() {
        searchButton.isEnabled = !ingredients.isEmpty
        searchButton.alpha = searchButton.isEnabled ? 1 : 0.4
    }
}

// MARK: - Add Ingredient
extension IngredientViewController {
    
    @IBAction func addButtonPressed(_ sender: UIButton) {
        addIngredientToList()
    }
    
    private func addIngredientToList() {
        guard let ingredient = ingredientTextField.text, ingredient != "" else { return }
        if !ingredients.contains(ingredient.noAccent().capitalized) {
            ingredients.append(ingredient.noAccent().capitalized)
            clearButtonState()
            searchButtonState()
            ingredientTextField.text = nil
            let indexPath = IndexPath(item: ingredients.count - 1, section: 0)
            ingredientTableView.beginUpdates()
            ingredientTableView.insertRows(at: [indexPath], with: .fade)
            ingredientTableView.endUpdates()
        } else {
            displayErrorLabel(label: inListErrorLabel)
        }
    }
}

// MARK: - Error
extension IngredientViewController {
    
    private func displayErrorLabel(label: UILabel) {
        if label.isHidden {
            label.isHidden = false
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                label.isHidden = true
            }
        }
    }
}

// MARK: - Clear List
extension IngredientViewController {
    
    @IBAction func clearButtonPressed(_ sender: UIButton) {
        clearIngredientList()
        clearButtonState()
        searchButtonState()
    }
    
    private func clearIngredientList() {
        if ingredients.count > 0 {
            ingredients.removeAll()
            ingredientTableView.reloadData()
        }
    }
    
    private func clearButtonState() {
        clearButton.isHidden = ingredients.isEmpty
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
