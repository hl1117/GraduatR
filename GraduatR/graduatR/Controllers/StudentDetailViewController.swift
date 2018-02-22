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
    var name = String()
    var lastName = String()
    var user = String()
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
            welcomeText.text = name
            
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
        
    @IBAction func clickedProceed(_ sender: Any) {
        
        let myclass = (self.pickerData[self.value])
        let number1 = (GPA.text! as NSString).doubleValue
        print (number1)
        //if ((GPA.text!.isNumeric == true)) {
            //&& ((number1) >= 0.0) && ((number1) <= 4.0)){
        ref.child("Users").child("Student").child(user).setValue(["Fname": name, "Lname": lastName, "GPA" : GPA.text!, "Class": myclass])
    
            if (tutorStatus.isOn){
            
            ref.child("Users").child("Tutor").child(user).setValue(["Fname": name, "Lname": lastName])
            self.performSegue(withIdentifier: "tutDetail", sender: self)
                
            print("Person is also a tutor")
           // self.ref.child("Users").child("Tutor").child(user).setValue(["Fname": self.name.text, "Lname": self.lastName.text])
            }
        //}
//            else {
//                let alert = UIAlertController(title: "Error", message: "GPA must be a valid number between 0.0 and 4.0!", preferredStyle: .alert)
//                let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
//                    print ("ok tappped")
//                }
//                alert.addAction(OKAction)
//                self.present(alert, animated: true) {
//                    print("ERROR")
//                }
//        }
//    }
//
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (!tutorStatus.isOn) {
            var CC = segue.destination as! AddCourseViewController
        CC.name = name
        CC.user = user
        CC.lastName = lastName
        CC.GPA = GPA.text!
        CC.Class = pickerData[value]
        }

    }
}
    extension String  {
        var isNumeric: Bool {
            guard self.characters.count > 0 else { return false }
            let nums: Set<Character> = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
            return Set(self.characters).isSubset(of: nums)
        }
    
}
