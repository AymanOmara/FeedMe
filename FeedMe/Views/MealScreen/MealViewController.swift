//
//  MealViewController.swift
//  FeedMe
//
//  Created by Ayman Omara on 05/07/2021.
//

import UIKit
import RxCocoa
import RxSwift
import SDWebImage
import Lottie
class MealViewController: UIViewController  {
    let refreshControl = UIRefreshControl()
    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var search: UISearchBar!
    var mealViewModel:MealViewModel  = MealViewModel()
    let animationView = AnimationView()
    
    let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        table.tableFooterView = UIView()
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
           refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        table.addSubview(refreshControl)
        mealViewModel.featchData()
        self.checkConnection()
        
//        search.delegate = self
        search.rx.text
            .orEmpty.distinctUntilChanged().bind(to: mealViewModel.searchValue).disposed(by: disposeBag)
        
        
        
        
        table
            .rx.setDelegate(self)
            .disposed(by: disposeBag)
        
        mealViewModel.mealsObservable!.bind(to: table.rx.items(cellIdentifier: "MealsTableViewCell")){row,data,cell in
            
            let cell = cell as! MealsTableViewCell
            cell.mealImage.sd_setImage(with: URL(string: data.strMealThumb), placeholderImage: UIImage(named: "placeholder"))
            cell.mealLabel.text = data.strMeal
        }.disposed(by: disposeBag)
        
        
        table.rx.modelSelected(meal.self).subscribe(onNext: {(meal) in
            let mealDetails = self.storyboard?.instantiateViewController(identifier: "DetailsViewController") as! DetailsViewController
            mealDetails.details.mealID = meal.idMeal
            self.navigationController?.pushViewController(mealDetails, animated: true)

        }).disposed(by: disposeBag)
        
    }
    
}
extension MealViewController:UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    func showAnimation() -> Void {
        table.alpha = 1
        search.alpha = 0

        animationView.alpha = 1
        animationView.animation = Animation.named("netwokFail")
        animationView.contentMode = .scaleAspectFit
        animationView.frame = view.bounds
        animationView.loopMode = .loop
        self.table.backgroundView = animationView
        animationView.play()


    }
    func hideAnimation() -> Void {
        search.alpha = 1
        table.alpha = 1
        animationView.alpha = 0
    }
    @objc func refresh(_ sender: AnyObject) {
        self.checkConnection()
        refreshControl.endRefreshing()

    }
    func checkConnection() -> Void {
        if !Connectivity.isConnectedToInternet{
            self.showAnimation()
            
        }
        else{
            self.hideAnimation()
            self.mealViewModel.featchData()
        }
    }
}
