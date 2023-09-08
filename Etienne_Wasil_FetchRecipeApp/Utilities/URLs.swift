//
//  URLs.swift
//  Etienne_Wasil_FetchRecipeApp
//
//  Created by Etienne Wasil on 9/7/23.
//

import Foundation

struct URLs {
    
    static var dessertURL = URL(string: "https://themealdb.com/api/json/v1/1/filter.php?c=Dessert")!
    
    static func dessertDetailURL(url: String) -> URL {
        let completedURL = "https://themealdb.com/api/json/v1/1/lookup.php?i=\(url)"
        return URL(string: completedURL)!
    }
    
}
