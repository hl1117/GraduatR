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
            //Auth.auth().signIn(with: <#T##AuthCredential#>, completion: <#T##AuthResultCallback?##AuthResultCallback?##(User?, Error?) -> Void#>)
            Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
                
                if let u = user
                {
                    self.performSegue(withIdentifier: "SignIn" , sender: self)
                }
                else
                {
                    
                }
                
            }
        }
    }
    
    
    @IBAction func registerButton(_ sender: Any)
    {
        //Auth.auth().createUser(withEmail: <#T##String#>, password: <#T##String#>, completion: <#T##AuthResultCallback?##AuthResultCallback?##(User?, Error?) -> Void#>)
        
        if let email = emailTextField.text, let password = passwordTextField.text
        {
            Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
                
                if let u = user
                {
                    self.performSegue(withIdentifier: "register" , sender: self)
                }
                else
                {
                    
                }
                
            }
        }
    }
    

}
