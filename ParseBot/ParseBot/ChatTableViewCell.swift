//
//  ChatTableViewCell.swift
//  ParseBot
//
//  Created by Matthew Lee on 2/28/17.
//  Copyright © 2017 Tim Kim. All rights reserved.
//

import UIKit

class ChatTableViewCell: UITableViewCell {

    @IBOutlet weak var message: UILabel!
    
    @IBOutlet weak var messageSender: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
