//
//  FavoriteBarButton.swift
//  Reciplease
//
//  Created by Johann Petzold on 26/09/2021.
//

import UIKit

class FavoriteBarButton: UIBarButtonItem {

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func modifyState(_ state: Bool) {
        image = UIImage(systemName: state ? "star.fill" : "star")
        tintColor = state ? UIColor(named: "GreenColor1") : .gray
    }
}
