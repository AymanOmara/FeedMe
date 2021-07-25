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
    let dispose = DisposeBag()
    let network = Networking.shared
    var mealsObservable:Observable<[meal]>?
    var searchValue : BehaviorRelay<String> = BehaviorRelay(value: "")
    private var searchedMeal:[meal]!
    private var allMeals:[meal]!
    private lazy var searchValueObservable:Observable<String> = searchValue.asObservable()
    var isfiltered = false
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
            network.getAllMeals(categoryName: categoryName) { [self] meals, statusCode, error in
            guard let meals = meals else{
                
                return
            }
            allMeals = meals.meals
            searchedMeal = allMeals
            self.mealsSubject.onNext(allMeals)
            
        }
            return
        }
    }
    init() {
        searchedMeal = allMeals

        mealsObservable = mealsSubject.asObservable()
        connectivityDriver = connectivitySubject.asDriver(onErrorJustReturn: false)
        observable = subject.asObservable()
        searchedMeal = allMeals
        searchValueObservable.subscribe(onNext:{ [self](serchedData) in
            print(serchedData)
            self.searchedMeal = self.allMeals?.filter({ (meal) in
                 meal.strMeal.lowercased().contains(serchedData.lowercased())
                    self.mealsSubject.onNext(searchedMeal)
                    self.isfiltered = false

                return true
            }
            )
           
        
    }).disposed(by: dispose)
        
    
}
}
