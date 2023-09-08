//
//  MealDetailViewModel.swift
//  Etienne_Wasil_FetchRecipeApp
//
//  Created by Etienne Wasil on 9/7/23.
//

import Foundation

class MealDetailViewModel: ObservableObject {
    
    @Published var recipeInfo: RecipeInformation?
    @Published var website = ""
    
    let idMeal: String
    
    
    init(idMeal: String) {
        self.idMeal = idMeal
        fetchData()
    }
    
    private func fetchData() {
        DataService.getMealInformation(id: idMeal) { fetchedInformation in
            if let fetchedInformation = fetchedInformation {
                DispatchQueue.main.async {
                    self.recipeInfo = fetchedInformation
                    print(fetchedInformation)
                }
            } else {
                print("Failed to fetch recipes")
            }
        }
    }
}
