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
    
    var ref = Database.database().reference()
    var storageRef = Storage.storage().reference()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("PROF: \(AllVariables.profselected)")
        self.ref.observeSingleEvent(of: DataEventType.value, with: { (snapshotA) in
            print("WHAT3")
            if (!(snapshotA.hasChild("ProfessorReviews"))) {
                self.ref.child("ProfessorReviews").child(AllVariables.profselected).setValue(["1stars": 0, "2stars": 0, "3stars": 0, "4stars": 0, "5stars": 0 ])
            }
        })
        
        
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
        
        self.ref.child("ProfessorReviews").observeSingleEvent(of: DataEventType.value, with: { (snapshotA) in
            print("WHAT4")
            if (!(snapshotA.hasChild(AllVariables.profselected))) {
                self.ref.child("ProfessorReviews").child(AllVariables.profselected).child("1stars").setValue(1)
                
                self.ref.child("ProfessorReviews").child(AllVariables.profselected).child("2stars").setValue(0)
                
                self.ref.child("ProfessorReviews").child(AllVariables.profselected).child("3stars").setValue(0)
                
                self.ref.child("ProfessorReviews").child(AllVariables.profselected).child("4stars").setValue(0)
                self.ref.child("ProfessorReviews").child(AllVariables.profselected).child("5stars").setValue(0)
            }
            else {
                self.ref.child("ProfessorReviews").child(AllVariables.profselected).observeSingleEvent(of: DataEventType.value, with: { (snapshotB) in
                    let value = snapshotB.value as? NSDictionary
                    let a = value?["1stars"] as? Int
                    let final = a! + 1
                    print("FINAL = \(final)")
                    self.ref.child("ProfessorReviews").child(AllVariables.profselected).child("1stars").setValue(final)
                })
            }
            
        })
    }
    
    @IBAction func star2(_ sender: Any) {
        if let image = UIImage(named:"icons8-christmas-star-50") {
            (sender as AnyObject).setImage(UIImage(named:"icons8-christmas-star-filled-50"), for: .normal)
            star1.setImage(UIImage(named:"icons8-christmas-star-filled-50"), for: UIControlState.normal)
            star3.setImage(UIImage(named:"icons8-christmas-star-50"), for: UIControlState.normal)
            star4.setImage(UIImage(named:"icons8-christmas-star-50"), for: UIControlState.normal)
            star5.setImage(UIImage(named:"icons8-christmas-star-50"), for: UIControlState.normal)
        }
        self.ref.child("ProfessorReviews").observeSingleEvent(of: DataEventType.value, with: { (snapshotA) in
            print("WHAT4")
            if (!(snapshotA.hasChild(AllVariables.profselected))) {
                self.ref.child("ProfessorReviews").child(AllVariables.profselected).child("1stars").setValue(0)
                
                self.ref.child("ProfessorReviews").child(AllVariables.profselected).child("2stars").setValue(1)
                
                self.ref.child("ProfessorReviews").child(AllVariables.profselected).child("3stars").setValue(0)
                
                self.ref.child("ProfessorReviews").child(AllVariables.profselected).child("4stars").setValue(0)
                self.ref.child("ProfessorReviews").child(AllVariables.profselected).child("5stars").setValue(0)
            }
            else {
                self.ref.child("ProfessorReviews").child(AllVariables.profselected).observeSingleEvent(of: DataEventType.value, with: { (snapshotB) in
                    
                    let value = snapshotB.value as? NSDictionary
                    let a = value?["2stars"] as? Int
                    let final = a! + 1
                    print("FINAL = \(final)")
                    self.ref.child("ProfessorReviews").child(AllVariables.profselected).child("2stars").setValue(final)
                })
            }
        })
        
        
    }
    
    @IBAction func star3(_ sender: Any) {
        if let image = UIImage(named:"icons8-christmas-star-50") {
            (sender as AnyObject).setImage(UIImage(named:"icons8-christmas-star-filled-50"), for: .normal)
            star1.setImage(UIImage(named:"icons8-christmas-star-filled-50"), for: UIControlState.normal)
            star2.setImage(UIImage(named:"icons8-christmas-star-filled-50"), for: UIControlState.normal)
            star4.setImage(UIImage(named:"icons8-christmas-star-50"), for: UIControlState.normal)
            star5.setImage(UIImage(named:"icons8-christmas-star-50"), for: UIControlState.normal)
        }
        self.ref.child("ProfessorReviews").observeSingleEvent(of: DataEventType.value, with: { (snapshotA) in
            print("WHAT4")
            if (!(snapshotA.hasChild(AllVariables.profselected))) {
                self.ref.child("ProfessorReviews").child(AllVariables.profselected).child("1stars").setValue(0)
                
                self.ref.child("ProfessorReviews").child(AllVariables.profselected).child("2stars").setValue(0)
                
                self.ref.child("ProfessorReviews").child(AllVariables.profselected).child("3stars").setValue(1)
                
                self.ref.child("ProfessorReviews").child(AllVariables.profselected).child("4stars").setValue(0)
                self.ref.child("ProfessorReviews").child(AllVariables.profselected).child("5stars").setValue(0)
            }
            else {
                self.ref.child("ProfessorReviews").child(AllVariables.profselected).observeSingleEvent(of: DataEventType.value, with: { (snapshotB) in
                    
                    let value = snapshotB.value as? NSDictionary
                    let a = value?["3stars"] as? Int
                    let final = a! + 1
                    print("FINAL = \(final)")
                    self.ref.child("ProfessorReviews").child(AllVariables.profselected).child("3stars").setValue(final)
                })
            }
        })
        
    }
    
    @IBAction func star4(_ sender: Any) {
        if let image = UIImage(named:"icons8-christmas-star-50") {
            (sender as AnyObject).setImage(UIImage(named:"icons8-christmas-star-filled-50"), for: .normal)
            star1.setImage(UIImage(named:"icons8-christmas-star-filled-50"), for: UIControlState.normal)
            star2.setImage(UIImage(named:"icons8-christmas-star-filled-50"), for: UIControlState.normal)
            star3.setImage(UIImage(named:"icons8-christmas-star-filled-50"), for: UIControlState.normal)
            star5.setImage(UIImage(named:"icons8-christmas-star-50"), for: UIControlState.normal)
        }
        self.ref.child("ProfessorReviews").observeSingleEvent(of: DataEventType.value, with: { (snapshotA) in
            print("WHAT4")
            if (!(snapshotA.hasChild(AllVariables.profselected))) {
                self.ref.child("ProfessorReviews").child(AllVariables.profselected).child("1stars").setValue(0)
                
                self.ref.child("ProfessorReviews").child(AllVariables.profselected).child("2stars").setValue(0)
                
                self.ref.child("ProfessorReviews").child(AllVariables.profselected).child("3stars").setValue(0)
                
                self.ref.child("ProfessorReviews").child(AllVariables.profselected).child("4stars").setValue(1)
                self.ref.child("ProfessorReviews").child(AllVariables.profselected).child("5stars").setValue(0)
            }
            else {
                self.ref.child("ProfessorReviews").child(AllVariables.profselected).observeSingleEvent(of: DataEventType.value, with: { (snapshotB) in
                    
                    let value = snapshotB.value as? NSDictionary
                    let a = value?["4stars"] as? Int
                    let final = a! + 1
                    print("FINAL = \(final)")
                    self.ref.child("ProfessorReviews").child(AllVariables.profselected).child("4stars").setValue(final)
                })
            }
        })
        
    }
    
    @IBAction func star5(_ sender: Any) {
        if let image = UIImage(named:"icons8-christmas-star-50") {
            (sender as AnyObject).setImage(UIImage(named:"icons8-christmas-star-filled-50"), for: .normal)
            star1.setImage(UIImage(named:"icons8-christmas-star-filled-50"), for: UIControlState.normal)
            star2.setImage(UIImage(named:"icons8-christmas-star-filled-50"), for: UIControlState.normal)
            star3.setImage(UIImage(named:"icons8-christmas-star-filled-50"), for: UIControlState.normal)
            star4.setImage(UIImage(named:"icons8-christmas-star-filled-50"), for: UIControlState.normal)
        }
        self.ref.child("ProfessorReviews").observeSingleEvent(of: DataEventType.value, with: { (snapshotA) in
            print("WHAT4")
            if (!(snapshotA.hasChild(AllVariables.profselected))) {
                self.ref.child("ProfessorReviews").child(AllVariables.profselected).child("1stars").setValue(0)
                
                self.ref.child("ProfessorReviews").child(AllVariables.profselected).child("2stars").setValue(0)
                
                self.ref.child("ProfessorReviews").child(AllVariables.profselected).child("3stars").setValue(0)
                
                self.ref.child("ProfessorReviews").child(AllVariables.profselected).child("4stars").setValue(0)
                self.ref.child("ProfessorReviews").child(AllVariables.profselected).child("5stars").setValue(1)
            }
            else {
                self.ref.child("ProfessorReviews").child(AllVariables.profselected).observeSingleEvent(of: DataEventType.value, with: { (snapshotB) in
                    
                    let value = snapshotB.value as? NSDictionary
                    let a = value?["5stars"] as? Int
                    let final = a! + 1
                    print("FINAL = \(final)")
                    self.ref.child("ProfessorReviews").child(AllVariables.profselected).child("5stars").setValue(final)
                })
            }
        })
    }
    
    
}

