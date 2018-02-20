//
//  ResetPasswordViewController.swift
//  graduatR
//
//  Created by Harika Lingareddy on 2/19/18.
//  Copyright © 2018 Simona Virga. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class ResetPasswordViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func ResetButtonPressed(_ sender: Any) {
        Auth.auth().sendPasswordReset(withEmail: emailTextField.text!, completion: { (error) in
            if error == nil {
                print("An email with information on how to reset your password has been send to you. Thank you.")
            }
            else {
                let alert = UIAlertController(title: "Password Error", message: "Error resetting password.", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                print("error in reset email")
            }
        })
    }
    
}
