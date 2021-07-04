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

class ViewController: UIViewController {
    

    private let categoryViewModel = CategoryViewModel()
    private let disposeBag = DisposeBag()
    private var isLoadingAppears:Bool!
    
    @IBOutlet weak private var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        categoryViewModel.featchData()
        categoryViewModel.categoryObservable.bind(to: collectionView.rx.items(cellIdentifier: "CategoryCollectionViewCell")){row,data,cell in
            print(data)
            let cell = cell as! CategoryCollectionViewCell
            cell.cellImage.sd_setImage(with: URL(string: data.strCategoryThumb), placeholderImage: UIImage(named: "placeholder.png"))
            cell.callName.text = data.strCategory
            
        }.disposed(by: disposeBag)
        
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
extension ViewController:ViewCotrollerContracts{
    
    
    func showLoading() -> Bool {
//        self.activityIndicator.startAnimating()
//        self.activityIndicator.alpha = 1
        isLoadingAppears = true
        return isLoadingAppears
    }
    func hideLoading() -> Bool {
//        self.activityIndicator.stopAnimating()
//        self.activityIndicator.alpha = 0
        
        isLoadingAppears = false
        return isLoadingAppears
    }
    
}
