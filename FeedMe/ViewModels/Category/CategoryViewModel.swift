//
//  CategoryViewModel.swift
//  FeedMe
//
//  Created by Ayman Omara on 04/07/2021.
//

import Foundation
import RxSwift
class CategoryViewModel{
    let network = Networking.shared
    var categoryObservable:Observable<[CategoryElement]>
    private var categorySubject = PublishSubject<[CategoryElement]>()
    private var showLoadingSubject = PublishSubject<Bool>()
    var showLoadingObservable:Observable<Bool>
    
    
    
    
    func featchData()->Void{
        network.getAllCategories { category, statusCode, error in
            self.showLoadingSubject.onNext(true)
            self.categorySubject.onNext(category!.categories)
            self.showLoadingSubject.onNext(false)
            
        }
    }
    
    init() {
        categoryObservable = categorySubject.asObservable()
        showLoadingObservable = showLoadingSubject.asObserver()
    }
}
