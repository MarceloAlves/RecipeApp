//
//  Recipe.swift
//  Recipe1
//
//  Created by Marcelo Alves on 6/5/15.
//  Copyright (c) 2015 Marcelo Alves. All rights reserved.
//

import UIKit

class Recipe: NSObject, NSCoding {
    // Declare variables title and content
    var title: String?
    var content: String?
    
    // Initialize with title and content
    init(title:String, content: String) {
        self.title = title
        self.content = content
    }
    
    // Sometimes there isn't a title and content
    override init(){
        super.init()
    }
    
    // Decodes data in storage
    required init(coder aDecoder: NSCoder){
        if let titleDecoded = aDecoder.decodeObjectForKey("title") as? String {
            title = titleDecoded
        }
        
        if let contentDecoded = aDecoder.decodeObjectForKey("content") as? String {
            content = contentDecoded
        }
        
    }
    
    // Encodes data in storage
    func encodeWithCoder(aCoder: NSCoder) {
        if let titleEncoded = title {
            aCoder.encodeObject(titleEncoded, forKey: "title")
        }
        
        if let contentEncoded = content {
            aCoder.encodeObject(contentEncoded, forKey: "content")
        }
    }
}
