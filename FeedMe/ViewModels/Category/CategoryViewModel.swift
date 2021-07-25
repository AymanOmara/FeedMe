//
//  CategoryViewModel.swift
//  FeedMe
//
//  Created by Ayman Omara on 04/07/2021.
//

import Foundation
import RxSwift
import RxCocoa
class CategoryViewModel{
    let conntection = Connection.share
    let network = Networking.shared
    var categoryObservable:Observable<[CategoryElement]>
    private var categorySubject = PublishSubject<[CategoryElement]>()
    var connectivityDriver:Driver<Bool>
    var connectivitySubject = PublishSubject<Bool>()
    
    func featchData()->Void{
        if !Connectivity.isConnectedToInternet{
            self.connectivitySubject.onNext(true)
            
            return
        }
        network.getAllCategories { category, statusCode, error in
            self.categorySubject.onNext(category!.categories)
        }
    }
    
    init() {
        categoryObservable = categorySubject.asObservable()
        connectivityDriver = connectivitySubject.asDriver(onErrorJustReturn: false)

    }
}
