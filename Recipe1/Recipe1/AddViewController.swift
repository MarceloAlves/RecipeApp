//
//  AddViewController.swift
//  Recipe1
//
//  Created by Marcelo Alves on 6/5/15.
//  Copyright (c) 2015 Marcelo Alves. All rights reserved.
//

import UIKit

class AddViewController: UIViewController {

    @IBOutlet var titleText: UITextField!
    @IBOutlet var recipeContent: UITextView!
    @IBOutlet var doneButton: UIBarButtonItem!
    @IBOutlet var addButton: UIButton!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // Set background color of title input to black at 20% with white text
        titleText.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.2)
        titleText.textColor = UIColor.whiteColor()
        
        // Sets the text area for the content to black at 20%
        recipeContent.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.2)
        
        // Disables the add button
        addButton.enabled = false
        
        // Adds an observer to textTitle and recipeContent to watch for text input
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "textTitleDidChange", name: UITextFieldTextDidChangeNotification, object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "recipeContentDidChange", name: UITextViewTextDidChangeNotification, object: nil)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Hooks up to observe to control button state
    func textTitleDidChange(){
        handleButtonStates()
    }
    
    // Hooks up to observe to control button state
    func recipeContentDidChange(){
        handleButtonStates()
    }
    
    // When clicking top done button, hide keyboard
    @IBAction func doneButton_click(sender: AnyObject) {
        recipeContent.resignFirstResponder()
    }
    
    // When clicking keyboard done button, hide keyboard
    @IBAction func titleDoneButton_click(sender: AnyObject) {
        titleText.resignFirstResponder()
    }
    
    
    func handleButtonStates(){
        // If content is not empty, top done button is enabled
        if(recipeContent.text != ""){
            doneButton.enabled = true
        }
        else {
            // If it's empty, top done button is disabled
            doneButton.enabled = false
        }
        
        // If text and content are not empty, enable add button
        if(titleText.text != "" && recipeContent.text != ""){
            addButton.enabled = true
            addButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        }
        else {
            // If empty, disable add button
            addButton.enabled = false
            addButton.setTitleColor(UIColor.lightGrayColor(), forState: UIControlState.Normal)
        }
    }
    
    // Add Button Logic
    @IBAction func addButton_click(sender: AnyObject) {
        // Animate loading indicator
        activityIndicator.startAnimating()
        
        // Create a new recipe with title and content using RecipeManager
        RecipeManager.AddRecipe(titleText.text, content: recipeContent.text)
        
        // Set current title and content to be empty
        titleText.text = ""
        recipeContent.text = ""
        
        // Sync storage with data
        NSUserDefaultsManager.synchronize()
        
        // Delay in saving so that indicator is seen
        let time = dispatch_time(DISPATCH_TIME_NOW, Int64(0.5 * Double(NSEC_PER_SEC)))
        
        // Stop animating
        dispatch_after(time, dispatch_get_main_queue()){
            self.activityIndicator.stopAnimating()
        }
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
