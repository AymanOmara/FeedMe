//
//  RandomViewController.swift
//  FeedMe
//
//  Created by Ayman Omara on 14/07/2021.
//

import UIKit
import SDWebImage
import RxCocoa
import RxSwift
import SkeletonView
class RandomViewController: UIViewController {
    
    
    let randomViewModel  = RandomViewModel()
let disposeBag = DisposeBag()
    var secondsRemaining = 5
    @IBOutlet weak var btn: UIButton!
    @IBOutlet weak var mealCategory: UILabel!
    @IBOutlet weak var mealName: UILabel!
    @IBOutlet weak var image: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        btn.layer.borderWidth = 2
        btn.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
       // btn.layer.cornerRadius = 40
        btn.layer.cornerRadius = btn.frame.size.width / 2
        btn.clipsToBounds = true
//        btn.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: btn.bounds.width - btn.bounds.height)
//        btn.imageView?.layer.cornerRadius = btn.bounds.height/2.0
        image.alpha = 1
        image.isSkeletonable = true
        image.animationDuration = 60
        image.showGradientSkeleton()
        
        image.startAnimating()
        image.backgroundColor = .belizeHole
        
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5){
            self.randomViewModel.featchData()
            
        }
        randomViewModel.dataObservable.subscribe({(data) in

            self.image.sd_setImage(with: URL(string: data.element!.strMealThumb), completed:{_,_,_,_ in
                self.image.stopSkeletonAnimation()
                self.image.hideSkeleton()
            })
            self.mealName.text = data.element!.strMeal
            self.mealCategory.text = "Category:" + data.element!.strCategory
        }).disposed(by: disposeBag)
        self.name()


    }
    func name() -> Void {
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { (Timer) in
            if self.secondsRemaining > 0 {
                self.btn.setTitle(String(self.secondsRemaining)
, for: .normal)
                self.btn.titleLabel?.text = String(self.secondsRemaining)
                print ("\(self.secondsRemaining) seconds")
                self.secondsRemaining -= 1
            } else if self.secondsRemaining == 0{
             
                self.btn.setTitle("X", for: .normal)
             //   self.btn.setImage(UIImage(named: "close-icon"), for: UIControl.State.normal)
                self.btn.addTarget(self, action: #selector(self.btnPressed), for: UIControl.Event.touchUpInside)
            }
        }
    }

    @objc func btnPressed(sender:UIButton){
        let navigationController = self.storyboard?.instantiateViewController(withIdentifier: "NavigationController") as! NavigationController
        navigationController.modalPresentationStyle = .fullScreen
        self.present(navigationController, animated: true, completion: nil)

    }

}
