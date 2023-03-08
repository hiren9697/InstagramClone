//
//  FlowManager.swift
//  Twitter
//
//  Created by Hiren Faldu Solution on 25/06/22.
//

import UIKit
import FirebaseAuth

// MARK: - Flow Manager
struct FlowManager {
    
    static let shared = FlowManager()
    
    public func navigateToHome() {
        DispatchQueue.main.async {
            let tabbarVC = TabBarController()
            App.appDelegator.window?.rootViewController = tabbarVC
            App.appDelegator.window?.makeKeyAndVisible()
        }
    }
    
    public func setInitialStack() {
        let navVC = UINavigationController()
        navVC.isNavigationBarHidden = true
        App.appDelegator.window?.rootViewController = navVC
        App.appDelegator.window?.makeKeyAndVisible()
        if Auth.auth().currentUser == nil {
            navVC.setViewControllers([LoginVC()], animated: true)
        } else {
            navVC.setViewControllers([TabBarController()], animated: true)
        }
    }
}
