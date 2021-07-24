//
//  DetailsViewController.swift
//  FeedMe
//
//  Created by Ayman Omara on 11/07/2021.
//

import UIKit
import SDWebImage
import RxCocoa
import RxSwift
import SCLAlertView
class DetailsViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    var url:String = ""
    var isfromLocal = false
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var youtube: UIButton!
    
    @IBOutlet weak var favoriteOutlet: UIBarButtonItem!
    
    @IBOutlet weak var instractions: UILabel!
    @IBOutlet weak var tags: UILabel!
    @IBOutlet weak var area: UILabel!
    @IBOutlet weak var categoryName: UILabel!
    @IBOutlet weak var mealName: UILabel!
    let details = MealDetailsViewModel()
    let dispose = DisposeBag()
    var errorMessage:String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.contentLayoutGuide.bottomAnchor.constraint(equalTo: instractions.bottomAnchor).isActive = true
        youtube.setImage(UIImage(named: "YouTube-icon"), for: UIControl.State.normal )
        
        collectionView.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        collectionView.layer.borderWidth = 1
        details.dataObservable.subscribe(onNext: {(data,image)
            in
            self.title  = data.strMeal
            self.instractions.text = data.strInstructions
            self.tags.text = data.strTags
            self.area.text = data.strArea
            self.categoryName.text = data.strCategory
            self.url = data.strYoutube ?? ""
            if data.strYoutube == ""{
                self.youtube.alpha = 0.2
                self.youtube.isUserInteractionEnabled = false
            }
            self.youtube.addTarget(self, action:#selector(self.openYoutube), for: .touchUpInside)
            self.mealName.text = data.strMeal
            if let image = image{
                self.image.image = image
            }
            else{
                self.image.sd_setImage(with: URL(string: data.strMealThumb), placeholderImage: UIImage(named: "placeholder"))
            }
        }).disposed(by: dispose)
        
        details.ingredientObvservable.bind(to: collectionView.rx.items(cellIdentifier: "ingreddients")){row,data,cell in
            
            let cell = cell as! DetailsCollectionCell
            cell.labled.text = data.mesures
            cell.measures.text = data.ingredients
        }.disposed(by: dispose)
        
    }
    @objc func openYoutube(){
        if url == ""{
            youtube.alpha = 0.2
            youtube.isUserInteractionEnabled = false
            
        }else{
            let application = UIApplication.shared
            if application.canOpenURL(URL(string: url)!) {
                application.open(URL(string: url)!)
            }else {
                application.open(URL(string: "https://\(url)")!)
            }
        }}
    
    @IBAction func addToFavorite(_ sender: Any) {
        if details.checkIfSaved(){
            let _: SCLAlertViewResponder = SCLAlertView().showError("Error", subTitle:"This meal is saved before")
        }
        else {
        details.SaveToLocal(complition: {(messege) in
            self.errorMessage = messege
        })
        if errorMessage == ""{
            self.showDialogue()
            favoriteOutlet.image = UIImage(systemName: "heart.fill")


        }

        }
    }

    override func viewWillAppear(_ animated: Bool) {
        if !isfromLocal{
            details.featchData()
        }
        else if(isfromLocal){
            details.featchCoreDetails()
        }
        if details.checkIfSaved(){
            favoriteOutlet.image = UIImage(systemName: "heart.fill")
        }
    }
    func showDialogue() -> Void {
        let _: SCLAlertViewResponder = SCLAlertView().showSuccess("Done", subTitle: "This Meal Has Benn Add to favorites")
    }
}
