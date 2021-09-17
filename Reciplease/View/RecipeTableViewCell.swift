//
//  RecipeTableViewCell.swift
//  Reciplease
//
//  Created by Johann Petzold on 03/09/2021.
//

import UIKit

class RecipeTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var ingredientsLabel: UILabel!
    @IBOutlet weak var infosStackView: UIStackView!
    @IBOutlet weak var likeLabel: UILabel!
    @IBOutlet weak var likeImageView: UIImageView!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var durationImageView: UIImageView!
    @IBOutlet weak var recipeImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func configure(recipe: Recipe) {
        titleLabel.text = recipe.title
        ingredientsLabel.text = displayIngredientsFromList(ingredients: recipe.ingredients)
        if recipeImage.layer.contents == nil {
            recipeImage.addShadowGradient(width: UIScreen.main.bounds.width, height: self.frame.height)
        }
        recipeImage.image = nil
        configureStackView(recipe: recipe)
    }
    
    private func configureStackView(recipe: Recipe) {
        if recipe.score == 0 {
            likeLabel.isHidden = true
            likeImageView.isHidden = true
        } else {
            likeLabel.text = "\(recipe.score)"
        }
        if recipe.preparationTime == 0 {
            durationLabel.isHidden = true
            durationImageView.isHidden = true
        } else {
            durationLabel.text = recipe.preparationTime.getStringTime()
        }
        if likeLabel.isHidden && durationLabel.isHidden {
            infosStackView.isHidden = true
        }
    }
    
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
                }
            }
        }
    }
    
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
