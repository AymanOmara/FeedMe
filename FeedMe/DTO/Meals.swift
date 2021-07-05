//
//  Meals.swift
//  FeedMe
//
//  Created by Ayman Omara on 05/07/2021.
//

import Foundation
struct Meals:Codable{
    let meals:[meal]
}
struct meal:Codable{
    let strMeal,strMealThumb,idMeal:String
}
