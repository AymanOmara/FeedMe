//
//  MealViewModel.swift
//  FeedMe
//
//  Created by Ayman Omara on 05/07/2021.
//

import Foundation
import RxSwift
import RxCocoa
class MealViewModel {
    let network = Networking.shared
    var mealsObservable:Observable<[meal]>?
    private var mealsSubject = PublishSubject<[meal]>()

    var connectivityDriver:Driver<Bool>
    var connectivitySubject = PublishSubject<Bool>()
    
    var subject = PublishSubject<Bool>()
    var observable:Observable<Bool>
    
    var categoryName:String = ""
    
    func featchData() -> Void{
        
        if !Connectivity.isConnectedToInternet{
            self.connectivitySubject.onNext(true)
            self.subject.onNext(true)
            
            return
        }
        connectivitySubject.onNext(true)
        subject.onNext(true)
        if Connectivity.isConnectedToInternet{
        network.getAllMeals(categoryName: categoryName) { meals, statusCode, error in
            guard let meals = meals else{
                
                return
            }
            self.mealsSubject.onNext(meals.meals)
            
        }
            return
        }
    }
    init() {
        
        mealsObservable = mealsSubject.asObservable()
        connectivityDriver = connectivitySubject.asDriver(onErrorJustReturn: false)
        observable = subject.asObservable()
        
    }
    
}
