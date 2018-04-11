//
//  SellerProfileViewController.swift
//  graduatR
//
//  Created by Swaraj Bhaduri on 4/10/18.
//  Copyright © 2018 Simona Virga. All rights reserved.
//

import UIKit
import Firebase

class SelleProfileViewController: UIViewController {
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var gpa: UILabel!
    @IBOutlet weak var bio: UILabel!
    @IBOutlet weak var classesTaken: UILabel!
    var uid = String()
    var ref = Database.database().reference()
    
    @IBOutlet weak var sellprofpic: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        getdata()
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
            self.gpa.text = value?["GPA"] as? String ?? ""
            let prof = value?["profile_pic"] as? String ?? ""
            if (prof != "") {
                let data = NSData(contentsOf: NSURL(string: prof)! as URL)
                
                self.setProfilePicture(imageView: self.sellprofpic, imageToSet: UIImage(data: data! as Data)!)
            }
            self.ref.child("Users").child("Student").child(self.uid).child("Courses").observeSingleEvent(of: DataEventType.value, with: { (snapshotCourse) in
                let counter = 0;
                var course = String()
                let enumer = snapshotCourse.children
                while let rest = enumer.nextObject() as? DataSnapshot {
                    course = "\(course) \(rest.value as! String)"
                }
                self.classesTaken.text = course
            })
        })
            
    }

}
