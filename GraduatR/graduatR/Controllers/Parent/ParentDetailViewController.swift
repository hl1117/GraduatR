//
//  ParentDetailViewController.swift
//  graduatR
//
//  Created by Dhriti Chawla on 2/15/18.
//  Copyright © 2018 Simona Virga. All rights reserved.
//

import UIKit
import Firebase

class ParentDetailViewController: UIViewController {
    
    
    @IBOutlet weak var keyField: UITextField!
    var name = AllVariables.Fname
    var lastName = AllVariables.Lname
    var user = AllVariables.Username
    var ref: DatabaseReference!
    
    @IBOutlet weak var welcomeText: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        welcomeText.text = name
        
        ref = Database.database().reference()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func pressedProceed(_ sender: Any) {
        let studentid = keyField.text
        self.ref.child("Users").child("Student").observeSingleEvent(of: DataEventType.value, with: { (snapshot) in
            
            if (snapshot.hasChild(studentid!)) {
                self.ref.child("Users").child("Student").child(studentid!).observeSingleEvent(of: DataEventType.value, with: { (snapshot2) in
                    
                    if (snapshot2.hasChild("ParentUID")) {
                        let alert = UIAlertController(title: "Student connect error", message: "Student is already connected to another parent", preferredStyle: .alert)
                        let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
                            print ("ok tappped")
                        }
                        alert.addAction(OKAction)
                        self.present(alert, animated: true) {
                            print("ERROR")
                        }
                        print("error signing in")
                    }
                    else {
                    self.ref.child("Users").child("Parent").child(AllVariables.uid).child("Studentid").setValue(studentid)
                        
                        self.ref.child("Users").child("Student").child(studentid!).child("ParentUID").setValue(AllVariables.uid)
                        
                        self.performSegue(withIdentifier: "proceedParent", sender: self)
                    }
                })
            }
            else {
                let alert = UIAlertController(title: "Student connect error", message: "No student with code exists", preferredStyle: .alert)
                let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
                    print ("ok tappped")
                }
                alert.addAction(OKAction)
                self.present(alert, animated: true) {
                    print("ERROR")
                }
                print("error signing in")
            }
        })
        
    }
    

}
