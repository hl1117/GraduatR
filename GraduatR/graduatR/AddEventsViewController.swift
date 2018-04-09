//
//  AddEventsViewController.swift
//  graduatR
//
//  Created by Harika Lingareddy on 3/8/18.
//  Copyright © 2018 Simona Virga. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase


class AddEventsViewController: UIViewController {
    
    @IBOutlet weak var startTime: UIDatePicker!
    @IBOutlet weak var endTime: UIDatePicker!
    @IBOutlet weak var eventNameTextField: UITextField!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    var start: NSDate?
    var end: NSDate?
    
    var databaseRef = Database.database().reference()
    var storageRef = Storage.storage().reference()
    var ref: DatabaseReference!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addEventButton(_ sender: Any)
    {
        
        self.databaseRef.child("Events").child(eventNameTextField.text!).child("Event Name").setValue(eventNameTextField.text)
        self.databaseRef.child("Events").child(eventNameTextField.text!).child("Description").setValue(descriptionTextView.text)
        getDatesInfo()
        
        self.performSegue(withIdentifier: "eventSegue", sender: nil)
    }
    
    func getDatesInfo()
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/YYYY  HH:mm"
        
        let strDate = dateFormatter.string(from: startTime.date)
        self.databaseRef.child("Events").child(eventNameTextField.text!).child("Start Date").setValue(strDate)
        //print(strDate)
        
        let endDate = dateFormatter.string(from: endTime.date)
        self.databaseRef.child("Events").child(eventNameTextField.text!).child("End Date").setValue(endDate)
        
    }
    
}
