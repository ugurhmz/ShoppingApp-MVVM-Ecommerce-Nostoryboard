//
//  MainTabBarVC.swift
//  FurnitureShop
//
//  Created by ugur-pc on 19.05.2022.
//

import UIKit

class MainTabBarVC: UITabBarController {
    
    let homeTab = UINavigationController(rootViewController: HomeVC())
    let profileTab = UINavigationController(rootViewController: ProfileVC())
    let cartTab = UINavigationController(rootViewController: CartVC())
    let favoritePrdTab = UINavigationController(rootViewController: FavouriteProductsVC())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        homeTab.tabBarItem.image = UIImage(systemName: "house")
        favoritePrdTab.tabBarItem.image =  UIImage(systemName: "heart.fill")
        cartTab.tabBarItem.image = UIImage(systemName: "cart.fill")
        profileTab.tabBarItem.image = UIImage(systemName: "person")
       
        
        homeTab.title = "Home"
        favoritePrdTab.title = "Favourites"
        cartTab.title = "Cart"
        profileTab.title = "Profile"
        
        tabBar.tintColor = .black
       // tabBar.unselectedItemTintColor = .white
        //UITabBar.appearance().barTintColor = UIColor.blue
     
        if #available(iOS 15.0, *) {
           let appearance = UITabBarAppearance()
           appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = .white
           
           self.tabBar.standardAppearance = appearance
            self.tabBar.scrollEdgeAppearance = tabBar.standardAppearance
        }
        
        setViewControllers([homeTab,favoritePrdTab,cartTab ,profileTab], animated: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
          NotificationCenter.default.addObserver(self, selector: #selector(badgeINC),
                                                         name: NSNotification.Name("applyBtn"),
                                                         object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(badgeFavINC),
                                                       name: NSNotification.Name("notifiFavourite"),
                                                       object: nil)
        
    }
   
    
    @objc func badgeINC(_ notification: Notification){
          if let myNum = notification.object as? Int {
              cartTab.tabBarItem.badgeValue = "\(myNum)"
          }
    }
    
    @objc func badgeFavINC(_ notification: Notification) {
        if let myNum = notification.object as? Int {
            favoritePrdTab.tabBarItem.badgeValue = "\(myNum)"
        }
    }
    
}
