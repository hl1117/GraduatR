//
//  CourseCell.swift
//  graduatR
//
//  Created by Swaraj Bhaduri on 2/19/18.
//  Copyright © 2018 Simona Virga. All rights reserved.
//

import UIKit

class CourseCell: UITableViewCell {
    
    
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
