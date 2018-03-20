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
    
    var eventname = ""
    var eventdescription = ""
    var startdate = ""
    var enddate = ""
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.databaseRef.child("Events").observeSingleEvent(of: .value) {
            (snapshot: DataSnapshot) in
            
            let value = snapshot.value as? [String : AnyObject] ?? [:]
            
            if (value["Event Name"] != nil) {
                self.eventname = (value["Event Name"] as? String!)!
            }
            
            if (value["Event Description"] != nil) {
                self.eventdescription = (value["Event Description"] as? String!)!
            }
            
            if (value["Start Date"] != nil) {
                self.startdate = (value["Start Date"] as? String!)!
            }
            
            if (value["End Date"] != nil) {
                self.enddate = (value["End Date"] as? String!)!
            }
            
            
            
        }
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "eventsCell", for: indexPath) as! EventsCell
        cell.eventName.text = "hello"
        return cell
    }
    
    
    
    

}
