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
    
    
    @IBAction func bioButtonPressed(_ sender: Any) {
        AllVariables.bio = bioText.text!
       
        
        
        AllVariables.GPA = gpaTextField.text!
//
//        if (AllVariables.gpaAnon == "yes")
//        {
//            gpaAnon.setOn(true, animated: true)
//        }
//        else if (AllVariables.gpaAnon == "no")
//        {
//            gpaAnon.setOn(false, animated: false)
//
//        }
        
        if (gpaAnon.isOn)
        {
            databaseRef.child("Users").child("Student").child(AllVariables.uid).setValue(["Username": AllVariables.Username, "Fname": AllVariables.Fname, "Lname": AllVariables.Lname, "GPA" : AllVariables.GPA, "Class": AllVariables.standing, "GPA Anonymity": "yes"])
            AllVariables.gpaAnon = "yes"
        }
        else if !(gpaAnon.isOn) {
            databaseRef.child("Users").child("Student").child(AllVariables.uid).setValue(["Username": AllVariables.Username, "Fname": AllVariables.Fname, "Lname": AllVariables.Lname, "GPA" : AllVariables.GPA, "Class": AllVariables.standing, "GPA Anonymity": "no"])
            AllVariables.gpaAnon = "no"
        }
        AllVariables.GPA = gpaTextField.text!
         self.databaseRef.child("Users").child("Student").child(AllVariables.uid).child("bio").setValue(bioText.text)
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
                    print("successful upload")
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
        //AllVariables.bio = bioText.text
        bioText.text = AllVariables.bio
        gpaTextField.text = AllVariables.GPA
    }

}




