//
//  WebRecipeViewController.swift
//  Reciplease
//
//  Created by Johann Petzold on 23/09/2021.
//

import UIKit
import WebKit

class WebRecipeViewController: UIViewController {

    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var safariButton: UIBarButtonItem!
    @IBOutlet weak var favoriteButton: FavoriteBarButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    var url: URL!
    var recipe: Recipe!
    private let dbHelper = CoreDataHelper(context: AppDelegate.viewContext)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupWebView()
        setupSafariButton()
        manageActivityIndicator(start: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupFavoriteButton()
    }
}

// MARK: - Configure
extension WebRecipeViewController {
    
    private func setupWebView() {
        webView.navigationDelegate = self
        let request = URLRequest(url: url)
        webView.load(request)
    }
    
    private func setupSafariButton() {
        safariButton.tintColor = UIColor(named: "GreenColor1")
    }
    
    private func setupFavoriteButton() {
        dbHelper.isInDatabase(recipe: recipe, completion: { result in
            favoriteButton.modifyState(result)
        })
    }
}

// MARK: - ActivityIndicator
extension WebRecipeViewController {
    
    private func manageActivityIndicator(start: Bool) {
        activityIndicator.isHidden = !start
        if start {
            activityIndicator.startAnimating()
        } else {
            activityIndicator.stopAnimating()
        }
    }
}

// MARK: - Favorite
extension WebRecipeViewController {
    
    @IBAction func favoriteButtonPressed(_ sender: FavoriteBarButton) {
        manageFavorite()
    }
    
    private func manageFavorite() {
        dbHelper.isInDatabase(recipe: recipe, completion: { result in
            if result {
                dbHelper.deleteRecipe(recipe: recipe) { success in
                    favoriteButton.modifyState(!success)
                }
            } else {
                dbHelper.saveRecipe(recipe: recipe) { success in
                    favoriteButton.modifyState(success)
                }
            }
        })
    }
}

// MARK: - Navigation
extension WebRecipeViewController {
    
    @IBAction func safariButtonPressed(_ sender: Any) {
        UIApplication.shared.open(url)
    }
}

// MARK: - WKNavigationDelegate
extension WebRecipeViewController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        manageActivityIndicator(start: false)
    }
}
