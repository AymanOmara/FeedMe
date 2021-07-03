//
//  APIContracts.swift
//  FeedMe
//
//  Created by Ayman Omara on 03/07/2021.
//

import Foundation
protocol CategoryContract {
    func getAllCategory(complition:@escaping  ((Category?,String?,Int?)->Void)) -> Void 
}
