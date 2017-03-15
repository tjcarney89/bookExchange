//
//  BookDetailViewController.swift
//  BookExchange
//
//  Created by TJ Carney on 3/14/17.
//  Copyright © 2017 TJ Carney. All rights reserved.
//

import UIKit

class BookDetailViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var publisherLabel: UILabel!
    @IBOutlet weak var lastCheckedOutLabel: UILabel!
    @IBOutlet weak var checkedOutInfoLabel: UILabel!
    
    
    
    var book : Book?
    var updatedBook: Book? {
        didSet {
            updateLabels()
        }
    }
    
    
    var wasUpdated = false
    var store = BooksDataStore.sharedInstance
    
    func updateLabels() {
        if let bookTitle = self.updatedBook?.title {
            print(bookTitle)
            titleLabel.text = bookTitle
        }
        if let author = self.updatedBook?.authors {
            authorLabel.text = author
        }
        if let publisher = self.updatedBook?.publisher {
            publisherLabel.text = "Publisher: \(publisher)"
        }
        if let checkedOut = self.updatedBook?.lastCheckedOutBy {
            checkedOutInfoLabel.text = checkedOut
        } else {
            checkedOutInfoLabel.text = "Has Not Been Checked Out Yet"
        }

        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        if let bookTitle = self.book?.title {
            print(bookTitle)
            titleLabel.text = bookTitle
        }
        if let author = self.book?.authors {
            authorLabel.text = author
        }
        if let publisher = self.book?.publisher {
            publisherLabel.text = "Publisher: \(publisher)"
        }
        if let checkedOut = self.book?.lastCheckedOutBy {
            checkedOutInfoLabel.text = checkedOut
        } else {
                checkedOutInfoLabel.text = "Has Not Been Checked Out Yet"
        }
        
        
    

        
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.title = self.book?.title
        
        if wasUpdated == true {
            if let id = self.book?.id {
                store.makeBook(id: id, completion: {
                    self.updatedBook = self.store.newBook
                })
            }
            
            
        }

    }
    
    
    @IBAction func checkoutButtonTapped(_ sender: Any) {
        let myAlert = UIAlertController(title: "Checkout Book", message: "Please Enter Your Name", preferredStyle: .alert)
        myAlert.addTextField()
        let submitAction = UIAlertAction(title: "Submit", style: .default) { (action) in
            if let submit = myAlert.textFields?[0].text {
                if let id = self.book?.id {
                    BooksAPIClient.checkoutBook(id: id, name: submit)
                }
                
                
            }
            self.navigationController?.popViewController(animated: true)
            self.dismiss(animated: true, completion: nil)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .default) { (action) in

        }
        myAlert.addAction(submitAction)
        myAlert.addAction(cancelAction)
        self.present(myAlert, animated: true)
        
        
    }
    
    
    @IBAction func deleteButtonTapped(_ sender: Any) {
        let myAlert = UIAlertController(title: "Delete Book", message: "Are you sure you want to delete this book?", preferredStyle: .alert)
        let yesAction = UIAlertAction(title: "Yes", style: .default) { (action) in
            if let id = self.book?.id {
                BooksAPIClient.deleteBook(id: id)
                self.navigationController?.popViewController(animated: true)
                self.dismiss(animated: true, completion: nil)
            }
            
        }
        let noAction = UIAlertAction(title: "No", style: .default) { (action) in
        }
        myAlert.addAction(yesAction)
        myAlert.addAction(noAction)
        self.present(myAlert, animated: true)
       
    }
    
    

        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "updateSegue" {
                if let destVC = segue.destination as? UpdateBookViewController {
                    if let id = self.book?.id {
                        destVC.id = id
                        destVC.delegate = self 
                    }
                    
                }
            }
        }


}

extension BookDetailViewController: UpdateBookVCDelegate {
    func updateBookInfo() {
        print("GETTING CALLED")
        wasUpdated = true
        print(wasUpdated)
        
    }
}
