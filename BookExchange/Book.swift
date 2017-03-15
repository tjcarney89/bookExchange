//
//  Book.swift
//  BookExchange
//
//  Created by TJ Carney on 3/14/17.
//  Copyright © 2017 TJ Carney. All rights reserved.
//

import Foundation

class Book {
    
    let title: String
    let authors: String
    let publisher: String
    let lastCheckedOut: String?
    let lastCheckedOutBy: String?
    let id: Int
    
    init(dictionary: [String:Any]) {
        self.title = dictionary["title"] as! String? ?? "No Title"
        self.authors = dictionary["author"] as! String? ?? "Anonymous"
        self.publisher = dictionary["publisher"] as! String? ?? "No Publisher"
        self.id = dictionary["id"] as! Int 
        if let checkedOut = dictionary["lastcheckedout"] {
            self.lastCheckedOut = checkedOut as? String
        } else {
            lastCheckedOut = "Has Not Been Checked Out Yet"
        }
        
        if let checkedOutBy = dictionary["lastcheckedoutby"] {
            self.lastCheckedOutBy = checkedOutBy as? String
        } else {
            lastCheckedOutBy = "No One Has Checked This Book Out"
        }
        
        
        
    }
}

extension Book: CustomStringConvertible {
    var description: String {
        return "Title: \(title), Author(s): \(authors), Publisher: \(publisher), ID: \(id), Last Checked Out: \(lastCheckedOut), Last Checked Out By: \(lastCheckedOutBy)"
    }
}
