//
//  RoleViewController.swift
//  GUI
//
//  Created by Dhriti Chawla & SwarajBhaduri on 2/8/18.
//  Copyright © 2018 Dhriti Chawla. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var roleController: UIPickerView!
    var pickerData:  [String] = [String] ()
    var value: Int = 0
    var ref: DatabaseReference!
    
    
    @IBOutlet weak var fname: UITextField!
    @IBOutlet weak var lname: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.roleController.delegate = self
        self.roleController.dataSource = self
        pickerData = ["Student","Tutor","Parent"," "]
        
        ref = Database.database().reference()
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
    
    
    //Communication with Firebase Database
    @IBAction func clickNextButton(_ sender: Any) {
        //Update realtime database based on role
        self.ref.child("Users").child(pickerData[value]).setValue(["Fname": fname.text, "Lname": lname.text])
        
        
        
    }
    
    
    
    
    
}

