//
//  MyViewController.swift
//  FeedMe
//
//  Created by Ayman Omara on 03/08/2021.
//

import UIKit

class MyViewController: UIViewController {
var image = UIImage()
    @IBOutlet weak var imageExpand: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        myView.backgroundColor = UIColor(white: 1, alpha: 0.5)
        imageExpand.image = image
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.tappedMe(tapGestureRecognizer:)))
        myView.addGestureRecognizer(tap)
        
    }
    @objc func tappedMe(tapGestureRecognizer: UITapGestureRecognizer)
    {

        self.dismiss(animated: true, completion: nil)
    }
    @IBOutlet var myView: UIView!

}
