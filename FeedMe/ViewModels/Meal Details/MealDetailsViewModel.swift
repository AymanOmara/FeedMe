//
//  MealDetailsViewModel.swift
//  FeedMe
//
//  Created by Ayman Omara on 11/07/2021.
//

import Foundation
import RxSwift
class MealDetailsViewModel{
    var dataObservable:Observable<mealDetails>
    var ingredientObvservable:Observable<[IngredientsMesures]>
    var errorObservable:Observable<(String,Int)>
    var dataSubject = PublishSubject<mealDetails>()
    var errorSubject = PublishSubject<(String,Int)>()
    var ingredientSubject = PublishSubject<[IngredientsMesures]>()
    var allIngredients = [IngredientsMesures]();
    var noneEmptyIngredientArray = [IngredientsMesures]()
    let networking = Networking.shared
    let localManager = LocalManager.shared
    var details:mealDetails!
    var mealID:String = ""
    func featchData() -> Void {
        networking.getMealDetails(url:Constants.baseURL+Constants.mealDetails,mealID: mealID) { data, statusCode, error in
            guard let data = data else{
                self.errorSubject.onNext((error!.localizedDescription,statusCode!))
                return
            }
            self.details = mealDetails(strMeal: data.meals[0].strMeal, strMealThumb: data.meals[0].strMealThumb, idMeal: data.meals[0].idMeal, strCategory: data.meals[0].strCategory, strArea: data.meals[0].strArea, strInstructions: data.meals[0].strInstructions, strTags: data.meals[0].strTags, strYoutube: data.meals[0].strYoutube)
            self.allIngredients = [IngredientsMesures(ingredients: data.meals[0].strIngredient1 ?? "", mesures:data.meals[0].strMeasure1 ?? "" ),IngredientsMesures(ingredients: data.meals[0].strIngredient2 ?? "", mesures:data.meals[0].strMeasure2 ?? "" ),IngredientsMesures(ingredients: data.meals[0].strIngredient3 ?? "", mesures:data.meals[0].strMeasure3 ?? "" ),IngredientsMesures(ingredients: data.meals[0].strIngredient4 ?? "", mesures:data.meals[0].strMeasure4 ?? "" ),IngredientsMesures(ingredients: data.meals[0].strIngredient5 ?? "", mesures:data.meals[0].strMeasure5 ?? "" ),IngredientsMesures(ingredients: data.meals[0].strIngredient6 ?? "", mesures:data.meals[0].strMeasure6 ?? "" ),IngredientsMesures(ingredients: data.meals[0].strIngredient7 ?? "", mesures:data.meals[0].strMeasure7 ?? "" ),IngredientsMesures(ingredients: data.meals[0].strIngredient8 ?? "", mesures:data.meals[0].strMeasure8 ?? "" ),IngredientsMesures(ingredients: data.meals[0].strIngredient9 ?? "", mesures:data.meals[0].strMeasure9 ?? "" ),IngredientsMesures(ingredients: data.meals[0].strIngredient10 ?? "", mesures:data.meals[0].strMeasure10 ?? "" ),IngredientsMesures(ingredients: data.meals[0].strIngredient11 ?? "", mesures:data.meals[0].strMeasure11 ?? "" ),IngredientsMesures(ingredients: data.meals[0].strIngredient12 ?? "", mesures:data.meals[0].strMeasure12 ?? "" ),IngredientsMesures(ingredients: data.meals[0].strIngredient13 ?? "", mesures:data.meals[0].strMeasure13 ?? "" ),IngredientsMesures(ingredients: data.meals[0].strIngredient14 ?? "", mesures:data.meals[0].strMeasure14 ?? "" ),IngredientsMesures(ingredients: data.meals[0].strIngredient15 ?? "", mesures:data.meals[0].strMeasure15 ?? "" ),IngredientsMesures(ingredients: data.meals[0].strIngredient16 ?? "", mesures:data.meals[0].strMeasure16 ?? "" ),IngredientsMesures(ingredients: data.meals[0].strIngredient17 ?? "", mesures:data.meals[0].strMeasure17 ?? "" ),IngredientsMesures(ingredients: data.meals[0].strIngredient18 ?? "", mesures:data.meals[0].strMeasure18 ?? "" ),IngredientsMesures(ingredients: data.meals[0].strIngredient19 ?? "", mesures:data.meals[0].strMeasure19 ?? "" )]
            for i in self.allIngredients{
                if i.ingredients != "" {
                    self.noneEmptyIngredientArray.append(i)
                }
            }
            self.dataSubject.onNext(data.meals[0])
            
            self.ingredientSubject.onNext(self.noneEmptyIngredientArray)
            
            
        }
    }
    func SaveToLocal() -> Void {
        localManager.add(mealDetails: details, ingredientMesure: noneEmptyIngredientArray)
        
    }
    
    
    
    
    init() {
        dataObservable = dataSubject.asObservable()
        errorObservable = errorSubject.asObservable()
        ingredientObvservable = ingredientSubject.asObservable()
    }
}
