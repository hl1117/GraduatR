
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
            
            AllVariables.courses.append(n)
            ref.child("Users").child("Student").child(AllVariables.Username).child("Courses").child(c).setValue(n)
            button.setTitle("Remove course", for: UIControlState.normal)
            
            print (AllVariables.courses)
            
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
                    button.setTitle("Add course", for: UIControlState.normal)
                    let alert = UIAlertController(title: "YAY!", message: "Course removed from your profile!", preferredStyle: .alert)
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


}
