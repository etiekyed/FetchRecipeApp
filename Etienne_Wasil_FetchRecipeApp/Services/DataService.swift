//
//  DataService.swift
//  Etienne_Wasil_FetchRecipeApp
//
//  Created by Etienne Wasil on 9/7/23.
//

import Foundation

class DataService {
    
    static func getAPIData(completion: @escaping ([Meal]?) -> ()) {
        
        let task = URLSession.shared.dataTask(with: URLs.dessertURL) { data, _, error in
            
            //Check to see if data is returned and/or errors occured
            guard let data = data, error == nil else {
                completion(nil)
                return
            }
            
            //Parse JSON
            let decoder = JSONDecoder()
            
            do {
                let response = try decoder.decode(MealResponse.self, from: data)
                completion(response.meals)
            }
            catch {
                //Check for erros in parsing JSON
                print(error)
                completion(nil)
            }
            
        }
        task.resume()
    }
    
    static func getMealInformation(id: String, completion: @escaping (RecipeInformation?) -> ()) {
        
        let task = URLSession.shared.dataTask(with: URLs.dessertDetailURL(url: id)) { data, _, error in
            
            //Check to see if data is returned and/or errors occurred
            guard let data = data, error == nil else {
                completion(nil)
                return
            }
            
            //Parse JSON
            let decoder = JSONDecoder()
            
            do {
                let response = try decoder.decode(RecipeInformationResponse.self, from: data)
                if let firstMeal = response.meals.first {
                    completion(firstMeal)
                } else {
                    completion(nil)
                }
            }
            catch {
                //Check for errors in parsing JSON
                print(error)
                completion(nil)
            }
            
        }
        task.resume()
    }
    
}
