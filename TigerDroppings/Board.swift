//
//  Board.swift
//  TigerDroppings
//
//  Created by James Kiel on 11/25/17.
//  Copyright © 2017 James Kiel. All rights reserved.
//

import UIKit


public class Board {
    
    //MARK: Properties
    
    var boardName: String
    var boardURL: String
    
    
    
    //MARK: Initialization
    
    init?(boardName: String, boardURL: String) {
        
        if(boardURL == ""){
            return nil
        }
        
        // Initialize stored properties.
        self.boardName = boardName
        self.boardURL = boardURL
        

    }
    

}

