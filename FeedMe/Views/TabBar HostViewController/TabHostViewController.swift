//
//  TabHostViewController.swift
//  FeedMe
//
//  Created by Ayman Omara on 16/07/2021.
//

import UIKit
import SOTabBar
class TabHostViewController: SOTabBarController {
    var category:ViewController!
    var favorite:FavoriteViewController!
    override func loadView() {
        super.loadView()


        SOTabBarSetting.tabBarTintColor = UIColor.white
        SOTabBarSetting.tabBarAnimationDurationTime = 0.2

        category = (UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "ViewController") as! ViewController)
        category.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for:.selected)
        favorite = (UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "FavoriteViewController") as! FavoriteViewController)
        favorite.tabBarItem.badgeColor = UIColor.white
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        

        
        category.tabBarItem = UITabBarItem(title: "Categories", image: UIImage(systemName: "book"), selectedImage: UIImage(systemName: "book"))
        favorite.tabBarItem = UITabBarItem(title: "favorites", image: UIImage(named: "not"), selectedImage: UIImage(named: "not"))

        


        viewControllers = [category,favorite]
        
    }

}
