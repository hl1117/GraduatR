//
//  ProfCell.swift
//  graduatR
//
//  Created by Dhriti Chawla on 3/13/18.
//  Copyright © 2018 Simona Virga. All rights reserved.
//

import UIKit

class ProfCell: UITableViewCell {

    @IBOutlet weak var profName: UILabel!
    @IBOutlet weak var profCourse: UILabel!
    @IBOutlet weak var initials: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
