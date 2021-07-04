//
//  APIContracts.swift
//  FeedMe
//
//  Created by Ayman Omara on 03/07/2021.
//

import Foundation
protocol CategoryContract {
    func getAllCategories(completion:@escaping (Category?,Int?,Error?)->Void)->Void
}
