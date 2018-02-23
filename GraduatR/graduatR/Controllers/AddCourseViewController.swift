
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
    var n = String()
    var name = AllVariables.Fname
    var lastName = AllVariables.Lname
    var GPA = AllVariables.GPA
    var user = AllVariables.Username
    var Class = AllVariables.standing
    var ref: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        courseName.text = n
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
        
        if (button.currentTitle! == "Add course") {
            let c = "Course\(AllVariables.courses.endIndex)"
            
            ref.child("Users").child("Student").child(AllVariables.Username).child("Courses").setValue([c : n])
            button.setTitle("Remove course", for: UIControlState.normal)
            
            let alert = UIAlertController(title: "YAY!", message: "Course added to your profile!", preferredStyle: .alert)
            let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
                print ("ok tappped")
            }
            alert.addAction(OKAction)
            self.present(alert, animated: true) {
                print("ERROR")
            }
        }
        //        else {
        //            let i = AllVariables.courses.
        //            print (n)
        //            print ("------------")
        //            print (i)
        
        //            AllVariables.courses.remove(at: i!)
        //            var index = 0
        //            let size = AllVariables.courses.endIndex
        //            let c = "Course\(index)"
        //
        //            while index < size {
        //                ref.child("Users").child("Student").child(AllVariables.Username).child("Courses").setValue([c: AllVariables.courses[index]])
        //                index = index + 1
        //            }
        //
        //            button.setTitle("Add course", for: UIControlState.normal)
        //            let alert = UIAlertController(title: "YAY!", message: "Course removed from your profile!", preferredStyle: .alert)
        //            let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
        //                print ("ok tappped")
        //            }
        //            alert.addAction(OKAction)
        //            self.present(alert, animated: true) {
        //                print("ERROR")
        //            }
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



