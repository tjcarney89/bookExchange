//
//  BooksTableViewController.swift
//  BookExchange
//
//  Created by TJ Carney on 3/14/17.
//  Copyright © 2017 TJ Carney. All rights reserved.
//

import UIKit

class BooksTableViewController: UITableViewController {
    
    let store = BooksDataStore.sharedInstance

    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DispatchQueue.main.async {
            self.store.makeBooks {
                self.tableView.reloadData()
            }
        }
        navigationItem.title = "Books"
    }

    

    // MARK: - Table view data source

   

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return store.books.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "bookCell", for: indexPath)
        let currentBook = store.books[indexPath.row]
        cell.textLabel?.text = currentBook.title
        cell.detailTextLabel?.text = currentBook.authors
        

        return cell
    }
    


    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "bookSegue" {
            if let destVC = segue.destination as? BookDetailViewController, let indexPath = tableView.indexPathForSelectedRow {
                let selectedBook = store.books[indexPath.row]
                destVC.book = selectedBook
                print(selectedBook)
            }
        }
    }
    

}
