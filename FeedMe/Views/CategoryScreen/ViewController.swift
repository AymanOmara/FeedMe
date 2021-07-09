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
//            cell.layer.borderColor =
            cell.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            cell.layer.borderWidth = 1
            cell.cellImage.sd_setImage(with: URL(string: data.strCategoryThumb), placeholderImage: UIImage(named: "placeholder.png"))
            cell.callName.text = data.strCategory
            
            
        }.disposed(by: disposeBag)
        //MARK:- Send the id to the next viewContoller
        collectionView
            .rx
            .modelSelected(Category.self)
            .subscribe(onNext: { (model) in
                print(model.categories[0].idCategory)
            }).disposed(by: disposeBag)
//        collectionView.rx.itemSelected.bind(onNext: {(index) in
//            print(index)
//        })
        
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
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {

        let width = (collectionView.frame.size.width - 10) / 2
        
        let cellSize = CGSize(width: width, height: width)
//        let cellSize = CGSize(width: (view.window?.layer.frame.width)!/2, height: ((view.window?.layer.frame.width)!/2))
        return cellSize
    }


    
}
