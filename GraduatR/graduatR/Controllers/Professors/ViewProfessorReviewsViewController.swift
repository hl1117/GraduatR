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
    
    var reviews = [String]()
    
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
        
        //fetch from database
        print("hgjkhgjkhgjkhghhj")
        databaseRef.child("ProfessorReviews").child(AllVariables.profselected).child("Comments").observeSingleEvent(of: DataEventType.value, with: { (snapshotA) in
            
            print("before")
            for child in snapshotA.children {
                print("child")
                let snap = child as! DataSnapshot
                let key = snap.key
                let value = snap.value
                print("VALUE IS: \(value)")
                self.reviews.append(value! as! String)
                print("REVIEWS: \(self.reviews)")
                //print("key = \(key)    value = \(value!)")
            }
            print("After")
            
        })
        
        self.tableView.reloadData()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.refresh.endRefreshing()
        
        
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
        print("hgjkhgjkhgjkhghhj")
        databaseRef.child("ProfessorReviews").child(AllVariables.profselected).child("Comments").observeSingleEvent(of: DataEventType.value, with: { (snapshotA) in
            
            print("before")
            for child in snapshotA.children {
                print("child")
                let snap = child as! DataSnapshot
                let key = snap.key
                let value = snap.value
                print("VALUE IS: \(value)")
                self.reviews.append(value! as! String)
                print("REVIEWS: \(self.reviews)")
                //print("key = \(key)    value = \(value!)")
            }
            print("After")
            
        })
        
        self.tableView.reloadData()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.refresh.endRefreshing()
        
    }
    
    func tableView(_ tableView:UITableView!, numberOfRowsInSection section:Int) -> Int
    {
        return reviews.count
    }
    
    func tableView(_ tableView: UITableView!, cellForRowAt indexPath: IndexPath!) -> UITableViewCell!
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProfessorReviewCell", for: indexPath) as! ProfessorReviewCell
        
                let review = reviews[indexPath.row]
                cell.reviewText.text = review
        
        return cell
    }
    
    
    
    
}

