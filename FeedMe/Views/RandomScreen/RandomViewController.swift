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
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        randomViewModel.featchData()
        randomViewModel.dataObservable.subscribe({(data) in
            self.image.sd_setImage(with: URL(string: data.element!.strMealThumb), placeholderImage: UIImage(named: "placeholder"))
            self.mealName.text = data.element?.strMeal
            self.mealCategory.text = data.element?.strCategory
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
             //   self.btn.setTitle("")
                self.btn.setTitle("", for: .normal)
                self.btn.setImage(UIImage(named: "close-icon"), for: UIControl.State.normal)
                self.btn.addTarget(self, action: #selector(self.btnPressed), for: UIControl.Event.touchUpInside)
            }
        }
    }

    @objc func btnPressed(sender:UIButton){
        let navigationController = self.storyboard?.instantiateViewController(withIdentifier: "NavigationController") as! NavigationController
        navigationController.modalPresentationStyle = .fullScreen
        self.present(navigationController, animated: true, completion: nil)
        //self.navigationController?.pushViewController(navigationController, animated: true)
     //   viewcontroller.modalPresentationStyle = .fullScreen
      //  self.navigationController?.pushViewController(viewcontroller, animated: true)
//        let viewcontroller = self.storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
//        self.tabBarController?.navigationController?.pushViewController(viewcontroller, animated: true)
       // self.tabBarController?.navigationController?.pushViewController(viewcontroller, animated: true)
       //self.tabBarController?.show(navigationController, sender: self)
//        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(viewcontroller)
    }

}
