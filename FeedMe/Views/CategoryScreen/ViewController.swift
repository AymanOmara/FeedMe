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
import Lottie
class ViewController: UIViewController{


    let refreshControl = UIRefreshControl()
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    private let categoryViewModel = CategoryViewModel()
    let animationView = AnimationView()
    private let disposeBag = DisposeBag()
    private var isLoadingAppears:Bool!
    private var activityIndicator:UIActivityIndicatorView!
    @IBOutlet weak private var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.alpha = 1
        self.navigationController?.isNavigationBarHidden = false
        
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
           refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        collectionView.addSubview(refreshControl)
        
        self.checkConnection()
        
        categoryViewModel.featchData()
        categoryViewModel.connectivityDriver.drive(onNext:{(connection) in
            if connection{
                self.showAnimation()
            }
            else if !connection{
                self.hideAnimation()
            }
            
        }).disposed(by: disposeBag)

        categoryViewModel.categoryObservable.bind(to: collectionView.rx.items(cellIdentifier: "CategoryCollectionViewCell")){row,data,cell in
            
            let cell = cell as! CategoryCollectionViewCell
            self.collectionView.layer.cornerRadius = 18
            self.collectionView.backgroundColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
            cell.cellImage.layer.borderColor = #colorLiteral(red: 0.3703787327, green: 0.2112608552, blue: 0.4184725881, alpha: 1)
            cell.cellImage.layer.borderWidth = 2
            cell.cellImage.layer.cornerRadius = 18
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
        
        let width = (collectionView.frame.size.width - 27) / 2
        
        let cellSize = CGSize(width: width, height: width)

        return cellSize
    }

}
extension ViewController{
    func checkConnection() -> Void {
        if !Connectivity.isConnectedToInternet{
            self.showAnimation()
            
        }
        else{
            self.hideAnimation()
            self.categoryViewModel.featchData()
        }
    }
    
    @objc func refresh(_ sender: AnyObject) {
        self.checkConnection()
        refreshControl.endRefreshing()

    }
    func showAnimation() -> Void {
        collectionView.alpha = 1
        animationView.alpha = 1


        animationView.animation = Animation.named("netwokFail")
        animationView.contentMode = .scaleAspectFit
        animationView.frame = view.bounds
        animationView.loopMode = .loop
        self.collectionView.backgroundView = animationView
//        collectionView.addSubview(animationView)
        animationView.play()


    }
    func hideAnimation() -> Void {
        collectionView.alpha = 1
        animationView.alpha = 0
    }
}
// MARK:- GestureRecognizer

