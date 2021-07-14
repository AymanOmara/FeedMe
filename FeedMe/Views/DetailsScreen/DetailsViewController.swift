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

class DetailsViewController: UIViewController {
    var url:String = ""
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var youtube: UIButton!
    
    @IBOutlet weak var addToFavorite: UIBarButtonItem!
    @IBOutlet weak var instractions: UILabel!
    @IBOutlet weak var tags: UILabel!
    @IBOutlet weak var area: UILabel!
    @IBOutlet weak var categoryName: UILabel!
    @IBOutlet weak var mealName: UILabel!
    let details = MealDetailsViewModel()
    let dispose = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        youtube.setImage(UIImage(named: "YouTube-icon"), for: UIControl.State.normal )
//        addToFavorite.addTarget(self, action: #selector(addToFavorite(sender:)), for: UIControl.Event.to)
//        addToFavorite.action = #selector(setter: addToFavorite)
        collectionView.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        collectionView.layer.borderWidth = 1
        details.featchData()
        
        details.dataObservable.subscribe({(data)
            in
            self.title  = data.element?.strMeal
            self.instractions.text = data.element?.strInstructions
            self.tags.text = data.element?.strTags
            self.area.text = data.element?.strArea
            self.categoryName.text = data.element?.strCategory
            self.url = data.element?.strYoutube ?? ""
            if data.element?.strYoutube == ""{
                self.youtube.alpha = 0.2
                self.youtube.isUserInteractionEnabled = false
            }
            self.youtube.addTarget(self, action:#selector(self.openYoutube), for: .touchUpInside)
            self.mealName.text = data.element?.strMeal
            self.image.sd_setImage(with: URL(string: data.element!.strMealThumb), placeholderImage: UIImage(named: "placeholder"))
            
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
    
    @objc func addToFavorite(sender:UIBarButtonItem){
print("")
        if sender.isEnabled{
            

        }
        
    }
    
}
