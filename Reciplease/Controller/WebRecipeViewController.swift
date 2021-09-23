//
//  WebRecipeViewController.swift
//  Reciplease
//
//  Created by Johann Petzold on 23/09/2021.
//

import UIKit
import WebKit

class WebRecipeViewController: UIViewController {

    var url: URL!
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var safariButton: UIBarButtonItem!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupWebView()
        setupSafariButton()
        manageActivityIndicator(start: true)
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
