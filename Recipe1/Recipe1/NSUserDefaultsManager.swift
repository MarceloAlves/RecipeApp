//
//  NSUserDefaultsManager.swift
//  Recipe1
//
//  Created by Marcelo Alves on 6/5/15.
//  Copyright (c) 2015 Marcelo Alves. All rights reserved.
//

import UIKit

class NSUserDefaultsManager: NSObject {
    // Storage data
    static let userDefaults = NSUserDefaults.standardUserDefaults()
    
    // Syncs storage with inputted data
    class func synchronize(){
        let myData = NSKeyedArchiver.archivedDataWithRootObject(RecipeManager.recipes)
        NSUserDefaults.standardUserDefaults().setObject(myData, forKey: "recipearray")
        NSUserDefaults.standardUserDefaults().synchronize()
    }
    
    class func initializeDefaults(){
        if let recipesRaw = NSUserDefaults.standardUserDefaults().dataForKey("recipearray"){
            if let recipes = NSKeyedUnarchiver.unarchiveObjectWithData(recipesRaw) as? [Recipe] {
                RecipeManager.recipes = recipes
            }
        }
    }
}
