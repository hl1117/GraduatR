//
//  StudentDetailViewController.swift
//  graduatR
//
//  Created by Dhriti Chawla on 2/13/18.
//  Copyright © 2018 Simona Virga. All rights reserved.
//

import UIKit

class StudentDetailViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource  {
        
        @IBOutlet weak var classController: UIPickerView!
        var pickerData:  [String] = [String] ()
        var value: Int = 0
        
        override func viewDidLoad() {
            super.viewDidLoad()
            // Do any additional setup after loading the view, typically from a nib.
            self.classController.delegate = self
            self.classController.dataSource = self
            pickerData = ["Freshman","Sophomore","Junior","Senior","Super senior", " "]
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
        


}
