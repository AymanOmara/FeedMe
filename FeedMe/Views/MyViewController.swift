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
        imageExpand.image = image
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.tappedMe(tapGestureRecognizer:)))
        myView.addGestureRecognizer(tap)
        
    }
    @objc func tappedMe(tapGestureRecognizer: UITapGestureRecognizer)
    {

        self.dismiss(animated: true, completion: nil)
    }
    @IBOutlet var myView: UIView!
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
