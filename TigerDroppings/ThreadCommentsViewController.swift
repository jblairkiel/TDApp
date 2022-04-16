//
//  BoardTableViewController.swift
//  TigerDroppings
//
//  Created by James Kiel on 11/25/17.
//  Copyright © 2017 James Kiel. All rights reserved.
//

import UIKit
import WebKit
import SwiftSoup

class ThreadCommentsViewController: UITableViewController,WKUIDelegate {
    
    
    
    //MARK: Properties
    var apiManager = APIManager()
    var comments = [Comment]()
    var threadVal: Thread? = nil
    var contentHeights = [CGFloat]()
    var trIndexPath = IndexPath(row: 0, section: 0)
    private func loadComments(){
        var strLink: String = ""
        if(threadVal?.threadForum == "SEC Rant"){
            strLink = "https://www.secrant.com" + (self.threadVal?.threadLink)!
        }else{
            strLink = "https://www.tigerdroppings.com" + (self.threadVal?.threadLink)!
        }
        apiManager.makeHTTPGetRequest(path: strLink, success: {
            response in
            let tdParser = TDParser.init(htmlContent: response,contentType: self.threadVal?.threadTitle)
            let arr = tdParser.getComments(tdForum: self.threadVal?.threadTitle)
            
            var i : Int = 0
            for comment in arr{
                //comment.toString()
                self.comments.append(comment)
                self.contentHeights.insert(CGFloat(100.0), at: i)
                i += 1
            }
            self.tableView.reloadData()
        })
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadComments()
        
        tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        tableView.dataSource = self
        tableView.delegate = self
        
        
        
        //tableView.estimatedRowHeight = 90
        //tableView.rowHeight = UITableViewAutomaticDimension
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
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.contentHeights[indexPath.row]
        //return UITableViewAutomaticDimension
    }


    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        return self.comments.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "ThreadCommentsViewCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier,
                                                       for: indexPath) as? ThreadCommentsViewCell  else {
                                                        fatalError("The dequeued cell is not an instance of ThreadCommentsViewCell.")
        }
        
        let comment = self.comments[indexPath.row]
        let commentEls = self.comments[indexPath.row].commentContent
        var i: Int = 0
        
        var commentContent: Element? = nil
        while(i < commentEls.count){
            commentContent = commentEls[i]
            if(commentContent?.tagName() != "h1"){
                print("test")
            }
            i += 1
        }
        
        trIndexPath = indexPath
        cell.authorLabel.text = comment.commentAuthor
        cell.greenUpvotesLabel.text = comment.commentLikesUp
        cell.redDownvotesLabel.text = comment.commentLikesDown
        cell.contentView.layer.borderColor = UIColor.black.cgColor
        cell.contentView.layer.borderWidth = 0.8
        
        self.tableView.setNeedsLayout()
        self.tableView.layoutIfNeeded()
        
        return cell
    }
    
    
    private func stringFromHtml(string: String) -> NSAttributedString? {
        do {
            return try NSAttributedString(data: Data(string.utf8),
                                          options: [.documentType: NSAttributedString.DocumentType.html,
                                                    .characterEncoding: String.Encoding.utf8.rawValue],
                                          documentAttributes: nil)
        } catch {
            print("error: ", error)
            return nil
        }
    }
    
    private func allLoaded() -> Bool {
        let allRowsHeights = self.contentHeights
        for height in allRowsHeights{
        if(height == CGFloat(5.0)){
        return false
        }
        }
        return true;
    }
    
    //override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
    //    return UITableViewAutomaticDimension
    //}
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print("Row \(indexPath.row)selected")
        self.comments[indexPath.row].toString()
        
        //performSegue(withIdentifier: "OpenCommentsSegue", sender: self)
    }

  
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    
  
}


