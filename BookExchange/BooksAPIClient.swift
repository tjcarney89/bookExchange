//
//  BooksAPIClient.swift
//  BookExchange
//
//  Created by TJ Carney on 3/14/17.
//  Copyright © 2017 TJ Carney. All rights reserved.
//

import Foundation
import Alamofire

class BooksAPIClient{
    
    class func getBooks(completion: @escaping ([[String:Any]]) -> Void) {
        Alamofire.request("https://flatironchallenge.herokuapp.com/books").responseJSON { (response) in
            let json = response.result.value as? [[String:Any]] ?? [[:]]
            completion(json)
            
        }
    }
    
    class func getBook(id: Int, completion: @escaping ([String:Any]) -> Void) {
        Alamofire.request("https://flatironchallenge.herokuapp.com/books/\(id)").responseJSON { (response) in
            let json = response.result.value as? [String:Any] ?? [:]
            completion(json)
        }
    }
    
    class func addBook(title: String, author: String, publisher: String, url: String) {
        let parameters = [
            "title": "\(title)",
            "author": "\(author)",
            "publisher": "\(publisher)",
            "url": "\(url)"
        ]
        Alamofire.request("https://flatironchallenge.herokuapp.com/books", method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil)
    }
    
    class func checkoutBook(id: Int, name: String) {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let newFormatter = DateFormatter()
        newFormatter.dateFormat = "MMM d, yyyy '@' h:mm a"
        let dateString = newFormatter.string(from: date)

        
        let parameters = [
            "lastcheckedout": true,
            "lastcheckedoutby": "\(name) on \(dateString)"
        ] as [String : Any]
        
        Alamofire.request("https://flatironchallenge.herokuapp.com/books/\(id)", method: .put, parameters: parameters, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
    
        }
    }
    
    class func deleteBook(id: Int) {
        Alamofire.request("https://flatironchallenge.herokuapp.com/books/\(id)", method: .delete).responseJSON { (response) in
        }
    }
    
    class func updateBook(id: Int, infos: [String:String]..., completion: @escaping () -> Void) {
        
        
        
        var parameters: [String:String] = [:]
        
        for info in infos {
            if info["title"] != nil {
                if let newTitle = info["title"] {
                    parameters.updateValue(newTitle, forKey: "title")
                }
            }
            if info["author"] != nil {
                if let newAuthor = info["author"] {
                    parameters.updateValue(newAuthor, forKey: "author")
                }
            }
            if info["publisher"] != nil {
                if let newPub = info["publisher"] {
                    parameters.updateValue(newPub, forKey: "publisher")
                }
            }
            if info["url"] != nil {
                if let newURL = info["url"] {
                    parameters.updateValue(newURL, forKey: "url")
                }
            }



        }

        
        Alamofire.request("https://flatironchallenge.herokuapp.com/books/\(id)", method: .put, parameters: parameters, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in

                completion()
        }

    }
}
