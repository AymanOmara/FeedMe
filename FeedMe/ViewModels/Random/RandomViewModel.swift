//
//  RandomViewModel.swift
//  FeedMe
//
//  Created by Ayman Omara on 14/07/2021.
//

import Foundation
import RxSwift
class RandomViewModel{
    var dataObservable:Observable<mealDetails>

    var errorObservable:Observable<(String,Int)>
    var errorSubject = PublishSubject<(String,Int)>()
    var dataSubject = PublishSubject<mealDetails>()
    let networking = Networking.shared
    func featchData() -> Void {
        networking.getRandomMeal { data, statusCode, error in

            self.dataSubject.onNext(data!.meals[0])
            
        }
    }
    init() {
        dataObservable = dataSubject.asObservable()
        errorObservable = errorSubject.asObservable()
    }
}
