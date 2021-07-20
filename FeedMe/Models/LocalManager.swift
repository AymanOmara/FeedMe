//
//  LocalManager.swift
//  FeedMe
//
//  Created by Ayman Omara on 16/07/2021.
//

import Foundation
import CoreData
import UIKit
import SDWebImage
class LocalManager {
    static let shared = LocalManager()
    
    func add(mealDetails:mealDetails,ingredientMesure:[IngredientsMesures]) -> Bool {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "CoreDetails", in: managedContext)
        let meal = NSManagedObject(entity: entity!, insertInto: managedContext)
        
        let image:UIImageView = UIImageView()
        image.sd_setImage(with: URL(string:mealDetails.strMealThumb))

        let data = image.image!.pngData()
        var ingredient:[String] = [String]()
        var mesure:[String] = [String]()
        for i in ingredientMesure{
            ingredient.append(i.mesures!)
            mesure.append(i.ingredients!)
        }
        let ingredienData = NSKeyedArchiver.archivedData(withRootObject:ingredient)
        let mesureData = NSKeyedArchiver.archivedData(withRootObject: mesure)
        meal.setValue(ingredienData, forKey: "ingrediants")
        
        meal.setValue(mesureData, forKey: "mesures")
        
        meal.setValue(mealDetails.strMeal, forKey: "name")
        meal.setValue(mealDetails.strYoutube, forKey: "youtube")
        meal.setValue(mealDetails.strCategory, forKey: "category")
        meal.setValue(mealDetails.idMeal, forKey: "id")
        meal.setValue(data, forKey: "image")
        meal.setValue(mealDetails.strInstructions, forKey: "instructions")
        meal.setValue(mealDetails.strArea, forKey: "area")
        meal.setValue(mealDetails.strTags, forKey: "tag")
        
        
        do{
            try managedContext.save()
            return true
        }catch{
            print(error.localizedDescription)
            return false
        }
        
    }
    func delete(id:String) -> Void {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        let featchRequst = NSFetchRequest<NSManagedObject>(entityName: "CoreDetails")
        if let array = try? managedContext.fetch(featchRequst){
            for item in array{
                if item.value(forKey: "id") as! String == id{
                    managedContext.delete(item)
                }
            }
        }
    }
    
    func retrive(complition:@escaping([mealDetails]?,[UIImage])->Void) ->Void{
        var arr:[mealDetails] = [mealDetails]()
       
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let managedContext = appDelegate.persistentContainer.viewContext
        var imageAraar = [UIImage]()
        let featchRequst = NSFetchRequest<NSManagedObject>(entityName: "CoreDetails")
        if let array = try? managedContext.fetch(featchRequst){
            if array.count > 0 {
                for i in array{
                    let stringRepresentation = ((NSKeyedUnarchiver.unarchiveObject(with: i.value(forKey: "ingrediants") as! Data) as! [String]).description)
                    let mesureRepresentation = ((NSKeyedUnarchiver.unarchiveObject(with: i.value(forKey: "mesures") as! Data) as! [String]).description)
        

                    let image  = UIImage(data: (i.value(forKey: "image") as! Data))!
                    imageAraar.append(image)
                    var details = mealDetails(strMeal: i.value(forKey: "name") as! String, strMealThumb: "", idMeal: i.value(forKey: "id") as! String, strCategory:  i.value(forKey: "category") as! String, strArea: i.value(forKey: "area") as! String, strInstructions: i.value(forKey: "instructions") as! String, strTags: i.value(forKey: "tag") as? String, strYoutube: i.value(forKey: "youtube") as? String,strIngredient1: stringRepresentation,strMeasure1: mesureRepresentation)

                    
                    arr.append(details)
                }

                complition(arr,imageAraar)
            }else{

                
            }
        }
    }
    func upData() -> Void {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        let featchRequst = NSFetchRequest<NSManagedObject>(entityName: "CoreDetails")
        if let array = try? managedContext.fetch(featchRequst){
            for item in array{
                if item.value(forKey: "id") as! String == "id"{
                    
                    item.setValue("ayman", forKey: "id")
                    print(item)
                    try? managedContext.save()
                }
                
            }
        }
        do{
            try! managedContext.save()
            
        }catch{
            //MARK:- Handel Error not saving
            print(error.localizedDescription)
        }
    }
    private init() {
        
    }
}

