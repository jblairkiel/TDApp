//
//  BoardTableViewController.swift
//  TigerDroppings
//
//  Created by James Kiel on 11/25/17.
//  Copyright © 2017 James Kiel. All rights reserved.
//

import UIKit

class BoardTitlesViewController: UITableViewController {

    
    
    //MARK: Properties
    var apiManager = APIManager()
    var boards = [Board]()
    
    private func loadBoards(){
    
        guard let board1 = Board(boardName: "Home", boardURL: "https://tigerdroppings.com/") else{
            fatalError("Unable to initialize board1")
        }
        
        guard let board2 = Board(boardName: "SEC Rant", boardURL: "https://www.secrant.com/rant/sec-football/") else{
            fatalError("Unable to initialize board1")
        }
        
        guard let board3 = Board(boardName: "Fark Board", boardURL: "https://www.secrant.com/rant/sec-football/") else{
            fatalError("Unable to initialize board1")
        }
        
        
        boards += [board1, board2, board3]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadBoards()

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
        return boards.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "BoardTitlesViewCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier,
        for: indexPath) as? BoardTitlesViewCell  else {
            fatalError("The dequeued cell is not an instance of BoardTitlesViewCell.")
        }
        
        let board = boards[indexPath.row]
        cell.boardNameLabel.text = board.boardName
        
        return cell
    }
    
}
