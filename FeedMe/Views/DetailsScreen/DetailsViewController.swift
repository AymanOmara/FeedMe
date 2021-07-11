//
//  DetailsViewController.swift
//  FeedMe
//
//  Created by Ayman Omara on 11/07/2021.
//

import UIKit
import SDWebImage
import RxCocoa
import RxSwift

class DetailsViewController: UIViewController {
    
    @IBOutlet weak var image: UIImageView!
    let details = MealDetailsViewModel()
    let dispose = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        details.featchData()
        
        details.dataObservable.subscribe({(data)
            in
            self.image.sd_setImage(with: URL(string: data.element!.strMealThumb), placeholderImage: UIImage(named: "placeholder"))
            //print()
        }).disposed(by: dispose)
    
    }
    
}
