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
    
    
    @IBOutlet weak var username: UITextField!
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
        if (username.text?.isEmpty == false) {
            let databaseRef = Database.database().reference();
            databaseRef.child("Users").child("Student").observeSingleEvent(of: DataEventType.value, with: { (snapshot) in
                if snapshot.hasChild(self.username.text!) {
                    print("Username exists-S")
                    let alert = UIAlertController(title: "Error", message: "Username is already taken!", preferredStyle: .alert)
                    let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
                            print ("ok tappped")
                    }
                     alert.addAction(OKAction)
                    self.present(alert, animated: true) {
                            print("ERROR")
                    }
                }
                else {
                    databaseRef.child("Users").child("Parent").observeSingleEvent(of: DataEventType.value, with: { (snapshot) in
                        if snapshot.hasChild(self.username.text!) {
                            print("Username exists-P")
                            let alert = UIAlertController(title: "Error", message: "Username is already taken!", preferredStyle: .alert)
                            let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
                                print ("ok tappped")
                            }
                            alert.addAction(OKAction)
                            self.present(alert, animated: true) {
                                print("ERROR")
                            }
                        }
                        else {
                            databaseRef.child("Users").child("Tutor").observeSingleEvent(of: DataEventType.value, with: { (snapshot) in
                                if snapshot.hasChild(self.username.text!) {
                                    print("Username exists-C")
                                    let alert = UIAlertController(title: "Error", message: "Username is already taken!", preferredStyle: .alert)
                                    let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
                                        print ("ok tappped")
                                    }
                                     alert.addAction(OKAction)
                                    self.present(alert, animated: true) {
                                        print("ERROR")
                                    }
                                }
                                else {
                                    self.ref.child("Users").child(self.pickerData[self.value]).child(self.username.text!).setValue(["Fname": self.fname.text, "Lname": self.lname.text])
                                    
                                    self.userN = self.username.text!
                                    self.FN = self.fname.text!
                                    self.LN = self.lname.text!
                                    
                                    self.performSegue(withIdentifier: "studentDetail", sender: self)
                                }
                            })
                        }
                    })
                }
            })
    
        
    }
        
//        if (username.text?.isEmpty != true) {
//        let myVC = storyboard?.instantiateViewController(withIdentifier: "detailPage") as! StudentDetailViewController
//        myVC.name = fname.text!
//        myVC.user = username.text!
//        myVC.lastName = lname.text!
//        navigationController?.pushViewController(myVC, animated: true)
     //   }
    
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var VC = segue.destination as! StudentDetailViewController
        VC.name = fname.text!
        VC.user = username.text!
        VC.lastName = lname.text!
      
    }
    
    
}

