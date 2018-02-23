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

class ViewProfileViewController: UIViewController
{
    
    var loggedInUser: AnyObject?
    var databaseRef = Database.database().reference()
    var storageRef = Storage.storage().reference()
    var image: UIImageView!
    
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
    }
    
    override func viewDidAppear(_ animated: Bool) {
        updateBioText.text = AllVariables.bio
        pictureonprofilepage = image
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}


