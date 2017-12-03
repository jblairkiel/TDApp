//
//  BoardTableViewController.swift
//  TigerDroppings
//
//  Created by James Kiel on 11/25/17.
//  Copyright © 2017 James Kiel. All rights reserved.
//

import UIKit

class BoardThreadsViewController: UITableViewController {
    
    
    
    //MARK: Properties
    @IBOutlet weak var boardThreadTitle: UINavigationItem!
    var apiManager = APIManager()
    var threads = [Thread]()
    var boardVal: Board? = nil
    
    private func loadThreads(){
        apiManager.makeHTTPGetRequest(path: (boardVal?.boardURL)!, success: {
            response in
            let tdParser = TDParser.init(htmlContent: response,contentType: self.boardVal?.boardName)
            
            //guard let board1 = Board(boardName: "Home", boardURL: "https://tigerdroppings.com/") else{
            //    fatalError("Unable to initialize board1")
           // }
            
            //guard let board2 = Board(boardName: "SEC Rant", boardURL: "https://www.secrant.com/rant/sec-football/") else{
            //    fatalError("Unable to initialize board1")
            //}
            
            //guard let board3 = Board(boardName: "Fark Board", boardURL: "https://www.secrant.com/rant/sec-football/") ///else{
            //    fatalError("Unable to initialize board1")
           // }
            let arr = tdParser.getItems(tdForum: self.boardVal?.boardName)
            for thread in arr{
                self.threads.append(thread)
            }
            self.tableView.reloadData()
            //self.threads += [board1, board2, board3]
            
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadThreads()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        return self.threads.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "BoardThreadsViewCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier,
                                                       for: indexPath) as? BoardThreadsViewCell  else {
                                                        fatalError("The dequeued cell is not an instance of BoardThreadsViewCell.")
        }

        
        let thread = self.threads[indexPath.row]
        cell.threadNameLabel.numberOfLines = 0;
        cell.threadNameLabel.lineBreakMode = .byWordWrapping;
        cell.threadNameLabel.text = thread.threadTitle
        cell.threadAuthorLabel.text = thread.threadAuthor
        
        return cell
    }
    
}

