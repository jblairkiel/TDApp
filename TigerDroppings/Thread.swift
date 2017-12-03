//
//  Thread.swift
//  TigerDroppings
//
//  Created by James Kiel on 11/28/17.
//  Copyright © 2017 James Kiel. All rights reserved.
//

import UIKit


public class Thread {
    
    //MARK: Properties
    
    var threadTitle: String = ""
    var threadAuthor: String = ""
    var threadLink: String = ""
    var threadDescription: String? = ""
    var threadBackgroundImage: String? = ""
    var threadForum: String? = ""
    var threadReplyCount: String? = ""
    var threadLastComment: String? = ""
    
    
    
    //MARK: Initialization
    
    init?(title: String, author: String, link: String, desc: String?, backImage: String?, forum: String?, replyCount: String?, lastComment: String?) {
        
        if(title == "" || link == ""){
            return nil
        }
        
        // Initialize stored properties.
        self.threadTitle = title
        self.threadAuthor = author
        self.threadLink = link
        self.threadDescription = desc
        self.threadBackgroundImage = backImage
        self.threadForum = forum
        self.threadReplyCount = replyCount
        self.threadLastComment = lastComment
    }
    
    func toString() -> Void{
        print("Title: "  + self.threadTitle)
        print("Author: " + self.threadAuthor)
        print("Link: "  + self.threadLink)
        print("Desc: "  + self.threadDescription!)
        print("Background Image: "  + self.threadBackgroundImage!)
        print("Forum: "  + self.threadForum!)
        print("Reply Count: " + self.threadReplyCount!)
        print("Last Comment: " + self.threadLastComment!)
    }
    
    
}
