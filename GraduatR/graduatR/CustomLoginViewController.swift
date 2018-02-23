//
//  CustomLoginViewController.swift
//  graduatR
//
//  Created by Simona Virga on 2/13/18.
//  Copyright © 2018 Simona Virga. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class CustomLoginViewController: UIViewController
{
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    var userUid: String!
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func signInButton(_ sender: Any)
    {
        if let email = emailTextField.text, let password = passwordTextField.text
        {
            Auth.auth().signIn(withEmail: email, password: password, completion: { (user,error) in
                
                if error == nil
                {
                    
                    if let user = user
                    {
                        self.userUid = user.uid
                        print("you signed in!")
                        self.performSegue(withIdentifier: "signingIn", sender: self)
                    }
                }
                else
                {
                    let alert = UIAlertController(title: "Sign in error", message: "error signing in", preferredStyle: .alert)
                    let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
                        print ("ok tappped")
                    }
                    alert.addAction(OKAction)
                    self.present(alert, animated: true) {
                        print("ERROR")
                    }
                    print("error signing in")
                }
            });
        }
    }
    
    
    @IBAction func registerButton(_ sender: Any)
    {
        Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!, completion: { (user,error) in
            if error != nil
            {
                let alert = UIAlertController(title: "Error", message: "cant create user", preferredStyle: .alert)
                let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
                    print ("ok tappped")
                }
                
                alert.addAction(OKAction)
                self.present(alert, animated: true) {
                    print("ERROR")
                }
                print("cant create user \(error)")
            }
            else
            {
                if let user = user
                {
                    self.userUid = user.uid
                    
                    let changeRequest = user.createProfileChangeRequest()
                    
                    changeRequest.displayName = self.emailTextField.text
                    
                    changeRequest.commitChanges { error in
                        if let error = error
                        {
                            let alert = UIAlertController(title: "Error", message: "error registering user", preferredStyle: .alert)
                            let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
                                print ("ok tappped")
                            }
                            alert.addAction(OKAction)
                            self.present(alert, animated: true) {
                                print("ERROR")
                            }
                            print("error registering user")
                            print(error)
                            
                        }
                        else
                        {
                            print("Success registering user!")
                            self.performSegue(withIdentifier: "register", sender: self)
                        }
                    }
                }
            }
            //self.uploadImage()
        })
    }
    
    
}
