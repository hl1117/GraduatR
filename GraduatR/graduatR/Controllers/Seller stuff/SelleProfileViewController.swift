//
//  SellerProfileViewController.swift
//  graduatR
//
//  Created by Swaraj Bhaduri on 4/10/18.
//  Copyright © 2018 Simona Virga. All rights reserved.
//

import UIKit
import Firebase

class SelleProfileViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var gpa: UILabel!
    @IBOutlet weak var bio: UILabel!
    @IBOutlet weak var classesTaken: UILabel!
    var uid = String()
    var ref = Database.database().reference()
    var courses = [String]()
    @IBOutlet weak var sellprofpic: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getdata()
        
        self.tableView.reloadData()
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    func setProfilePicture(imageView:UIImageView, imageToSet:UIImage)
    {
        imageView.layer.cornerRadius = 10.0
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.layer.masksToBounds = true
        imageView.image = imageToSet
    }
    
    func getdata() {
        ref.child("Users").child("Student").child(uid).observeSingleEvent(of: DataEventType.value, with: { (snap) in
            print("HERE - student")
            let value = snap.value as? NSDictionary
            self.name.text = "\(value?["Fname"] as? String ?? "") \(value?["Lname"] as? String ?? "")"
            self.bio.text = value?["bio"] as? String ?? ""
            if (value?["GPA Anonymity"] as? String == "no") {
                self.gpa.text = value?["GPA"] as? String ?? ""
            }
            let prof = value?["profile_pic"] as? String ?? ""
            if (prof != "") {
                let data = NSData(contentsOf: NSURL(string: prof)! as URL)
                self.setProfilePicture(imageView: self.sellprofpic, imageToSet: UIImage(data: data! as Data)!)
            }
            self.ref.child("Users").child("Student").child(self.uid).child("Courses").observeSingleEvent(of: DataEventType.value, with: { (snapshotCourse) in
                let counter = 0;
                let enumer = snapshotCourse.children
                while let rest = enumer.nextObject() as? DataSnapshot {
                    let val = rest.value as! String
                    if (!self.courses.contains(val)) {
//                    course = "\(course) \(rest.value as! String)"
                        self.courses.append(val)
                        
                        self.tableView.reloadData()
                        self.tableView.delegate = self
                        self.tableView.dataSource = self
                        
                    }
                }
                 print(self.courses)
//                self.classesTaken.text = course
            })
        })
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return courses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SellerProfCell", for: indexPath) as! SellerProfCell
        
        let nam = courses[indexPath.row]
        print("....lets seee....")
        cell.courseTaking!.text = nam
        
        return cell
    }
    
}
