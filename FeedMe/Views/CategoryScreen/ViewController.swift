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
        self.title = "Categories"

        categoryViewModel.featchData()

        
        categoryViewModel.categoryObservable.bind(to: collectionView.rx.items(cellIdentifier: "CategoryCollectionViewCell")){row,data,cell in
            
            let cell = cell as! CategoryCollectionViewCell

            cell.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            cell.layer.borderWidth = 1
            cell.cellImage.sd_setImage(with: URL(string: data.strCategoryThumb), placeholderImage: UIImage(named: "placeholder.png"))
            cell.callName.text = data.strCategory
            

        }.disposed(by: disposeBag)


        collectionView.rx.modelSelected(CategoryElement.self).subscribe(onNext: {(category) in
            let mealsVC = self.storyboard?.instantiateViewController(identifier: "MealViewController") as! MealViewController
            mealsVC.mealViewModel.categoryName = category.strCategory

            self.navigationController!.isNavigationBarHidden = false
            mealsVC.navigationController?.isNavigationBarHidden = false
            
            self.navigationController?.pushViewController(mealsVC, animated: true)

            
        }).disposed(by: disposeBag)
        
        collectionView.rx.setDelegate(self).disposed(by: disposeBag)

    }

}





extension ViewController:UICollectionViewDelegateFlowLayout{

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        
        let width = (collectionView.frame.size.width - 10) / 2
        
        let cellSize = CGSize(width: width, height: width)

        return cellSize
    }

}
// MARK:- GestureRecognizer

