//
//  AddProfessorReviewViewController.swift
//  graduatR
//
//  Created by Harika Lingareddy on 3/22/18.
//  Copyright © 2018 Simona Virga. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class AddProfessorReviewViewController: UIViewController {

    @IBOutlet weak var star1: UIButton!
    @IBOutlet weak var star2: UIButton!
    @IBOutlet weak var star3: UIButton!
    @IBOutlet weak var star4: UIButton!
    @IBOutlet weak var star5: UIButton!
    @IBOutlet weak var reviewText: UITextView!
    
    var databaseRef = Database.database().reference()
    var storageRef = Storage.storage().reference()
    var ref: DatabaseReference!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func updateReview(_ sender: Any) {
        
        
    }
    
    
    @IBAction func star1(_ sender: Any) {
        if let image = UIImage(named:"icons8-christmas-star-50") {
            (sender as AnyObject).setImage(UIImage(named:"icons8-christmas-star-filled-50"), for: .normal)
        }
        star2.setImage(UIImage(named:"icons8-christmas-star-50"), for: UIControlState.normal)
        star3.setImage(UIImage(named:"icons8-christmas-star-50"), for: UIControlState.normal)
        star4.setImage(UIImage(named:"icons8-christmas-star-50"), for: UIControlState.normal)
        star5.setImage(UIImage(named:"icons8-christmas-star-50"), for: UIControlState.normal)
    }
    
    @IBAction func star2(_ sender: Any) {
        if let image = UIImage(named:"icons8-christmas-star-50") {
            (sender as AnyObject).setImage(UIImage(named:"icons8-christmas-star-filled-50"), for: .normal)
            star1.setImage(UIImage(named:"icons8-christmas-star-filled-50"), for: UIControlState.normal)
            star3.setImage(UIImage(named:"icons8-christmas-star-50"), for: UIControlState.normal)
            star4.setImage(UIImage(named:"icons8-christmas-star-50"), for: UIControlState.normal)
            star5.setImage(UIImage(named:"icons8-christmas-star-50"), for: UIControlState.normal)
        }
    }
    
    @IBAction func star3(_ sender: Any) {
        if let image = UIImage(named:"icons8-christmas-star-50") {
            (sender as AnyObject).setImage(UIImage(named:"icons8-christmas-star-filled-50"), for: .normal)
            star1.setImage(UIImage(named:"icons8-christmas-star-filled-50"), for: UIControlState.normal)
            star2.setImage(UIImage(named:"icons8-christmas-star-filled-50"), for: UIControlState.normal)
            star4.setImage(UIImage(named:"icons8-christmas-star-50"), for: UIControlState.normal)
            star5.setImage(UIImage(named:"icons8-christmas-star-50"), for: UIControlState.normal)
        }
    }
 
    @IBAction func star4(_ sender: Any) {
        if let image = UIImage(named:"icons8-christmas-star-50") {
            (sender as AnyObject).setImage(UIImage(named:"icons8-christmas-star-filled-50"), for: .normal)
            star1.setImage(UIImage(named:"icons8-christmas-star-filled-50"), for: UIControlState.normal)
            star2.setImage(UIImage(named:"icons8-christmas-star-filled-50"), for: UIControlState.normal)
            star3.setImage(UIImage(named:"icons8-christmas-star-filled-50"), for: UIControlState.normal)
            star5.setImage(UIImage(named:"icons8-christmas-star-50"), for: UIControlState.normal)
        }
    }
    
    @IBAction func star5(_ sender: Any) {
        if let image = UIImage(named:"icons8-christmas-star-50") {
            (sender as AnyObject).setImage(UIImage(named:"icons8-christmas-star-filled-50"), for: .normal)
            star1.setImage(UIImage(named:"icons8-christmas-star-filled-50"), for: UIControlState.normal)
            star2.setImage(UIImage(named:"icons8-christmas-star-filled-50"), for: UIControlState.normal)
            star3.setImage(UIImage(named:"icons8-christmas-star-filled-50"), for: UIControlState.normal)
            star4.setImage(UIImage(named:"icons8-christmas-star-filled-50"), for: UIControlState.normal)
        }
    }
    
}
