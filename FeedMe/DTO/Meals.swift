//
//  Meals.swift
//  FeedMe
//
//  Created by Ayman Omara on 05/07/2021.
//

import Foundation
class Meals:Codable{
    let meals:[meal]
}
class meal:Codable{
    var strMeal,strMealThumb,idMeal:String
}
struct mealDetails: Codable {
    let strMeal,strMealThumb,idMeal:String
    let strCategory,strArea,strInstructions,strTags,strYoutube:String!
    var strIngredient2,strIngredient3,strIngredient4,strIngredient5,strIngredient7,strIngredient6:String?
    var strIngredient8,strIngredient9,strIngredient10,strIngredient11,strIngredient12,strIngredient13:String?
    var strIngredient14,strIngredient15,strIngredient16,strIngredient17,strIngredient18,strIngredient19:String?
    var strIngredient20,strIngredient1:String?
    var strMeasure1,strMeasure2,strMeasure3,strMeasure4,strMeasure5,strMeasure6,strMeasure7:String?
    var strMeasure8,strMeasure9,strMeasure10,strMeasure11,strMeasure12,strMeasure13:String?
    var strMeasure14,strMeasure15,strMeasure16,strMeasure17,strMeasure18,strMeasure19:String?

    
}
class MealDetails:Codable{
    let meals:[mealDetails]
}
class IngredientsMesures:NSCoding{
    func encode(with coder: NSCoder) {
        if let mesures = mesures { coder.encode(mesures, forKey: "mesures") }
        if let ingredients = ingredients { coder.encode(ingredients, forKey: "ingredients") }
    }
    
    var ingredients:String?
    var mesures:String?
    
    init(ingredients:String,mesures:String){
        
        self.ingredients = ingredients
        self.mesures = mesures
    }
    init() {
        
    }
    required convenience init(coder decoder: NSCoder) {
        self.init()
        self.ingredients = (decoder.decodeObject(forKey:"ingredients") as! String)
        self.mesures = (decoder.decodeObject(forKey: "mesures") as! String)
    }
    convenience init(name: String, age: String) {
        self.init()
        self.ingredients = ingredients
        self.mesures = mesures
    }
    
}
