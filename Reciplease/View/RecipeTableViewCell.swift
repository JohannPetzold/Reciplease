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
    @IBOutlet weak var likeLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
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
        likeLabel.text = "\(recipe.score)"
        durationLabel.text = recipe.preparationTime.getStringTime()
        recipeImage.image = recipe.image
    }
    
    func addShadow(width: CGFloat) {
        if recipeImage.layer.contents == nil {
            recipeImage.addShadowGradient(width: width, height: self.frame.height)
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
