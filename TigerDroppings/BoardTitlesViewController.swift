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
    var boardNames = [String]()
    var boardLinks = [String]()
    var boards = [Board]()
    var selectedBoard: Board? = nil
    
    private func loadBoards(){
    
        if let URL = Bundle.main.url(forResource: "BoardNames", withExtension: "plist") {
            if let boardNamesFromPList = NSArray(contentsOf: URL) as? [String] {
                for boardName in boardNamesFromPList {
                    boardNames.append(boardName)
                }
            }
        }
        
        if let URL = Bundle.main.url(forResource: "BoardLinks", withExtension: "plist") {
            if let boardLinksFromPList = NSArray(contentsOf: URL) as? [String] {
                for boardLink in boardLinksFromPList {
                    boardLinks.append(boardLink)
                }
            }
        }
        
        for i in 0 ..< boardNames.count{
            self.boards.append(Board(boardName: boardNames[i],boardURL:boardLinks[i])!)
        }
        /*
        guard let board1 = Board(boardName: "Home", boardURL: "https://tigerdroppings.com/") else{
            fatalError("Unable to initialize board1")
        }
        
        guard let board2 = Board(boardName: "SEC Rant", boardURL: "https://www.secrant.com/rant/sec-football/") else{
            fatalError("Unable to initialize board1")
        }
        
        guard let board3 = Board(boardName: "LSU Recruiting", boardURL: "https://www.tigerdroppings.com/rant/lsu-recruiting/") else{
            fatalError("Unable to initialize board1")
        }*/
        
        
        //boards += [board1, board2, board3]
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
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Row \(indexPath.row)selected")
        selectedBoard = self.boards[indexPath.row]
        
        performSegue(withIdentifier: "OpenThreadsSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        super.prepare(for: segue, sender: sender)
        
        if(segue.identifier == "OpenThreadsSegue") {
 
            var vc = segue.destination as! BoardThreadsViewController
            vc.boardVal = selectedBoard
            vc.boardThreadTitle.title = selectedBoard?.boardName
        }
    }

    
}
