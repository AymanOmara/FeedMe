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
class MealViewController: UIViewController, UISearchBarDelegate  {
    
    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var search: UISearchBar!
    var mealViewModel:MealViewModel  = MealViewModel()
    let animationView = AnimationView()

    let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        table.tableFooterView = UIView()
        
        mealViewModel.featchData()
        mealViewModel.observable.subscribe({(connection) in
            if connection.element!{
                self.showAnimation()
            }
            else{
                self.hideAnimation()
            }
        }).disposed(by: disposeBag)
//        self.showAnimation()
//        self.showAnimation()

        
        
//        mealViewModel.connectivityDriver.drive(onNext:{(connection)in
//            print(1)
//            
//            
//            if connection{
//                self.showAnimation()
//                DispatchQueue.global().asyncAfter(deadline: .now() + 6) {
//                    self.mealViewModel.featchData()
//               
//                }
//            }
//            else{
//                
//                self.hideAnimation()
//            }
//        }).disposed(by: disposeBag)
        
        
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
    func showAnimation() -> Void {
        table.alpha = 0
        search.alpha = 0
        table.tableHeaderView?.alpha = 0
        animationView.alpha = 1


        animationView.animation = Animation.named("netwokFail")
        animationView.contentMode = .scaleAspectFit
        animationView.frame = view.bounds
        animationView.loopMode = .loop
        self.view.addSubview(animationView)
        animationView.play()
        viewWillAppear(true)

    }
    func hideAnimation() -> Void {
        table.alpha = 1
        animationView.alpha = 0
    }
}
