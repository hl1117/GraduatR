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
import FBSDKLoginKit
import FBSDKShareKit
import FBSDKCoreKit

class LoginViewController: UIViewController, GIDSignInUIDelegate, FBSDKLoginButtonDelegate
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
        configureFacebookSignInButton()

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
   
    fileprivate func configureFacebookSignInButton()
    {
        let facebookSignInButton = FBSDKLoginButton()
        facebookSignInButton.frame = CGRect(x: 50, y: 200 + 100, width: view.frame.width - 240, height: 40)
        view.addSubview(facebookSignInButton)
        facebookSignInButton.delegate = self
    }
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        if error == nil {
            print("User just logged in via Facebook")
            let credential = FacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
            Auth.auth().signIn(with: credential, completion: { (user, error) in
                if (error != nil) {
                    print("Facebook authentication failed")
                } else {
                    print("Facebook authentication succeed")
                    let mainStoryBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    let protectedPage = mainStoryBoard.instantiateViewController(withIdentifier: "ProtectedPageViewController") as! ProtectedPageViewController
                    let appDelegate = UIApplication.shared.delegate
                    appDelegate?.window??.rootViewController = protectedPage
                }
            })
        } else {
            print("An error occured the user couldn't log in")
        }
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        print("User just logged out from his Facebook account")
    }
    

}
