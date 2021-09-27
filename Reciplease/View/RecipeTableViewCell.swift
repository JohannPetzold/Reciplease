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
    @IBOutlet weak var skeletonTitleView: UIView!
    @IBOutlet weak var skeletonInfosView: UIView!
    @IBOutlet weak var skeletonImageView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        recipeImage.layer.cornerRadius = 10
        skeletonTitleView.layer.cornerRadius = 5
        skeletonInfosView.layer.cornerRadius = 5
        skeletonImageView.layer.cornerRadius = 10
    }

    // Reset cell infos and show placeholder
    func resetCellData() {
        titleLabel.text = nil
        infosLabel.text = nil
        recipeImage.image = nil
        showSkeleton(true)
    }
    
    // Configure Cell with recipe datas
    func configureCell(recipe: Recipe, completion: @escaping (_ imageData: Data?) -> Void) {
        titleLabel.text = recipe.title
        configureInfosLabel(recipe: recipe)
        configureImage(from: recipe) { data in
            completion(data)
        }
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
    
    private func configureImage(from recipe: Recipe, completion: @escaping (_ imageData: Data?) -> Void) {
        loadImage(from: recipe) { newImage, data in
            if let image = newImage {
                self.recipeImage.image = image
                self.showSkeleton(false)
                self.addShadowToImage()
                completion(data)
            }
        }
    }
    
    // Load image from Recipe Data, from Url or from assets
    private func loadImage(from recipe: Recipe, completion: @escaping (_ image: UIImage?, _ recipeImageData: Data?) -> Void) {
        if let imageData = recipe.imageData, let image = UIImage(data: imageData) {
            completion(image, nil)
        } else if recipe.imageUrl != "" {
            DataHelper().loadDataFromUrl(urlString: recipe.imageUrl) { data in
                if let imageData = data, let newImage = UIImage(data: imageData) {
                    DispatchQueue.main.async {
                        completion(newImage, imageData)
                    }
                }
            }
        } else if let noUrlImage = UIImage.getGenericMealImage() {
            completion(noUrlImage, noUrlImage.jpegData(compressionQuality: 1))
        }
    }
    
    private func addShadowToImage() {
        if recipeImage.subviews.count == 0 {
            let shadowView = UIView.addShadowGradient(width: UIScreen.main.bounds.width, height: self.frame.height)
            recipeImage.addSubview(shadowView)
        }
    }
    
    private func showSkeleton(_ state: Bool) {
        skeletonTitleView.isHidden = !state
        skeletonInfosView.isHidden = !state
        skeletonImageView.isHidden = !state
    }
}
