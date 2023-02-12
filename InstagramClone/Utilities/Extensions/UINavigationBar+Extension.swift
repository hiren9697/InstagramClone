//
//  UINavigationBar+Extension.swift
//  Twitter
//
//  Created by Hiren Faldu Solution on 03/07/22.
//

import UIKit

enum NavigationBarConfiguration {
    case defaultConfiguration, opaque(backgroundColor: UIColor?), transparent
}

extension UINavigationBar {
    
    func configuare(configuration: NavigationBarConfiguration) {
        let appearance = UINavigationBarAppearance()
        switch configuration {
        case .defaultConfiguration:
            appearance.configureWithDefaultBackground()
        case .opaque(backgroundColor: let backgroundColor):
            appearance.configureWithOpaqueBackground()
            if let backgroundColor = backgroundColor {
                appearance.backgroundColor = backgroundColor
            }
        case .transparent:
            appearance.configureWithTransparentBackground()
        }
        self.standardAppearance = appearance
        self.scrollEdgeAppearance = appearance
        self.compactAppearance = appearance
        self.compactScrollEdgeAppearance = appearance
    }
}
