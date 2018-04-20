//
//  ViewProfileViewController.swift
//  graduatR
//
//  Created by Harika Lingareddy on 2/20/18.
//  Copyright © 2018 Simona Virga. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage
import FBSDKCoreKit
import FBSDKLoginKit

class ViewProfileViewController: UIViewController
{
    
    @IBOutlet weak var myCourses: UILabel!
    var list = String()
    var loggedInUser: AnyObject?
    var databaseRef = Database.database().reference()
    var storageRef = Storage.storage().reference()
    var image: UIImageView!
    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var gpaLabel: UILabel!
    @IBOutlet weak var pictureonprofilepage: UIImageView!
    @IBOutlet weak var updateBioText: UILabel!
    
    @IBOutlet weak var nameLabel: UILabel!
    override func viewDidLoad()
    {
        super.viewDidLoad()
        //pictureonprofilepage = image
        nameLabel.text = AllVariables.Fname + " " + AllVariables.Lname
        self.navigationItem.title = AllVariables.Username
        //updateBioText.text = AllVariables.bio
        if (AllVariables.gpaAnon == "yes")
        {
            gpaLabel.text = " "
        }
        else if (AllVariables.gpaAnon == "no"){
            gpaLabel.text = AllVariables.GPA
        }
        
        myCourses.text = "No courses added!"
    }
    func setProfilePicture(imageView:UIImageView, imageToSet:UIImage)
    {
        imageView.layer.cornerRadius = 10.0
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.layer.masksToBounds = true
        imageView.image = imageToSet
    }
    
    override func viewDidAppear(_ animated: Bool) {
        myCourses.text = ""
        updateBioText.text = AllVariables.bio
        var databaseProfilePic = AllVariables.profpic
        if (AllVariables.gpaAnon == "yes")
        {
            gpaLabel.text = " "
        }
        else if (AllVariables.gpaAnon == "no"){
            gpaLabel.text = AllVariables.GPA
        }
        
        let data = NSData(contentsOf: NSURL(string: databaseProfilePic)! as URL)
        if (AllVariables.profpic != "") {
            setProfilePicture(imageView: self.pictureonprofilepage,imageToSet:UIImage(data: data! as Data)!)
        }
        let size = AllVariables.courses.endIndex
        list.removeAll()
        if (size != 0) {
            var  i = 0;
        
            while (i < size){
                list += "\(AllVariables.courses[i])\n "
                i += 1
            }
            myCourses.text = list
        }
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func clear() {
        AllVariables.Username = ""
        AllVariables.Fname = ""
        AllVariables.Lname = ""
        AllVariables.GPA = ""
        AllVariables.standing = ""
        AllVariables.courses.removeAll()
        AllVariables.profpic = ""
        AllVariables.bio = ""
        AllVariables.uid = ""
        AllVariables.books.removeAll()
        AllVariables.courseselected = ""
        AllVariables.profselected = ""
        AllVariables.courseratings.removeAll()
        AllVariables.coursegrade.removeAll()
        AllVariables.examrating.removeAll()
        AllVariables.profratings.removeAll()
        AllVariables.gpaAnon = ""
    }
    
    @IBAction func logoutButton(_ sender: Any) {
        
        if (Auth.auth().currentUser != nil)
        {
            do {
                try? Auth.auth().signOut()
                
                if (Auth.auth().currentUser == nil) {
                    print("USER LOG OUT")
                    let loginVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginViewController") as UIViewController
                    self.present(loginVC, animated: true, completion: nil)
                    clear()
                }
            }
        }
    
    }
   
    
}


