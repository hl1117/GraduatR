//
//  ViewProfessorReviewsViewController.swift
//  graduatR
//
//  Created by Simona Virga on 3/22/18.
//  Copyright © 2018 Simona Virga. All rights reserved.
//

import UIKit

class ViewProfessorReviewsViewController: UIViewController {

    
    @IBOutlet weak var nameLabel: UILabel!
    var n = String()
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        nameLabel.text = n
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

  

}
