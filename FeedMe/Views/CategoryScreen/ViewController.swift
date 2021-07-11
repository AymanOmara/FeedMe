//
//  ViewController.swift
//  FeedMe
//
//  Created by Ayman Omara on 03/07/2021.
//

import UIKit
import RxSwift
import RxCocoa
import SDWebImage

class ViewController: UIViewController{
    
    
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    private let categoryViewModel = CategoryViewModel()
    
    private let disposeBag = DisposeBag()
    private var isLoadingAppears:Bool!
    private var activityIndicator:UIActivityIndicatorView!
    @IBOutlet weak private var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Categories"
        indicator.alpha = 1
        activityIndicator = UIActivityIndicatorView()
        //activityIndicator = UIActivityIndicatorView(frame: CGRect(x: CGFloat(Double((view.frame.minX + view.frame.maxX) / 2 )) , y: CGFloat(Double((view.frame.minY + view.frame.maxY) / 2 )), width: view.frame.size.width, height:  view.frame.size.width))
        activityIndicator.alpha = 1
        categoryViewModel.featchData()
        activityIndicator.color = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        
        categoryViewModel.categoryObservable.bind(to: collectionView.rx.items(cellIdentifier: "CategoryCollectionViewCell")){row,data,cell in
            print(data)
            let cell = cell as! CategoryCollectionViewCell
            cell.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            cell.layer.borderWidth = 1
            cell.cellImage.sd_setImage(with: URL(string: data.strCategoryThumb), placeholderImage: UIImage(named: "placeholder.png"))
            cell.callName.text = data.strCategory
            
            
        }.disposed(by: disposeBag)
        //MARK:- Send the id to the next viewContoller

        collectionView.rx.modelSelected(CategoryElement.self).subscribe(onNext: {(category) in
            let mealsVC = self.storyboard?.instantiateViewController(identifier: "MealViewController") as! MealViewController
            mealsVC.mealViewModel.categoryName = category.strCategory

            self.navigationController?.pushViewController(mealsVC, animated: true)
            
        }).disposed(by: disposeBag)
        
        collectionView.rx.setDelegate(self).disposed(by: disposeBag)
        //
        
        categoryViewModel.showLoadingObservable.subscribe(onNext:{(bol)
            in
            switch(bol){
            case true:
                self.showLoading()
                print("start Loading")
            case false:
                self.hideLoading()
                print("stop Loading")
            }
        }).disposed(by: disposeBag)
    }
    
}





extension ViewController:ViewCotrollerContracts,UICollectionViewDelegateFlowLayout{
    
    
    func showLoading() -> Bool {
        indicator.startAnimating()
        indicator.alpha = 1
        activityIndicator.startAnimating()
        activityIndicator.alpha = 1
        //        self.activityIndicator.startAnimating()
        //        self.activityIndicator.alpha = 1
        isLoadingAppears = true
        return isLoadingAppears
    }
    func hideLoading() -> Bool {
        indicator.stopAnimating()
        indicator.alpha = 0
        activityIndicator.stopAnimating()
        activityIndicator.alpha = 0
        
        
        isLoadingAppears = false
        return isLoadingAppears
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        
        let width = (collectionView.frame.size.width - 10) / 2
        
        let cellSize = CGSize(width: width, height: width)

        return cellSize
    }
    
    
    
}
