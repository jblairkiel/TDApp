//
//  BoardTableViewCell.swift
//  TigerDroppings
//
//  Created by James Kiel on 11/25/17.
//  Copyright © 2017 James Kiel. All rights reserved.
//

import UIKit
import WebKit

class ThreadCommentsViewCell: UITableViewCell {
    //MARK: Properties
    
    @IBOutlet weak var commentContentWV: WKWebView!
    @IBOutlet weak var greenUpArrow: UIImageView!
    @IBOutlet weak var redDownArrow: UIImageView!
    @IBOutlet weak var greenUpvotesLabel: UILabel!
    @IBOutlet weak var redDownvotesLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

    
  
}


