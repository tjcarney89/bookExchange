//
//  AddBookViewController.swift
//  BookExchange
//
//  Created by TJ Carney on 3/14/17.
//  Copyright © 2017 TJ Carney. All rights reserved.
//

import UIKit



class AddBookViewController: UIViewController {
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var authorTextField: UITextField!
    @IBOutlet weak var publisherTextField: UITextField!
    @IBOutlet weak var urlTextField: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func submitButtonTapped(_ sender: Any) {
        let myalert = UIAlertController(title: "Fields Empty", message: "All Fields Are Required", preferredStyle: .alert)
        let myaction = UIAlertAction(title: "OK", style: .default) { (action) in
        }
        myalert.addAction(myaction)
        if !titleTextField.hasText || !authorTextField.hasText || !publisherTextField.hasText || !urlTextField.hasText {
            self.present(myalert, animated: true)
        } else {

            guard let title = titleTextField.text else {return}
            guard let author = authorTextField.text else {return}
            guard let publisher = publisherTextField.text else {return}
            guard let url = urlTextField.text else {return}
            BooksAPIClient.addBook(title: title, author: author, publisher: publisher, url: url)
            dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        let myAlert = UIAlertController(title: "Unsaved Changes", message: "Are you sure you want to leave? Changes you have made will not be saved.", preferredStyle: .alert)
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


