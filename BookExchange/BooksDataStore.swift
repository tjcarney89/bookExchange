//
//  BooksDataStore.swift
//  BookExchange
//
//  Created by TJ Carney on 3/14/17.
//  Copyright © 2017 TJ Carney. All rights reserved.
//

import Foundation

class BooksDataStore {
    static let sharedInstance = BooksDataStore()
    private init () {}
    
    var books = [Book]()
    var newBook: Book?
    
    func makeBooks(completion: @escaping () -> Void) {
        books.removeAll()
        BooksAPIClient.getBooks { (bookDict) in
            for book in bookDict {
                let newBook = Book(dictionary: book)
                self.books.append(newBook)
            }
            completion()
        }
    }
    
    func makeBook(id: Int, completion: @escaping () -> Void) {
        BooksAPIClient.getBook(id: id) { (bookDict) in
            let newerBook = Book(dictionary: bookDict)
            self.newBook = newerBook
            print(self.newBook)
            completion()
        }
        
    }
}
