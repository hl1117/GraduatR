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
   
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
       pictureonprofilepage = image

    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
