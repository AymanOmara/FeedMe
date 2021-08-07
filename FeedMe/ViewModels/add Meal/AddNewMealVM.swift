//
//  AddNewMealVM.swift
//  FeedMe
//
//  Created by Ayman Omara on 07/08/2021.
//

import Foundation
import UIKit
class AddNewMealViewModel{
    let localManager = LocalManager.shared
    func addNewMeal(mealDetails:mealDetails,ingredientMesure:[IngredientsMesures],image:UIImage) -> Void {
        localManager.add(mealDetails: mealDetails, image: image, ingredientMesure: ingredientMesure) { status in
            print(status)
        }
    }
}
