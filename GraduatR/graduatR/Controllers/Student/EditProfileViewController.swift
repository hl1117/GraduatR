//
//  EditProfileViewController.swift
//  graduatR
//
//  Created by Harika Lingareddy on 2/20/18.
//  Copyright © 2018 Simona Virga. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage

class EditProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var ProfilePictureImage: UIImageView!
    var loggedInUser: AnyObject?
    var databaseRef = Database.database().reference()
    var storageRef = Storage.storage().reference()
    var imagePicker = UIImagePickerController()
    
    
    @IBOutlet weak var bioText: UITextView!
    //@IBOutlet weak var gpaTextField: UITextField!
    @IBOutlet weak var gpaAnon: UISwitch!
    
    @IBOutlet weak var gpaTextField: UITextView!
    @IBOutlet weak var wantparent: UILabel!
    
    @IBOutlet weak var clickAddParent: UIButton!
    
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
    
    @IBAction func bioButtonPressed(_ sender: Any) {
        if (gpaAnon.isOn)
        {
            databaseRef.child("Users").child("Student").child(AllVariables.uid).child("GPA").setValue(gpaTextField.text!)
            databaseRef.child("Users").child("Student").child(AllVariables.uid).child("GPA Anonymity").setValue("yes")
            databaseRef.child("Users").child("Student").child(AllVariables.uid).child("bio").setValue(bioText.text!)
            AllVariables.gpaAnon = "yes"
            AllVariables.GPA = gpaTextField.text!
            AllVariables.bio = bioText.text!
        }
        else if !(gpaAnon.isOn) {
            databaseRef.child("Users").child("Student").child(AllVariables.uid).child("GPA").setValue(gpaTextField.text!)
            databaseRef.child("Users").child("Student").child(AllVariables.uid).child("GPA Anonymity").setValue("no")
            databaseRef.child("Users").child("Student").child(AllVariables.uid).child("bio").setValue(bioText.text!)
            AllVariables.gpaAnon = "yes"
            AllVariables.GPA = gpaTextField.text!
            AllVariables.bio = bioText.text!
        }
        navigationController?.popViewController(animated: true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loggedInUser = Auth.auth().currentUser
        bioText.text = AllVariables.bio
        gpaTextField.text = AllVariables.GPA
        //  wantparent.text = "Want to connect to your Parent?"
        clickAddParent.setTitle("Add Parent", for: UIControlState.normal)
        self.databaseRef.child("Users").child("Student").child(AllVariables.uid).observeSingleEvent(of: .value) {
            (snapshot: DataSnapshot) in
            
            let value = snapshot.value as? [String : AnyObject] ?? [:]
            
            if (value["profile_pic"] != nil) {
                
                let databaseProfilePic = value["profile_pic"] as? String!
                let data = NSData(contentsOf: NSURL(string: databaseProfilePic!)! as URL)
                
                self.setProfilePicture(imageView: self.ProfilePictureImage,imageToSet:UIImage(data: data! as Data)!)
            }
            
        }
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func changePicture(_ sender: Any) {
        let myActionSheet = UIAlertController(title: "Profile Picture", message: "Select", preferredStyle: UIAlertControllerStyle.actionSheet)
        
        let viewPicture = UIAlertAction(title: "View Picture", style: UIAlertActionStyle.default) { (action) in
            
            let imageView = sender as! UIImageView
            let newImageView = UIImageView(image: imageView.image)
            
            newImageView.frame = self.view.frame
            newImageView.backgroundColor = UIColor.black
            newImageView.contentMode = .scaleAspectFit
            newImageView.isUserInteractionEnabled = true
            
            self.view.addSubview(newImageView)
        }
        let photoGallery = UIAlertAction(title: "Photos", style: UIAlertActionStyle.default) { (action) in
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.savedPhotosAlbum)
            {
                self.imagePicker.delegate = self
                self.imagePicker.sourceType = UIImagePickerControllerSourceType.savedPhotosAlbum
                self.imagePicker.allowsEditing = true
                self.present(self.imagePicker, animated: true, completion: nil)
            }
        }
        
        let camera = UIAlertAction(title: "Camera", style: UIAlertActionStyle.default) { (action) in
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera) {
                self.imagePicker.delegate = self
                self.imagePicker.sourceType = UIImagePickerControllerSourceType.camera
                self.imagePicker.allowsEditing = true
                self.present(self.imagePicker, animated: true, completion: nil)
            }
        }
        myActionSheet.addAction(viewPicture)
        myActionSheet.addAction(photoGallery)
        myActionSheet.addAction(camera)
        myActionSheet.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil))
        self.present(myActionSheet, animated: true, completion: nil)
    }
    
    
    //        func dismissFullScreenImage(sender: AnyObject) {
    //            (sender ).removeFromSuperView()
    //   }
    //        imagePicker.allowsEditing = false
    //        imagePicker.sourceType = .photoLibrary
    //        imagePicker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
    //        imagePicker(picker, animated: true, completion: nil)
    
    
    func setProfilePicture(imageView:UIImageView, imageToSet:UIImage)
    {
        imageView.layer.cornerRadius = 10.0
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.layer.masksToBounds = true
        imageView.image = imageToSet
    }
    
    @objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        setProfilePicture(imageView: self.ProfilePictureImage, imageToSet: image)
        
        if let imageData: NSData = UIImagePNGRepresentation(self.ProfilePictureImage.image!)! as NSData
        {
            let profilePicStorageRef = storageRef.child("Users/\(self.loggedInUser!.uid)/profile_pic")
            
            let uploadTask = profilePicStorageRef.putData(imageData as Data, metadata: nil)
            {metadata, error in
                if (error == nil) {
                    let downloadURL = metadata?.downloadURL()
                    self.databaseRef.child("Users").child("Student").child(AllVariables.uid).child("profile_pic").setValue(downloadURL!.absoluteString)
                        AllVariables.profpic = downloadURL!.absoluteString
                        Database.database().reference().child("Courses").observeSingleEvent(of: DataEventType.value, with: { (s) in
                            let enumer = s.children
                            while let rest = enumer.nextObject() as? DataSnapshot {
                                if (rest.hasChild(AllVariables.Username)) {
                                    self.databaseRef.child("Courses").child(rest.key).child(AllVariables.Username).child("ProfPic").setValue(AllVariables.profpic)
                                }
                            }
                            
                        })
                    
                    let alert = UIAlertController(title: "SUCCESS", message: "Profile Picture updated!", preferredStyle: .alert)
                    let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
                        print ("ok tappped")
                    }
                    alert.addAction(OKAction)
                    self.present(alert, animated: true) {
                        print("Sucesss")
                    }
                }
                else {
                    print(error?.localizedDescription)
                }
                //self.imageLoader.stopAnimating()
            }
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    //    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    //    {
    //        var VC = segue.destination as! ViewProfileViewController
    //        VC.image = ProfilePictureImage
    //        //VC.pictureonprofilepage = ProfilePictureImage
    //    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    @IBAction func deleteButton(_ sender: Any) {
        let user = Auth.auth().currentUser
        user?.delete(completion: { (error) in
            if let error = error {
                print(error.localizedDescription)
            }
            else {
                let alertView = UIAlertView(title: "Delete Account", message: "You have successfully deleted your account.", delegate: self, cancelButtonTitle: "Goodbye")
                alertView.show()
                let loginVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginViewController") as UIViewController
                self.present(loginVC, animated: true, completion: nil)
                self.databaseRef.child("Users").child("Usernames").child(AllVariables.Username).removeValue()
                self.databaseRef.child("Users").observeSingleEvent(of: DataEventType.value, with: { (s) in
                    let enumer = s.children
                    while let rest = enumer.nextObject() as? DataSnapshot {
                        if (rest.hasChild(AllVariables.uid)) {
                            if (rest.key == "Student") {
                                self.databaseRef.child("Users").child("StudentUsers").child(AllVariables.Username).removeValue()
                            }
                            self.databaseRef.child("Users").child(rest.key).child(AllVariables.uid).removeValue()
                        }
                    }
                })
                
                //Remove parent if any?????
                self.databaseRef.child("Users").child("Student").child(AllVariables.uid).observeSingleEvent(of: DataEventType.value, with: { (aa) in
                   
                        if (aa.hasChild("ParentUID")) {
                            let rest = aa.value as! NSDictionary
                            
                            let parentUID = rest["ParentUID"] as! String
                            //print("has a parent.....")
                            self.databaseRef.child("Users").child("Parent").child(parentUID).child("Studentid").removeValue()
                            //print("parent deleeeeeteeed")
                            
                        }
        
                })
                
                
                //Remove from ProfessorReviews
                self.databaseRef.child("ProfessorReviews").observeSingleEvent(of: DataEventType.value, with: { (ss) in
                    let enumer = ss.children
                    while let rest = enumer.nextObject() as? DataSnapshot {
                        if (rest.hasChild(AllVariables.Username)) {
                            self.databaseRef.child("ProfessorReviews").child(rest.key).child(AllVariables.Username).removeValue()
                        }
                    }
                })
                //Remove from AllCourseGrades
                self.databaseRef.child("AllCourseGrades").observeSingleEvent(of: DataEventType.value, with: { (sss) in
                    let enumer = sss.children
                    while let rest = enumer.nextObject() as? DataSnapshot {
                        if (rest.hasChild(AllVariables.Username)) {
                            self.databaseRef.child("AllCourseGrades").child(rest.key).child(AllVariables.Username).removeValue()
                        }
                    }
                })
                //Remove from CourseReviews
                self.databaseRef.child("CourseReviews").observeSingleEvent(of: DataEventType.value, with: { (a) in
                    let enumer = a.children
                    while let rest = enumer.nextObject() as? DataSnapshot {
                        if (rest.hasChild(AllVariables.Username)) {
                            self.databaseRef.child("CourseReviews").child(rest.key).child(AllVariables.Username).removeValue()
                        }
                    }
                })
                //Remove from courses
                self.databaseRef.child("Courses").observeSingleEvent(of: DataEventType.value, with: { (aa) in
                    let enumer = aa.children
                    while let rest = enumer.nextObject() as? DataSnapshot {
                        if (rest.hasChild(AllVariables.Username)) {
                            self.databaseRef.child("Courses").child(rest.key).child(AllVariables.Username).removeValue()
                        }
                    }
                })
                //Remove from exam reviews
                self.databaseRef.child("ExamReviews").observeSingleEvent(of: DataEventType.value, with: { (aaa) in
                    let enumer = aaa.children
                    while let rest = enumer.nextObject() as? DataSnapshot {
                        if (rest.hasChild(AllVariables.Username)) {
                            self.databaseRef.child("ExamReviews").child(rest.key).child(AllVariables.Username).removeValue()
                        }
                    }
                })
                //Remove from chats
                self.databaseRef.child("Chats").observeSingleEvent(of: DataEventType.value, with: { (b) in
                    if (b.hasChild(AllVariables.Username)) {
                        self.databaseRef.child("Chats").child(AllVariables.Username).removeValue()
                    }
                    let enumer = b.children
                    while let rest = enumer.nextObject() as? DataSnapshot {
                        if (rest.hasChild(AllVariables.Username)) {
                            self.databaseRef.child("Chats").child(rest.key).child(AllVariables.Username).removeValue()
                        }
                    }
                })
                //Remove from GroupChats
                self.databaseRef.child("GroupChats").observeSingleEvent(of: DataEventType.value, with: { (bb) in
                    let enumer = bb.children
                    while let rest = enumer.nextObject() as? DataSnapshot {
                        self.databaseRef.child("GroupChats").child(rest.key).child("chatUsers").observeSingleEvent(of: DataEventType.value, with: {(bbc) in
                            if (bbc.hasChild(AllVariables.Username)) {
                            self.databaseRef.child("GroupChats").child(rest.key).child("chatUsers").child(AllVariables.Username).removeValue()
                            }
                        })
                    }
                })
                self.clear()
            }
        })
    }
}


