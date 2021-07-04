//
//  Network.swift
//  FeedMe
//
//  Created by Ayman Omara on 03/07/2021.
//

import Foundation
import Alamofire

class Networking{
    
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

