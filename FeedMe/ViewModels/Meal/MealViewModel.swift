//
//  MealViewModel.swift
//  FeedMe
//
//  Created by Ayman Omara on 05/07/2021.
//

import Foundation
import RxSwift
class MealViewModel {
    let network = Networking.shared
    var mealsObservable:Observable<[meal]>?
    var errorObservable:Observable<(String,Int,Bool)>?
    var showLoadingObservable:Observable<Bool>
    var showLoadingSubject = PublishSubject<Bool>()
    private var mealsSubject = PublishSubject<[meal]>()
    private var errorSubject = PublishSubject<(String,Int,Bool)>()
    
    var categoryName:String = ""
    
    func featchData() -> Void{
        
        network.getAllMeals(categoryName: categoryName) { meals, statusCode, error in
            guard let meals = meals else{
                self.errorSubject.onNext((error!.localizedDescription,statusCode!,true))
                return
            }
            self.mealsSubject.onNext(meals.meals)
            self.showLoadingSubject.onNext(false)
        }
    }
    init() {
        showLoadingSubject.onNext(true)
        mealsObservable = mealsSubject.asObservable()
        errorObservable = errorSubject.asObservable()
        showLoadingObservable = showLoadingSubject.asObservable()
    }

}
