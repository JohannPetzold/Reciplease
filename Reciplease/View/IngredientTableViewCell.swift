//
//  IngredientTableViewCell.swift
//  Reciplease
//
//  Created by Johann Petzold on 03/09/2021.
//

import UIKit

class IngredientTableViewCell: UITableViewCell {

    @IBOutlet weak var ingredientLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

    func configure(ingredient name: String) {
        ingredientLabel.text = "- " + name
    }
}
