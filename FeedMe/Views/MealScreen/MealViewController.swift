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
class MealViewController: UIViewController {
    
    @IBOutlet weak private var table: UITableView!
    let mealViewModel = MealViewModel()
    let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        mealViewModel.featchData()
        mealViewModel.mealsObservable.bind(to: table.rx.items(cellIdentifier: "MealsTableViewCell")){row,data,cell in
            print(data)
            let cell = cell as! MealsTableViewCell
            
            cell.mealImage.sd_setImage(with: URL(string: data.strMealThumb), placeholderImage: UIImage(named: "placeholder"))
            cell.mealLabel.text = data.strMeal
        }.disposed(by: disposeBag)
        
        
    }
    
    
}
