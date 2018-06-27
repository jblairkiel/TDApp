//
//  Comment.swift
//  TigerDroppings
//
//  Created by James Kiel on 12/3/17.
//  Copyright © 2017 James Kiel. All rights reserved.
//

import Foundation


public class Comment {
    
    //MARK: Properties
    
    var commentContent: String = ""
    var commentAuthor: String = ""
    var authorLink: String = ""
    var authorAvatar: String? = ""
    var authorSignature: String? = ""
    var authorSignaturePic: String? = ""
    var commentDetails: String? = ""
    var commentLikesUp: String? = ""
    var commentLikesDown: String? = ""
    
    
    
    //MARK: Initialization
    
    init?(content: String, author: String, link: String, authorLink: String, avatar: String?, signature: String?, signaturePic: String?, commentDetails: String?, likesUp: String?, likesDown: String?) {
        
        if(content == "" || link == ""){
            return nil
        }
        
        // Initialize stored properties.
        self.commentContent = content
        self.commentAuthor = author
        self.authorLink = authorLink
        self.authorAvatar = avatar
        self.authorSignature = signature
        self.authorSignaturePic = signaturePic
        self.commentDetails = commentDetails
        self.commentLikesUp = likesUp
        self.commentLikesDown = likesDown
    }
    
    func toString() -> Void{
        print("Content: "  + self.commentContent)
        print("Author: " + self.commentAuthor)
        print("Author Link: "  + self.authorLink)
        print("Avatar: "  + self.authorAvatar!)
        print("Signature: "  + self.authorSignature!)
        print("Signature Pic: "  + self.authorSignaturePic!)
        print("Details: " + self.commentDetails!)
        print("Likes Up: " + self.commentLikesUp!)
        print("Likes Down: " + self.commentLikesDown!)
    }
    
    
}
