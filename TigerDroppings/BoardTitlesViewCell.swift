//
//  BoardTableViewCell.swift
//  TigerDroppings
//
//  Created by James Kiel on 11/25/17.
//  Copyright © 2017 James Kiel. All rights reserved.
//

import UIKit

class BoardTitlesViewCell: UITableViewCell {
    //MARK: Properties
    
    @IBOutlet weak var boardNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
