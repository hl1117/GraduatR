//
//  LoginViewController.swift
//  graduatR
//
//  Created by Simona Virga on 2/7/18.
//  Copyright © 2018 Simona Virga. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn

class LoginViewController: UIViewController, GIDSignInUIDelegate
{

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var googleSignInButton: GIDSignInButton!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        //GIDSignIn.sharedInstance().uiDelegate = self
        //GIDSignIn.sharedInstance().signIn()
        
        configureGoogleSignInButton()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    fileprivate func configureGoogleSignInButton()
    {
        let googleSignInButton = GIDSignInButton()
        googleSignInButton.frame = CGRect(x: 120, y: 200, width: view.frame.width - 240, height: 50)
        view.addSubview(googleSignInButton)
        GIDSignIn.sharedInstance().uiDelegate = self
    }
   
    

}
