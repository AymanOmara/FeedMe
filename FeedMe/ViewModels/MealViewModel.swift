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
    
    private var mealsSubject = PublishSubject<[meal]>()
    private var errorSubject = PublishSubject<(String,Int,Bool)>()
    
    var categoryName:String = ""
    
    func featchData() -> Void{
        print("====================================")
        //        print(categoryName)
        print("====================================")
        network.getAllMeals(categoryName: categoryName) { meals, statusCode, error in
            guard let meals = meals else{
                self.errorSubject.onNext((error!.localizedDescription,statusCode!,true))
                return
            }
            self.mealsSubject.onNext(meals.meals)
            Swift.print(meals)
        }
    }
    init() {
        mealsObservable = mealsSubject.asObservable()
        errorObservable = errorSubject.asObservable()
    }
    //    init(str:String) {
    //        categoryName = str
    //        mealsObservable = nil
    //        errorObservable = nil
    //    }
}
