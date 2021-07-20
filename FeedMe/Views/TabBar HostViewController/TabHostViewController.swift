//
//  TabHostViewController.swift
//  FeedMe
//
//  Created by Ayman Omara on 16/07/2021.
//

import UIKit
import SOTabBar
class TabHostViewController: SOTabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let category = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "ViewController") as! ViewController
        let favorite = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "FavoriteViewController") as! FavoriteViewController
        category.tabBarItem = UITabBarItem(title: "Categories", image: UIImage(systemName: "book"), selectedImage: UIImage(systemName: "book"))
        favorite.tabBarItem = UITabBarItem(title: "favorites", image: UIImage(named: "not"), selectedImage: UIImage(named: "not"))
        
        
        viewControllers = [category,favorite]
        
    }

}
