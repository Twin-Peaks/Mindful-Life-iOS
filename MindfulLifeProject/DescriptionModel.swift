//
//  DescriptionModel.swift
//  MindfulLifeProject
//
//  Created by Christopher Queen on 11/28/15.
//  Copyright © 2015 Christopher Queen. All rights reserved.
//

import Foundation

struct DescriptionModel {
    
    func getContent(language: String) -> (title:String, description: String, benefits1: String, benefits2: String) {
        
        var title:String, description:String, benefits1:String, benefits2: String
        
        if language == "english" {
            title = "What Is Mindfulness?"
            description = "This is the description"
            benefits1 = "Benefits 1"
            benefits2 = "Benefits 2"
        } else {
            title = "Spanish What Is Mindfulness?"
            description = "Spanish This is the description"
            benefits1 = "Spanish Benefits 1"
            benefits2 = "Spanish Benefits 2"
        }
        
        return (title: title, description:description, benefits1:benefits1, benefits2:benefits2)
    }
    
    func test(language:String) {
        print("Test \(language)");
    }
}