//
//  CalendarViewController.swift
//  graduatR
//
//  Created by Harika Lingareddy on 3/8/18.
//  Copyright © 2018 Simona Virga. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class CalendarViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var databaseRef = Database.database().reference()
    var storageRef = Storage.storage().reference()
    
    var eventname = [String]()
    var eventdescription = [String]()
    var startdate = [String]()
    var enddate = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.tableView.reloadData()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        databaseRef.child("Events").observeSingleEvent(of: DataEventType.value, with: { (snapshotA) in
            let enumer = snapshotA.children
            while let rest = enumer.nextObject() as? DataSnapshot {
                let vals = rest.value as? NSDictionary
                
                self.eventname.append((vals?["Event Name"] as? String)!)
                self.eventdescription.append((vals?["Event Description"] as? String ?? ""))
                self.startdate.append((vals?["Start Date"] as? String)!)
                self.enddate.append((vals?["End Date"] as? String)!)
                
                print(self.eventname)
                
            }
        })
        self.tableView.reloadData()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        
        
        
        // Do any additional setup after loading the view.
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.tableView.reloadData()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        
        databaseRef.child("Events").observeSingleEvent(of: DataEventType.value, with: { (snapshotA) in
            let enumer = snapshotA.children
            while let rest = enumer.nextObject() as? DataSnapshot {
                let vals = rest.value as? NSDictionary
                
                self.eventname.append((vals?["Event Name"] as? String)!)
                self.eventdescription.append((vals?["Event Description"] as? String ?? ""))
                self.startdate.append((vals?["Start Date"] as? String)!)
                self.enddate.append((vals?["End Date"] as? String)!)
                
                print(self.eventname)
                
            }
        })
        
        self.tableView.reloadData()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eventname.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "eventsCell", for: indexPath) as! EventsCell
        
        let ti = eventname[indexPath.row]
        cell.eventName!.text = ti
        
        let au = eventdescription[indexPath.row]
        cell.eventDescription!.text = au
        
        let pr = startdate[indexPath.row]
        cell.startDate!.text = pr
        
        let co = enddate[indexPath.row]
        cell.endDate!.text = co
        
        //        }
        return cell
        

    }
    
}
