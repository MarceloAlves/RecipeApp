//
//  ViewController.swift
//  Recipe1
//
//  Created by Marcelo Alves on 6/4/15.
//  Copyright (c) 2015 Marcelo Alves. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Set the tables row height to 70
        tableView.rowHeight = 70
        // Set table background image to breads.pdf
        tableView.backgroundView = UIImageView(image: UIImage(named: "breads"))
        
        // Call data from storage
        NSUserDefaultsManager.initializeDefaults()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        // Reloads data in the table
        tableView.reloadData()
        // Sets transparency of top navigation bar
        navigationController?.navigationBar.alpha = 0.5
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Creates the number of rows required to show all recipes via RecipesManager
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return RecipeManager.recipes.count
    }
    
    // Creates the Table
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // Reusable cell 'customcell'
        let cell = tableView.dequeueReusableCellWithIdentifier("customcell") as! customcell
        
        // If item is even, clear cell color
        if(indexPath.item % 2 == 0){
            cell.backgroundColor = UIColor.clearColor()
        } else {
            // Else make it white at 20% transparency
            cell.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.2)
            cell.textLabel?.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.0)
        }
        
        // Set cell text color to white
        cell.textLabel?.textColor = UIColor.whiteColor()
        
        // Set recipe to actual recipe at table cell index key using RecipeManager and recipes array
        let recipe = RecipeManager.recipes[indexPath.item]
        // Set cell label to recipe title
        cell.textLabel?.text = recipe.title
        // Link cell recipe to recipe
        cell.recipe = recipe
        // Show cell
        return cell
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        // Swipe left to delete
        if(editingStyle == .Delete){
            // Remove item from array using .DeleteRecipe method
            RecipeManager.DeleteRecipe(indexPath.item)
            // Delete row in table
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Move into detailview
        if(segue.identifier == "detailview"){
            // Use "customcell"
            let cell = sender as! customcell
            // Send data to detail view
            let detailview = segue.destinationViewController as! DetailViewController
            // Set detailview recipe
            detailview.preRecipe = cell.recipe
        }
    }
}

