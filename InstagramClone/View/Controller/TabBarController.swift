//
//  TabBarController.swift
//  InstagramClone
//
//  Created by Hirenkumar Fadadu on 12/02/23.
//

import UIKit

// MARK: - VC
class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewControllers()
    }
}

// MARK: - Helper method(s)
extension TabBarController {
    
    private func setupViewControllers() {
        view.backgroundColor = .white
        tabBar.tintColor = .black
        
        let feedVC = FeedVC()
        feedVC.tabBarItem.image = UIImage(named: "ic_home_unselected")!
        feedVC.tabBarItem.selectedImage = UIImage(named: "ic_home_selected")!
        
        let searchVC = SearchVC()
        searchVC.tabBarItem.image = UIImage(named: "ic_search_unselected")!
        searchVC.tabBarItem.selectedImage = UIImage(named: "ic_search_selected")!
        
        let addPostVC = AddPostVC()
        addPostVC.tabBarItem.image = UIImage(named: "ic_add_post")!
        addPostVC.tabBarItem.selectedImage = UIImage(named: "ic_add_post")!
        
        let notificationListVC = NotificationListVC()
        notificationListVC.tabBarItem.image = UIImage(named: "ic_notification_unselected")!
        notificationListVC.tabBarItem.selectedImage = UIImage(named: "ic_notification_selected")!
        
        let profileVC = ProfileVC()
        profileVC.tabBarItem.image = UIImage(named: "ic_profile_unselected")!
        profileVC.tabBarItem.selectedImage = UIImage(named: "ic_profile_selected")!
        
        self.viewControllers = [feedVC,
                                UINavigationController(rootViewController: searchVC),
                                addPostVC,
                                notificationListVC,
                                profileVC]
    }
}
