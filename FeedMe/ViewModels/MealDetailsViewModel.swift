//
//  MealDetailsViewModel.swift
//  FeedMe
//
//  Created by Ayman Omara on 11/07/2021.
//

import Foundation
import RxSwift
class MealDetailsViewModel{
    var dataObservable:Observable<mealDetails>
    var errorObservable:Observable<(String,Int)>
    var dataSubject = PublishSubject<mealDetails>()
    var errorSubject = PublishSubject<(String,Int)>()
    let networking = Networking.shared
    var mealID:String = ""
    func featchData() -> Void {
        networking.getMealDetails(mealID: mealID) { data, statusCode, error in
            guard let data = data else{
                self.errorSubject.onNext((error!.localizedDescription,statusCode!))
                return
            }
            self.dataSubject.onNext(data.meals[0])

            
        }
    }
    init() {
        dataObservable = dataSubject.asObservable()
        errorObservable = errorSubject.asObservable()
    }
}
