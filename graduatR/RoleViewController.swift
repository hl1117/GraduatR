//
//  RoleViewController.swift
//  GUI
//
//  Created by Dhriti Chawla & Swaraj Bhaduri on 2/8/18.
//  Copyright © 2018 Dhriti Chawla. All rights reserved.
//

import UIKit
import Firebase

class RoleViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
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
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        value = (row)

        return pickerData[row]
        
        
    }
    
    
    


}

