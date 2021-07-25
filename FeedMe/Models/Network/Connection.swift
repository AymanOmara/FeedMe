//
//  Connection.swift
//  FeedMe
//
//  Created by Ayman Omara on 25/07/2021.
//

import Foundation
import Reachability
import Alamofire
class Connection {
    static let share:Connection = Connection()
    let reachability = try! Reachability()
    func isConnected() -> Bool {
        if reachability.connection == .unavailable{
            return false
        }
        else{
            return true
        }
    }
    private init(){}
    
}
struct Connectivity {

    private init() {}
    static let sharedInstance = NetworkReachabilityManager()!
    static var isConnectedToInternet:Bool {
        return self.sharedInstance.isReachable
    }
}
