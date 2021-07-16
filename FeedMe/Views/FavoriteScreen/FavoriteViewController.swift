//
//  FavoriteViewController.swift
//  FeedMe
//
//  Created by Ayman Omara on 13/07/2021.
//

import UIKit

class FavoriteViewController: UIViewController {
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isToolbarHidden = true
    
        //tableView.tableHeaderView = nil
        // let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes(_:)))
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes(_:)))
        //        leftSwipe.direction = .left
        rightSwipe.direction = .right
        //        self.view.addGestureRecognizer(leftSwipe)
        self.view.addGestureRecognizer(rightSwipe)
    }
    
    @objc func handleSwipes(_ sender:UISwipeGestureRecognizer) {
        //        if sender.direction == .left {
        //
        //            self.tabBarController!.selectedIndex += 1
        //        }
        if sender.direction == .right {
            self.tabBarController!.selectedIndex -= 1
        }
    }
}
