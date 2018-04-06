
//
//  AddCourseViewController.swift
//  graduatR
//
//  Created by Dhriti Chawla on 2/22/18.
//  Copyright © 2018 Simona Virga. All rights reserved.
//

import UIKit
import Firebase

class AddCourseViewController: UIViewController {
    
    
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var courseName: UILabel!
    @IBOutlet weak var info: UILabel!
    var n = String()
    var name = AllVariables.Fname
    var lastName = AllVariables.Lname
    var GPA = AllVariables.GPA
    var user = AllVariables.Username
    var Class = AllVariables.standing
    var ref: DatabaseReference!
    var c = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        if (!AllVariables.courses.contains(n)){
            button.setTitle("Add course", for: UIControlState.normal)
        }
        else {
            button.setTitle("Remove course", for: UIControlState.normal)
        }
        
        courseName.text = n
        info.text = c
        ref = Database.database().reference()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func pressedAddButton(_ sender: Any) {
        
        print(AllVariables.Username)
        print(n)
        print(button.currentTitle)
        
        
        //if (button.currentTitle! == "Add course") {
        
        if (!AllVariables.courses.contains(n)){
            let c = "Course\(AllVariables.courses.endIndex)"
            
            AllVariables.courses.append(n)
            
        ref.child("Users").child("Student").child(AllVariables.uid).child("Courses").child(c).setValue(n)
            button.setTitle("Remove course", for: UIControlState.normal)
            
            print (AllVariables.courses)
            
            print ("........")
            let newCourse = n.replacingOccurrences(of: "\t", with: "")
            ref.child("Courses").child(newCourse).child(user).setValue(["UID": AllVariables.uid, "Fname": name, "Lname": lastName])
            
            //ref.child("Courses").setValue("okay")
            
            let alert = UIAlertController(title: "YAY!", message: "Course added to your profile!", preferredStyle: .alert)
            let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
                print ("ok tappped")
            }
            alert.addAction(OKAction)
            self.present(alert, animated: true) {
                print("added course")
            }
        }
                else {
            
                    let i = AllVariables.courses.index(of: n)
                    AllVariables.courses.remove(at: i!)
            
                    var index = 0
            ref.child("Users").child("Student").child(AllVariables.uid).child("Courses").setValue([])
            
            while (index < AllVariables.courses.endIndex) {
                let c = "Course\(index)"
            ref.child("Users").child("Student").child(AllVariables.uid).child("Courses").child(c).setValue(AllVariables.courses[index])
                index += 1
                
            }
            
                    print (n)
                    button.setTitle("Add course", for: UIControlState.normal)
                    let alert = UIAlertController(title: "OOPS!", message: "Course removed from your profile!", preferredStyle: .alert)
                    let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
                        print ("ok tappped")
                    }
                    alert.addAction(OKAction)
                    self.present(alert, animated: true) {
                        print("removed course")
                    }
        //
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
    }

    
    @IBAction func reviewbutton(_ sender: Any) {
        
        AllVariables.courseselected = n
        AllVariables.courseselected = AllVariables.courseselected.replacingOccurrences(of: "\t", with: " ")
    
    }
    
}
