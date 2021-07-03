//
//  ViewController.swift
//  FeedMe
//
//  Created by Ayman Omara on 03/07/2021.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let network:CategoryContract = Networking.shared
        network.getAllCategory(complition: {(data,error,statusCode)
            in
           
            print(data)
            print(statusCode)
            
        })
    }


}

