//
//  StudentDetailViewController.swift
//  graduatR
//
//  Created by Dhriti Chawla on 2/13/18.
//  Copyright © 2018 Simona Virga. All rights reserved.
//

import UIKit
import Firebase

class StudentDetailViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource  {
    
    @IBOutlet weak var welcomeText: UILabel!
    var name = ""
    var lastName = ""
    var user = ""
    
    var ref: DatabaseReference!
        
    @IBOutlet weak var tutorStatus: UISwitch!
    @IBOutlet weak var GPA: UITextField!
    @IBOutlet weak var classController: UIPickerView!
    
        var pickerData:  [String] = [String] ()
        var value: Int = 0
        
        override func viewDidLoad() {
            super.viewDidLoad()
            // Do any additional setup after loading the view, typically from a nib.
            self.classController.delegate = self
            self.classController.dataSource = self
            pickerData = ["Freshman","Sophomore","Junior","Senior","Super senior", " "]
            welcomeText.text = "Hi," + name 
        }
        
        // The number of columns of data
        func numberOfComponents(in pickerView: UIPickerView) -> Int {
            return 1
        }
        
        // The number of rows of data
        func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            return pickerData.count
        }
        
        // The data to return for the row and component (column) that's being passed in
        func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
            value = (row)
            print (value)
            return pickerData[row]
            
            
        }
        
        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
        }
        
    @IBAction func clickedProceed(_ sender: Any) {
        
        let myclass = (self.pickerData[self.value])
        
        self.ref.child("Users").child("Student").child(user).setValue(["GPA": self.GPA.text, "Class": myclass])
        
        if (tutorStatus.isOn){
            
            self.ref.child("Users").child("Tutor").child(user).setValue(["Fname": self.name.text, "Lname": self.lastName.text])
        }

    }
    

}
