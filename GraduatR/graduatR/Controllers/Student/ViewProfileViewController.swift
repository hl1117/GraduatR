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

class ViewProfileViewController: UIViewController, UITableViewDataSource, UITableViewDelegate
{
    
    @IBOutlet weak var myCourses: UILabel!
    var list = String()
    var loggedInUser: AnyObject?
    var databaseRef = Database.database().reference()
    var storageRef = Storage.storage().reference()
    var image: UIImageView!
    
    var refresh: UIRefreshControl!
    
    var courses = [String]()
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
        print (AllVariables.Fname)
        print("............")
        //updateBioText.text = AllVariables.bio
        if (AllVariables.gpaAnon == "yes")
        {
            gpaLabel.text = " "
        }
        else if (AllVariables.gpaAnon == "no"){
            gpaLabel.text = AllVariables.GPA
        }
        
        refresh = UIRefreshControl()
        refresh.addTarget(self, action: #selector(ViewProfileViewController.didPullToRefresh(_:)), for: .valueChanged)
        
        tableView.insertSubview(refresh, at: 0)
        
        self.tableView.reloadData()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        
//        myCourses.text = "No courses added!"
    }
    func setProfilePicture(imageView:UIImageView, imageToSet:UIImage)
    {
        imageView.layer.cornerRadius = 10.0
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.layer.masksToBounds = true
        imageView.image = imageToSet
    }
    
    @objc func didPullToRefresh(_ refreshControl: UIRefreshControl) {
        viewDidAppear(true)
        self.refresh.endRefreshing()
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
//        list.removeAll()
        if (size != 0) {
            var  i = 0;
        
            while (i < size){
                if (!courses.contains(AllVariables.courses[i])){
                    self.courses.append(AllVariables.courses[i])
                    i += 1
                }
                self.refresh.endRefreshing()
                
                self.tableView.reloadData()
                self.tableView.delegate = self
                self.tableView.dataSource = self
            }
            //myCourses.text = list
            
            print(courses)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return courses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StudProfileCell", for: indexPath) as! StudProfileCell
        
        let nam = courses[indexPath.row]
        print("....lets seee....")
        cell.courseTaking!.text = nam
        
        return cell
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
                    GIDSignIn.sharedInstance().signOut()
                    let loginVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CustomLoginViewController") as UIViewController
                    self.present(loginVC, animated: true, completion: nil)
                    clear()
                }
            }
        }
    
    }
   
    
}


