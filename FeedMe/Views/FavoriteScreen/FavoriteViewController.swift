//
//  FavoriteViewController.swift
//  FeedMe
//
//  Created by Ayman Omara on 13/07/2021.
//

import UIKit

class FavoriteViewController: UIViewController, UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var tabelView: UITableView!
    let localManager = LocalManager.shared
    override func viewDidLoad() {
        super.viewDidLoad()
        tabelView.delegate = self
        tabelView.dataSource = self
        self.navigationController?.isToolbarHidden = true

    }


    var c = 0
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        localManager.retrive { details,imageArray in
            self.c = details!.count
        }
        return c
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavoriteCell", for: indexPath) as! FavoriteCell
        localManager.retrive { details,imageArray in
            if details!.count > 0{
            cell.label.text = details![indexPath.row].strMeal
            
                cell.favoriteImage.image =  imageArray[indexPath.row]
            }
        }
            return cell
            
        
    }
    override func viewWillAppear(_ animated: Bool) {
        tabelView.reloadData()
    }

}
