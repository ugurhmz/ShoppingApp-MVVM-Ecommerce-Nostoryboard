//
//  MainTabBarVC.swift
//  FurnitureShop
//
//  Created by ugur-pc on 19.05.2022.
//

import UIKit

class MainTabBarVC: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        let homeTab = UINavigationController(rootViewController: HomeVC())
        let profileTab = UINavigationController(rootViewController: ProfileVC())
        
        homeTab.tabBarItem.image = UIImage(systemName: "house")
        profileTab.tabBarItem.image = UIImage(systemName: "person")
        
        homeTab.title = "Home"
        profileTab.title = "Profile"
        
        tabBar.tintColor = .label
        setViewControllers([homeTab, profileTab], animated: true)
    }
    
}
