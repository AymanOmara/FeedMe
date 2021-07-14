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
class MealViewController: UIViewController, UISearchBarDelegate  {
    
    @IBOutlet weak private var table: UITableView!
    @IBOutlet weak var search: UISearchBar!
    var mealViewModel:MealViewModel  = MealViewModel()
    var activityIndicator:UIActivityIndicatorView!
    let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        table.tableFooterView = UIView()
        activityIndicator = UIActivityIndicatorView(style: .large)
        mealViewModel.featchData()
        
        search.delegate = self
        
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
    
    
}
