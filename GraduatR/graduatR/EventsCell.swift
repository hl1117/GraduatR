//
//  EventsCell.swift
//  graduatR
//
//  Created by Harika Lingareddy on 3/20/18.
//  Copyright © 2018 Simona Virga. All rights reserved.
//

import UIKit

class EventsCell: UITableViewCell {

    @IBOutlet weak var eventName: UILabel!
    @IBOutlet weak var startDate: UILabel!
    @IBOutlet weak var endDate: UILabel!
    @IBOutlet weak var eventDescription: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
