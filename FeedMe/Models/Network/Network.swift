//
//  Network.swift
//  FeedMe
//
//  Created by Ayman Omara on 03/07/2021.
//

import Foundation
import Alamofire
import Reachability
class Networking{
    let reachability = try! Reachability()

    
    func chechTheConnection() -> Void {
            
//        if reachability.whenReachable{
//            print(true)
//        }
    }
//    reachability.whenReachable = { reachability in
//        if reachability.connection == .wifi {
//            print("Reachable via WiFi")
//        } else {
//            print("Reachable via Cellular")
//        }
//    }
//    reachability.whenUnreachable = { _ in
//        print("Not reachable")
//    }
//
//    do {
//        try reachability.startNotifier()
//    } catch {
//        print("Unable to start notifier")
//    }
    static let shared = Networking()
    
    private init() {
    }
    //    func get(completion:@escaping (Category?,Int?,Error?)->Void){
    //        AF.request(Constants.baseURL+Constants.categoryURL).validate()
    //            .responseDecodable(of: Category.self) { (response) in
    //                switch response.result {
    //
    //                case .success( _):
    //                    completion(response.value,response.response?.statusCode,nil)
    //
    //                case .failure(let error):
    //                   // print(error.localizedDescription)
    //                    completion(nil,response.response?.statusCode,error)
    //                }
    //            }
    //    }
    
}

extension Networking:CategoryContract {
    func getAllCategories(completion:@escaping (Category?,Int?,Error?)->Void)->Void{
        AF.request(Constants.baseURL+Constants.categoryURL).validate()
            .responseDecodable(of: Category.self) { (response) in
                switch response.result {
                
                case .success( _):
                    completion(response.value,response.response?.statusCode,nil)
                    
                case .failure(let error):
                    completion(nil,response.response?.statusCode,error)
                }
            }
        
    }
    
}
extension Networking{
    func getAllMeals(categoryName:String,complition:@escaping (Meals?,Int?,Error?)->Void)->Void{
        AF.request(Constants.baseURL+Constants.filterCategory+categoryName).validate().responseDecodable(of: Meals.self){ (response) in
            switch (response.result){
            case .success(let meals):
                complition(meals,response.response?.statusCode,nil)
            case .failure(let error):
                complition(nil,response.response?.statusCode,error)
            }
            
        }
    }
}

extension Networking{
    func getMealDetails(url:String,mealID:String,complition:@escaping (MealDetails?,Int?,Error?)->Void) -> Void {
        AF.request(url+mealID).validate()
            .responseDecodable(of: MealDetails.self) { (response) in
                switch response.result {
                
                case .success( _):
                    complition(response.value,response.response?.statusCode,nil)
                    
                case .failure(let error):
                    complition(nil,response.response?.statusCode,error)
                }
        }
    }
}

extension Networking{
    func getRandomMeal(complition:@escaping (MealDetails?,Int?,Error?)->Void) -> Void {
        AF.request(Constants.baseURL+Constants.randomMeal).validate()
            .responseDecodable(of: MealDetails.self) { (response) in
                switch response.result {
                
                case .success( _):
                    complition(response.value,response.response?.statusCode,nil)
                    
                case .failure(let error):
                    complition(nil,response.response?.statusCode,error)
                }
        }
    }
}
