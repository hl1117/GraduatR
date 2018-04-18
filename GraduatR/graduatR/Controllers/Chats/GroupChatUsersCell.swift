//
//  GroupChatUsersCell.swift
//  graduatR
//
//  Created by Dhriti Chawla on 4/16/18.
//  Copyright © 2018 Simona Virga. All rights reserved.
//

import UIKit

class GroupChatUsersCell: UITableViewCell {
    
    @IBOutlet weak var name: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        accessoryType = selected ? .checkmark : .none
    }
    
    
  
        

}
