//
//  RecipeManager.swift
//  Recipe1
//
//  Created by Marcelo Alves on 6/5/15.
//  Copyright (c) 2015 Marcelo Alves. All rights reserved.
//

import UIKit

class RecipeManager: NSObject {
    // Recipes variable made up of Recipe array
    static var recipes = [Recipe]()
    
    // Add recipe using title and string then append to recipes array
    class func AddRecipe(title: String, content: String){
        var r = Recipe(title: title, content: content)
        recipes.append(r)
    }
    
    // Delete a recipe from the array
    class func DeleteRecipe(id: Int){
        recipes.removeAtIndex(id)
    }
    
    // Get the recipe data from the array
    class func GetRecipe(id: Int) -> Recipe {
        if(recipes.count > 0){
            return recipes[id]
        }
        
        return Recipe()
    }
}
