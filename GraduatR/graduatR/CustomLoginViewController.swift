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
import GoogleSignIn
import FBSDKLoginKit
import FBSDKShareKit
import FBSDKCoreKit

class CustomLoginViewController: UIViewController, GIDSignInUIDelegate, FBSDKLoginButtonDelegate, UIGestureRecognizerDelegate
{
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    var userUid: String!
    
    func clear() {
        AllVariables.courses.removeAll()
        AllVariables.profpic = ""
        AllVariables.bio = ""
        AllVariables.books.removeAll()
        AllVariables.courseratings.removeAll()
        AllVariables.coursegrade.removeAll()
        AllVariables.examrating.removeAll()
        AllVariables.profratings.removeAll()
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        clear()
        NotificationCenter.default.addObserver(self, selector: #selector(CustomLoginViewController.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(CustomLoginViewController.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)

        configureGoogleSignInButton()
        configureFacebookSignInButton()
        dismissOnTap()
        
    }

    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0{
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y != 0{
                self.view.frame.origin.y += keyboardSize.height
            }
        }
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
            Auth.auth().signIn(withEmail: email, password: password, completion: {(user,error) in
                if (error == nil) {
                    if let user = user {
                        let databaseRef = Database.database().reference();
                        let userID = Auth.auth().currentUser!.uid
                        AllVariables.uid = userID
                        
                        databaseRef.child("Users").child("Student").observeSingleEvent(of: DataEventType.value, with: { snapshotA in
                            if snapshotA.hasChild(AllVariables.uid) {
                                databaseRef.child("Users").child("Student").child(AllVariables.uid).observeSingleEvent(of: DataEventType.value, with: { (snapshotB) in
                                    print("HERE - student")
                                    let value = snapshotB.value as? NSDictionary
                                        AllVariables.Username = value?["Username"] as? String ?? ""
                                        AllVariables.Fname = value?["Fname"] as? String ?? ""
                                        AllVariables.Lname = value?["Lname"] as? String ?? ""
                                        AllVariables.bio = value?["bio"] as? String ?? ""
                                        AllVariables.GPA = value?["GPA"] as? String ?? ""
                                        AllVariables.profpic = value?["profile_pic"] as? String ?? ""
                                        AllVariables.standing = value?["Class"] as? String ?? ""
                                    databaseRef.child("Users").child("Student").child(AllVariables.uid).child("Courses").observeSingleEvent(of: DataEventType.value, with: { (snapshotCourse) in
                                        let counter = 0;
                                        let enumer = snapshotCourse.children
                                        while let rest = enumer.nextObject() as? DataSnapshot {
                                            AllVariables.courses.append(rest.value as! String)
                                        }
                                        })
                                    })
                                self.userUid = user.uid
                                self.performSegue(withIdentifier: "signingInStudent", sender: self)
                            }
                            else {
                                databaseRef.child("Users").child("Parent").observeSingleEvent(of: DataEventType.value, with: { snapshotC in
                                    if snapshotC.hasChild(AllVariables.uid) {
                                        databaseRef.child("Users").child("Parent").child(AllVariables.uid).observeSingleEvent(of: DataEventType.value, with: { (snapshotD) in
                                            
                                                
                                            print("HERE - parent")
                                            let value = snapshotD.value as? NSDictionary
                                            AllVariables.Username = value?["Username"] as? String ?? ""
                                            AllVariables.Fname = value?["Fname"] as? String ?? ""
                                            AllVariables.Lname = value?["Lname"] as? String ?? ""
                                            AllVariables.bio = value?["bio"] as? String ?? ""
                                            AllVariables.GPA = value?["GPA"] as? String ?? ""
                                            AllVariables.profpic = value?["profile_pic"] as? String ?? ""
                                            AllVariables.standing = value?["Class"] as? String ?? ""
                                                
                                            self.userUid = user.uid
                                            
                                            if (snapshotD.hasChild("Studentid")) {
                                            self.performSegue(withIdentifier: "ParentSigningIn", sender: self)
                                                
                                            }
                                            else {
                                               self.performSegue(withIdentifier: "presentKeyPls", sender: self)
                                            }
                                        })
                                    }
                                    else {
                                        databaseRef.child("Users").child("Tutor").observeSingleEvent(of: DataEventType.value, with: { snapshotE in
                                            if snapshotE.hasChild(AllVariables.uid) {
                                                print ("\(AllVariables.uid)....././/..")
                                                databaseRef.child("Users").child("Tutor").child(AllVariables.uid).observeSingleEvent(of: DataEventType.value, with: { (snapshotF) in
                                                    print("HERE - tutor")
                                                    let value = snapshotF.value as? NSDictionary
                                                    AllVariables.Username = value?["Username"] as? String ?? ""
                                                    AllVariables.Fname = (value?["Fname"] as? String)!
                                                    AllVariables.Lname = (value?["Lname"] as? String)!
                                                    AllVariables.bio = value?["bio"] as? String ?? ""
                                                    AllVariables.GPA = value?["GPA"] as? String ?? ""
                                                    AllVariables.profpic = value?["profile_pic"] as? String ?? ""
                                                    AllVariables.standing = value?["Class"] as? String ?? ""
                                                    
                                                    databaseRef.child("Users").child("Tutor").child(AllVariables.uid).child("Courses").observeSingleEvent(of: DataEventType.value, with: { (snapshotCourse) in
                                                        let counter = 0;
                                                        let enumer = snapshotCourse.children
                                                        while let rest = enumer.nextObject() as? DataSnapshot {
                                                            AllVariables.courses.append(rest.value as! String)
                                                        }
                                                    })

                                                    
                                                })
                                                self.userUid = user.uid
                                                self.performSegue(withIdentifier: "signingInTutor", sender: self)
                                            }
                                            else {
                                                let alert = UIAlertController(title: "Sign in error", message: "Error signing in", preferredStyle: .alert)
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
                            })
                            }
                        })
                    }
                }
                else {
                    let alert = UIAlertController(title: "Sign in error", message: "Error signing in", preferredStyle: .alert)
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
    @IBAction func registerButton(_ sender: Any)
    {
        Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!, completion: { (user,error) in
            if error != nil
            {
                let alert = UIAlertController(title: "Error", message: "Cant create user!", preferredStyle: .alert)
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
                            let alert = UIAlertController(title: "Error", message: "Error registering user", preferredStyle: .alert)
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

    func dismissOnTap() {
        self.view.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(CustomLoginViewController.onTap(_:)))
        tap.delegate = self
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
    }
    
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldReceiveTouch touch: UITouch) -> Bool {
        if touch.view is GIDSignInButton {
            return false
        }
        return true
    }
   
     @IBAction func onTap(_ sender: Any) {
        self.view.endEditing(true)
    }
    
    fileprivate func configureGoogleSignInButton()
    {
        let googleSignInButton = GIDSignInButton()
        googleSignInButton.frame = CGRect(x: 75, y: 475, width: view.frame.width - 150, height: 150)
        view.addSubview(googleSignInButton)
        GIDSignIn.sharedInstance().uiDelegate = self
    }
    
    fileprivate func configureFacebookSignInButton()
    {
        let facebookSignInButton = FBSDKLoginButton()
        facebookSignInButton.frame = CGRect(x: 75, y: 550, width: view.frame.width - 150, height: 50)
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
                    let databaseRef = Database.database().reference();
                    
                    print("Facebook authentication succeed")
                    databaseRef.child("Users").observeSingleEvent(of: DataEventType.value, with: {(sap) in
                        let enumer = sap.children
                        while let rest = enumer.nextObject() as? DataSnapshot {
                            if (rest.hasChild(Auth.auth().currentUser!.uid)) {
                                    print("HEREEEEEE")
                                    print(rest.key)
                                    print(Auth.auth().currentUser!.uid)
                                databaseRef.child("Users").child(rest.key).child(Auth.auth().currentUser!.uid).observeSingleEvent(of: DataEventType.value, with: { (snap) in
                                    
                                    
                                    AllVariables.uid = Auth.auth().currentUser!.uid
                                    print("HEREEE?")
                                    let value = snap.value as? NSDictionary
                                    AllVariables.Username = value?["Username"] as? String ?? ""
                                    AllVariables.Fname = (value?["Fname"] as? String)!
                                    AllVariables.Lname = (value?["Lname"] as? String)!
                                    AllVariables.bio = value?["bio"] as? String ?? ""
                                    AllVariables.GPA = value?["GPA"] as? String ?? ""
                                    AllVariables.profpic = value?["profile_pic"] as? String ?? ""
                                    AllVariables.standing = value?["Class"] as? String ?? ""
                                    
                                    databaseRef.child("Users").child(rest.key).child(AllVariables.uid).child("Courses").observeSingleEvent(of: DataEventType.value, with: { (snapshotCourse) in
                                        let counter = 0;
                                        let enumer = snapshotCourse.children
                                        while let rest = enumer.nextObject() as? DataSnapshot {
                                            AllVariables.courses.append(rest.value as! String)
                                        }
                                    })
                                    
                                    let mainStoryBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                                    let protectedPage = mainStoryBoard.instantiateViewController(withIdentifier: "tabBar") as! UITabBarController
                                    let appDelegate = UIApplication.shared.delegate
                                    appDelegate?.window??.rootViewController = protectedPage
                                    
                                })
                            }
                        }
                        self.performSegue(withIdentifier: "register", sender: self)
                    })
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

