//
//  UpdateBookViewController.swift
//  BookExchange
//
//  Created by TJ Carney on 3/14/17.
//  Copyright © 2017 TJ Carney. All rights reserved.
//

import UIKit

protocol UpdateBookVCDelegate: class {
    func updateBookInfo()
}



class UpdateBookViewController: UIViewController {
    
    @IBOutlet weak var bookTitleTextField: UITextField!
    @IBOutlet weak var authorTextField: UITextField!
    @IBOutlet weak var publisherTextField: UITextField!
    @IBOutlet weak var urlTextField: UITextField!
    
    var id = Int()
    var store = BooksDataStore.sharedInstance
    var delegate: UpdateBookVCDelegate?
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        print("ID: \(id)")
        
    }

    
    @IBAction func updateButtonTapped(_ sender: Any) {
        var title: String = ""
        var author: String = ""
        var publisher: String = ""
        var url: String = ""
        var updatedInfo: [String:String] = [:]
        
        if bookTitleTextField.hasText {
            if let newTitle = bookTitleTextField.text {
                title = newTitle
                updatedInfo.updateValue(title, forKey: "title")
                print(title)
            }
        }
        if authorTextField.hasText {
            if let newAuthor = authorTextField.text {
                author = newAuthor
                updatedInfo.updateValue(author, forKey: "author")
            }
        }
        if publisherTextField.hasText {
            if let newPublisher = publisherTextField.text {
                publisher = newPublisher
                updatedInfo.updateValue(publisher, forKey: "publisher")
            }
        }
        if urlTextField.hasText {
            if let newurl = urlTextField.text {
                url = newurl
                updatedInfo.updateValue(url, forKey: "url")
            }
        }
        let myAlert = UIAlertController(title: "Update Book Info", message: "Are you sure you want to update this information?", preferredStyle: .alert)
        let yesAction = UIAlertAction(title: "Yes", style: .default) { (action) in
            BooksAPIClient.updateBook(id: self.id, infos: updatedInfo, completion: {
                self.delegate?.updateBookInfo()
                self.dismiss(animated: true, completion: nil)
            })
            

        }
        let noAction = UIAlertAction(title: "No", style: .default) { (action) in

        }
        myAlert.addAction(yesAction)
        myAlert.addAction(noAction)
        self.present(myAlert, animated: true)
        
        
    }
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        let myAlert = UIAlertController(title: "Unsaved Changes", message: "You have unsaved changes. Are you sure you want to exit?", preferredStyle: .alert)
        let yesAction = UIAlertAction(title: "Yes", style: .default) { (action) in
            self.dismiss(animated: true, completion: nil)
        }
        let noAction = UIAlertAction(title: "No", style: .default) { (action) in
            
        }
        myAlert.addAction(yesAction)
        myAlert.addAction(noAction)
        self.present(myAlert, animated: true)

    }
    
    
    
    
    

}
