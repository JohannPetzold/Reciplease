//
//  RecipeTableViewCell.swift
//  Reciplease
//
//  Created by Johann Petzold on 03/09/2021.
//

import UIKit

class RecipeTableViewCell: UITableViewCell {

    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var infosLabel: UILabel!
    @IBOutlet weak var recipeImage: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    // Configure Cell with recipe datas
    func configure(recipe: Recipe) {
        titleLabel.text = recipe.title
        if recipeImage.layer.contents == nil {
            recipeImage.addShadowGradient(width: UIScreen.main.bounds.width, height: self.frame.height)
        }
        recipeImage.image = nil
        recipeImage.layer.cornerRadius = 10
        configureInfosLabel(recipe: recipe)
    }
    
    private func configureInfosLabel(recipe: Recipe) {
        var text = ""
        if recipe.ingredients.count > 0 {
            text = "\(recipe.ingredients.count) Ingredient"
            if recipe.ingredients.count > 1 {
                text += "s"
            }
        }
        if recipe.yield > 0 {
            text += text.isEmpty ? "\(recipe.yield) People" : " | \(recipe.yield) People"
        }
        if recipe.preparationTime > 0 {
            text += text.isEmpty ? recipe.preparationTime.getStringTime() : " | " + recipe.preparationTime.getStringTime()
        }
        infosLabel.text = text
    }
    
    // Load image from recipe Data, from Url in global queue, or get generic image
    func loadImage(from recipe: Recipe, completion: @escaping (_ imageData: Data?) -> Void) {
        if let imageData = recipe.imageData {
            recipeImage.image = UIImage(data: imageData)
            completion(nil)
        } else {
            if recipe.imageUrl == "", let noUrlImage = UIImage.getGenericMealImage() {
                recipeImage.image = noUrlImage
                completion(noUrlImage.jpegData(compressionQuality: 1))
            } else {
                DataHelper().loadDataFromUrl(urlString: recipe.imageUrl) { data in
                    if let imageData = data, let newImage = UIImage(data: imageData) {
                        DispatchQueue.main.async {
                            self.recipeImage.image = newImage
                        }
                        completion(imageData)
                    }
                    else {
                        if let noUrlImage = UIImage.getGenericMealImage() {
                            self.recipeImage.image = noUrlImage
                            completion(noUrlImage.jpegData(compressionQuality: 1))
                        }
                    }
                }
            }
        }
    }
    
    // Display array of ingredients on a single String
    private func displayIngredientsFromList(ingredients: [String]) -> String {
        guard ingredients.count > 0 else { return "" }
        var result = ""
        for x in 0..<ingredients.count {
            result += ingredients[x]
            if x < ingredients.count - 1 {
                result += ", "
            }
        }
        return result
    }
}
