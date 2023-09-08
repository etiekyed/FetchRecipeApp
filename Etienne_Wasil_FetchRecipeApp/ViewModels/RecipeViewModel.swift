//
//  RecipeViewModel.swift
//  Etienne_Wasil_FetchRecipeApp
//
//  Created by Etienne Wasil on 9/7/23.
//

import Foundation

class RecipeViewModel: ObservableObject {
    
    @Published var recipes = [Meal]()
    
    init() {
        fetchData()
    }
    
    private func fetchData() {
        DataService.getAPIData { fetchedRecipes in
            if let fetchedRecipes = fetchedRecipes {
                DispatchQueue.main.async {
                    self.recipes = fetchedRecipes
                }
            } else {
                print("Failed to fetch recipes")
            }
        }
    }
    
}
