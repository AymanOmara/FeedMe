//
//  FavoriteViewController.swift
//  FeedMe
//
//  Created by Ayman Omara on 13/07/2021.
//

import UIKit
import  Lottie
class FavoriteViewController: UIViewController, UITableViewDelegate,UITableViewDataSource {
    var detailsArray:[mealDetails]?
    var imageArray:[UIImage]?
    let mealDetailsViewModel = MealDetailsViewModel()
    @IBOutlet weak var tabelView: UITableView!
    let animationView = AnimationView();
    let localManager = LocalManager.shared
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true

        tabelView.delegate = self
        tabelView.dataSource = self
        tabelView.tableFooterView = UIView()
        tabelView.reloadData()
        
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let detailsVC = self.storyboard?.instantiateViewController(identifier: "DetailsViewController") as! DetailsViewController
        detailsVC.isfromLocal = true
        detailsVC.details.coreID = detailsArray![indexPath.row].idMeal

        
        self.navigationController?.pushViewController(detailsVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let detailsArray = detailsArray{
            self.hideAnimation()
            
            return detailsArray.count
        }
        self.showAnimation()
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavoriteCell", for: indexPath) as! FavoriteCell

        
        cell.favoriteImage.image = imageArray![indexPath.row]
        cell.label.text = detailsArray![indexPath.row].strMeal
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.tappedMe(tapGestureRecognizer:)))
        cell.favoriteImage.addGestureRecognizer(tap)
        cell.favoriteImage.isUserInteractionEnabled = true
        
        return cell
        
        
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete{
            localManager.delete(id: detailsArray![indexPath.row].idMeal)
            detailsArray!.remove(at: indexPath.row)
            imageArray!.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            tabelView.reloadData()
            viewWillAppear(true)
        }
    }
    @objc func tappedMe(tapGestureRecognizer: UITapGestureRecognizer)
    {
        let tappedImage = tapGestureRecognizer.view as! UIImageView
        let imageController = self.storyboard?.instantiateViewController(identifier: "MyViewController") as! MyViewController
        imageController.image = tappedImage.image!
        imageController.modalPresentationStyle = .fullScreen
        self.present(imageController, animated: true, completion: nil)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }

    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
        self.title = "Favorites"
        localManager.retrive { details,imageArray in
            self.detailsArray = details
            self.imageArray = imageArray
        }
        if detailsArray?.count == 0{
            self.showAnimation()
        }
        else{
            self.hideAnimation()
            tabelView.reloadData()
        }
    }
    
    func showAnimation() -> Void {
        tabelView.alpha = 0
        animationView.alpha = 1
//        noFavortie.alpha = 1
        
        animationView.animation = Animation.named("empty")
        animationView.contentMode = .scaleAspectFit
        animationView.frame = view.bounds
        animationView.loopMode = .loop
        view.addSubview(animationView)
        animationView.play()
    }
    func hideAnimation() -> Void {
        animationView.alpha = 0
        tabelView.alpha = 1
//        noFavortie.alpha = 0
    }
    
}
