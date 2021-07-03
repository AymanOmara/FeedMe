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
    
    
}

extension Networking:CategoryContract {
    func getAllCategory(complition:@escaping  ((Category?,String?,Int?)->Void)) -> Void {
        let url = URL(string: Constants.baseURL+Constants.categoryURL)
        let request = URLRequest(url: url!)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let d = data{
                guard let decodedResponse = try? JSONDecoder().decode(Category.self, from: d)else{return}
                
                var r = response  as? HTTPURLResponse
                complition(decodedResponse,"",r!.statusCode)
            }
            if let error = error{
                var r = response  as? HTTPURLResponse
                complition(nil,error.localizedDescription,r!.statusCode)
            }
            
        }
        task.resume()
        
    }
    
}
