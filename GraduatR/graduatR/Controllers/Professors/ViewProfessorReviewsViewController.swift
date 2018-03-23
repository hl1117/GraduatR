//
//  ViewProfessorReviewsViewController.swift
//  graduatR
//
//  Created by Simona Virga on 3/22/18.
//  Copyright © 2018 Simona Virga. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class ViewProfessorReviewsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var refresh: UIRefreshControl!
    @IBOutlet weak var nameLabel: UILabel!
    var n = String()
    @IBOutlet weak var tableView: UITableView!
    
    var databaseRef = Database.database().reference()
    var storageRef = Storage.storage().reference()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        nameLabel.text = n
        
        refresh = UIRefreshControl()
        refresh.addTarget(self, action: #selector(CalendarViewController.didPullToRefresh(_:)), for: .valueChanged)
        
        tableView.insertSubview(refresh, at: 0)
        
        
        
        self.tableView.reloadData()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        databaseRef.child("ProfessorReviews").child("Comments").observeSingleEvent(of: DataEventType.value, with: { (snapshotA) in
            if let data = snapshotA.value as? [String: Any] {
                let values = Array(data.values)
            }
        })
       
        self.tableView.reloadData()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.tableView.reloadData()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        //fetch from database
        
        self.tableView.reloadData()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.refresh.endRefreshing()
        
    }
    
    func tableView(_ tableView:UITableView!, numberOfRowsInSection section:Int) -> Int
    {
        return 20
    }
    
    func tableView(_ tableView: UITableView!, cellForRowAt indexPath: IndexPath!) -> UITableViewCell!
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProfessorReviewCell", for: indexPath) as! ProfessorReviewCell
    
        return cell
    }
    

  

}
