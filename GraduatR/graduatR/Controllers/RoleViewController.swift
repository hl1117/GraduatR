//
//  RoleViewController.swift
//  GUI
//
//  Created by Dhriti Chawla & SwarajBhaduri on 2/8/18.
//  Copyright © 2018 Dhriti Chawla. All rights reserved.
//

import UIKit
import Firebase

class RoleViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var roleController: UIPickerView!
    var pickerData:  [String] = [String] ()
    var value: Int = 0
    var ref: DatabaseReference!
    var userN = String()
    var LN = String()
    var FN = String()
    var count: Int = 0
    
    
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var fname: UITextField!
    @IBOutlet weak var lname: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.roleController.delegate = self
        self.roleController.dataSource = self
        pickerData = ["Student","Tutor","Parent"," "]
        count = 0
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
        if (username.text?.isEmpty == false && fname.text?.isEmpty == false && lname.text?.isEmpty == false) {
            if (username.text?.isAlphanumeric != false) {
                let databaseRef = Database.database().reference();
                let userID = Auth.auth().currentUser!.uid
                AllVariables.uid = userID
                        databaseRef.child("Users").child("Usernames").observeSingleEvent(of: DataEventType.value, with: { (snapshotUsernames) in
                            if snapshotUsernames.hasChild(self.username.text!) {
                                let alert = UIAlertController(title: "Error", message: "Username taken!", preferredStyle: .alert)
                                let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
                                    print ("ok tappped")
                                }
                                alert.addAction(OKAction)
                                self.present(alert, animated: true) {
                                    print("ERROR")
                                }
                            }
                            else {
                            self.ref.child("Users").child("Usernames").child(self.username.text!).setValue("doesntmatterwhatthisis")
                            
                                self.ref.child("Users").child(self.pickerData[self.value]).child(AllVariables.uid).setValue(["Username": self.username.text!, "Fname": self.fname.text!, "Lname": self.lname.text!])
                                self.FN = self.fname.text!
                                self.LN = self.lname.text!
                                
                                if (self.pickerData[self.value] == "Student") {
                                    self.performSegue(withIdentifier: "studentDetail", sender: self)
                                }
                                else if (self.pickerData[self.value] == "Tutor") {
                                    self.performSegue(withIdentifier: "tutorDetail", sender: self)
                                }
                                else if (self.pickerData[self.value] == "Parent") {
                                    self.performSegue(withIdentifier: "parentDetail", sender: self)
                                }
                                AllVariables.Fname = self.fname.text!
                                AllVariables.Username = self.username.text!
                                AllVariables.Lname = self.lname.text!

                            }
                        })
            }
            else {
                let alert = UIAlertController(title: "Error", message: "Username must be alphanumeric!", preferredStyle: .alert)
                let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
                    print ("ok tappped")
                }
                alert.addAction(OKAction)
                self.present(alert, animated: true) {
                    print("ERROR")
                }
            }
        }
        else {
            let alert = UIAlertController(title: "Error", message: "Fields cannot be left empty!", preferredStyle: .alert)
            let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
                print ("ok tappped")
            }
            alert.addAction(OKAction)
            self.present(alert, animated: true) {
                print("ERROR")
            }
        }
    }
}

extension String {
    var isAlphanumeric: Bool {
        return !isEmpty && range(of: "[^a-zA-Z0-9]", options: .regularExpression) == nil
    }
}



