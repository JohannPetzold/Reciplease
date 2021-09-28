//
//  CustomNavigationBar.swift
//  Reciplease
//
//  Created by Johann Petzold on 25/09/2021.
//

import UIKit

class CustomNavigationBar: UINavigationBar {

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    private func setup() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .white
        let font = UIFont(name: "Avenir Medium", size: 24) ?? UIFont.systemFont(ofSize: 24)
        appearance.titleTextAttributes = [.font: font,
                                          .foregroundColor: UIColor.black]
        tintColor = UIColor(named: "GreenColor1")
        standardAppearance = appearance
        scrollEdgeAppearance = appearance
    }
}
