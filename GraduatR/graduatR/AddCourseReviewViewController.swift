////
//  AddCourseReviewViewController.swift
//  graduatR
//
//  Created by Simona Virga on 3/21/18.
//  Copyright © 2018 Simona Virga. All rights reserved.
//

import UIKit
import Firebase

class AddCourseReviewViewController: UIViewController {
    
    @IBOutlet weak var star1: UIButton!
    @IBOutlet weak var star2: UIButton!
    @IBOutlet weak var star3: UIButton!
    @IBOutlet weak var star4: UIButton!
    @IBOutlet weak var star5: UIButton!
    @IBOutlet weak var courseReview: UITextView!
    
    let ref = Database.database().reference();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.ref.observeSingleEvent(of: DataEventType.value, with: { (snapshotA) in
            print("WHAT3")
            if (!(snapshotA.hasChild("CourseReviews"))) {
                self.ref.child("CourseReviews").child(AllVariables.courseselected).setValue(["1stars": 0, "2stars": 0, "3stars": 0, "4stars": 0, "5stars": 0 ])
                
            }
        })
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    @IBAction func addReviewButton(_ sender: Any)
    {
        
    }
    
    @IBAction func star1Rate(_ sender: UIButton) {
        print("HERE")

        print("HERE2")
        if let image = UIImage(named:"icons8-christmas-star-50") {
            sender.setImage(UIImage(named:"icons8-christmas-star-filled-50"), for: .normal)
        }
        star2.setImage(UIImage(named:"icons8-christmas-star-50"), for: UIControlState.normal)
        star3.setImage(UIImage(named:"icons8-christmas-star-50"), for: UIControlState.normal)
        star4.setImage(UIImage(named:"icons8-christmas-star-50"), for: UIControlState.normal)
        star5.setImage(UIImage(named:"icons8-christmas-star-50"), for: UIControlState.normal)
        /*if let image = UIImage(named:"icons8-christmas-star-filled-50") {
         sender.setImage( UIImage(named:"icons8-christmas-star-50"), for: .normal)
         }*/
        self.ref.child("CourseReviews").observeSingleEvent(of: DataEventType.value, with: { (snapshotA) in
            print("WHAT4")
            if (!(snapshotA.hasChild(AllVariables.courseselected))) {
                self.ref.child("CourseReviews").child(AllVariables.courseselected).child("1stars").setValue(1)
                
                self.ref.child("CourseReviews").child(AllVariables.courseselected).child("2stars").setValue(0)
                
                self.ref.child("CourseReviews").child(AllVariables.courseselected).child("3stars").setValue(0)
                
                self.ref.child("CourseReviews").child(AllVariables.courseselected).child("4stars").setValue(0)
                self.ref.child("CourseReviews").child(AllVariables.courseselected).child("5stars").setValue(0)
            }
            else {
                self.ref.child("CourseReviews").child(AllVariables.courseselected).observeSingleEvent(of: DataEventType.value, with: { (snapshotB) in
                let value = snapshotB.value as? NSDictionary
                let a = value?["1stars"] as? Int
                let final = a! + 1
                print("FINAL = \(final)")
            self.ref.child("CourseReviews").child(AllVariables.courseselected).child("1stars").setValue(final)
                })
            }
                
        })
       
        
    }
    
    @IBAction func star2Rate(_ sender: UIButton) {
        
        if let image = UIImage(named:"icons8-christmas-star-50") {
            sender.setImage(UIImage(named:"icons8-christmas-star-filled-50"), for: .normal)
            star1.setImage(UIImage(named:"icons8-christmas-star-filled-50"), for: UIControlState.normal)
            star3.setImage(UIImage(named:"icons8-christmas-star-50"), for: UIControlState.normal)
            star4.setImage(UIImage(named:"icons8-christmas-star-50"), for: UIControlState.normal)
            star5.setImage(UIImage(named:"icons8-christmas-star-50"), for: UIControlState.normal)
        }
        self.ref.child("CourseReviews").observeSingleEvent(of: DataEventType.value, with: { (snapshotA) in
            print("WHAT4")
            if (!(snapshotA.hasChild(AllVariables.courseselected))) {
                self.ref.child("CourseReviews").child(AllVariables.courseselected).child("1stars").setValue(0)
                
                self.ref.child("CourseReviews").child(AllVariables.courseselected).child("2stars").setValue(1)
                
                self.ref.child("CourseReviews").child(AllVariables.courseselected).child("3stars").setValue(0)
                
                self.ref.child("CourseReviews").child(AllVariables.courseselected).child("4stars").setValue(0)
                self.ref.child("CourseReviews").child(AllVariables.courseselected).child("5stars").setValue(0)
            }
            else {
                self.ref.child("CourseReviews").child(AllVariables.courseselected).observeSingleEvent(of: DataEventType.value, with: { (snapshotB) in
                    
                let value = snapshotB.value as? NSDictionary
                let a = value?["2stars"] as? Int
                let final = a! + 1
                print("FINAL = \(final)")
                self.ref.child("CourseReviews").child(AllVariables.courseselected).child("2stars").setValue(final)
                })
            }
        })
        
        
        /*if let image = UIImage(named:"icons8-christmas-star-filled-50") {
         sender.setImage( UIImage(named:"icons8-christmas-star-50"), for: .normal)
         }*/
        
    }
    
    @IBAction func star3Rate(_ sender: UIButton) {
        
        if let image = UIImage(named:"icons8-christmas-star-50") {
            sender.setImage(UIImage(named:"icons8-christmas-star-filled-50"), for: .normal)
            star1.setImage(UIImage(named:"icons8-christmas-star-filled-50"), for: UIControlState.normal)
            star2.setImage(UIImage(named:"icons8-christmas-star-filled-50"), for: UIControlState.normal)
            star4.setImage(UIImage(named:"icons8-christmas-star-50"), for: UIControlState.normal)
            star5.setImage(UIImage(named:"icons8-christmas-star-50"), for: UIControlState.normal)
        }
        /*if let image = UIImage(named:"icons8-christmas-star-filled-50") {
         sender.setImage( UIImage(named:"icons8-christmas-star-50"), for: .normal)
         }*/
        self.ref.child("CourseReviews").observeSingleEvent(of: DataEventType.value, with: { (snapshotA) in
            print("WHAT4")
            if (!(snapshotA.hasChild(AllVariables.courseselected))) {
                self.ref.child("CourseReviews").child(AllVariables.courseselected).child("1stars").setValue(0)
                
                self.ref.child("CourseReviews").child(AllVariables.courseselected).child("2stars").setValue(0)
                
                self.ref.child("CourseReviews").child(AllVariables.courseselected).child("3stars").setValue(1)
                
                self.ref.child("CourseReviews").child(AllVariables.courseselected).child("4stars").setValue(0)
                self.ref.child("CourseReviews").child(AllVariables.courseselected).child("5stars").setValue(0)
            }
            else {
                self.ref.child("CourseReviews").child(AllVariables.courseselected).observeSingleEvent(of: DataEventType.value, with: { (snapshotB) in
                    
                let value = snapshotB.value as? NSDictionary
                let a = value?["3stars"] as? Int
                let final = a! + 1
                print("FINAL = \(final)")
                self.ref.child("CourseReviews").child(AllVariables.courseselected).child("3stars").setValue(final)
                })
            }
        })
        
    }
    
    @IBAction func star4Rate(_ sender: UIButton) {
        
        if let image = UIImage(named:"icons8-christmas-star-50") {
            sender.setImage(UIImage(named:"icons8-christmas-star-filled-50"), for: .normal)
            star1.setImage(UIImage(named:"icons8-christmas-star-filled-50"), for: UIControlState.normal)
            star2.setImage(UIImage(named:"icons8-christmas-star-filled-50"), for: UIControlState.normal)
            star3.setImage(UIImage(named:"icons8-christmas-star-filled-50"), for: UIControlState.normal)
            star5.setImage(UIImage(named:"icons8-christmas-star-50"), for: UIControlState.normal)
        }
        /* if let image = UIImage(named:"icons8-christmas-star-filled-50") {
         sender.setImage( UIImage(named:"icons8-christmas-star-50"), for: .normal)
         }*/
        self.ref.child("CourseReviews").observeSingleEvent(of: DataEventType.value, with: { (snapshotA) in
            print("WHAT4")
            if (!(snapshotA.hasChild(AllVariables.courseselected))) {
                self.ref.child("CourseReviews").child(AllVariables.courseselected).child("1stars").setValue(0)
                
                self.ref.child("CourseReviews").child(AllVariables.courseselected).child("2stars").setValue(0)
                
                self.ref.child("CourseReviews").child(AllVariables.courseselected).child("3stars").setValue(0)
                
                self.ref.child("CourseReviews").child(AllVariables.courseselected).child("4stars").setValue(1)
                self.ref.child("CourseReviews").child(AllVariables.courseselected).child("5stars").setValue(0)
            }
            else {
                self.ref.child("CourseReviews").child(AllVariables.courseselected).observeSingleEvent(of: DataEventType.value, with: { (snapshotB) in
                    
                let value = snapshotB.value as? NSDictionary
                let a = value?["4stars"] as? Int
                let final = a! + 1
                print("FINAL = \(final)")
                self.ref.child("CourseReviews").child(AllVariables.courseselected).child("4stars").setValue(final)
                })
            }
        })
        
    }
    
    @IBAction func star5Rate(_ sender: UIButton) {
        
        if let image = UIImage(named:"icons8-christmas-star-50") {
            sender.setImage(UIImage(named:"icons8-christmas-star-filled-50"), for: .normal)
            star1.setImage(UIImage(named:"icons8-christmas-star-filled-50"), for: UIControlState.normal)
            star2.setImage(UIImage(named:"icons8-christmas-star-filled-50"), for: UIControlState.normal)
            star3.setImage(UIImage(named:"icons8-christmas-star-filled-50"), for: UIControlState.normal)
            star4.setImage(UIImage(named:"icons8-christmas-star-filled-50"), for: UIControlState.normal)
        }
        /*if let image = UIImage(named:"icons8-christmas-star-filled-50") {
         sender.setImage( UIImage(named:"icons8-christmas-star-50"), for: .normal)
         }*/
        self.ref.child("CourseReviews").observeSingleEvent(of: DataEventType.value, with: { (snapshotA) in
            print("WHAT4")
            if (!(snapshotA.hasChild(AllVariables.courseselected))) {
                self.ref.child("CourseReviews").child(AllVariables.courseselected).child("1stars").setValue(0)
                
                self.ref.child("CourseReviews").child(AllVariables.courseselected).child("2stars").setValue(0)
                
                self.ref.child("CourseReviews").child(AllVariables.courseselected).child("3stars").setValue(0)
                
                self.ref.child("CourseReviews").child(AllVariables.courseselected).child("4stars").setValue(0)
                self.ref.child("CourseReviews").child(AllVariables.courseselected).child("5stars").setValue(1)
            }
            else {
                self.ref.child("CourseReviews").child(AllVariables.courseselected).observeSingleEvent(of: DataEventType.value, with: { (snapshotB) in
                    
                let value = snapshotB.value as? NSDictionary
                let a = value?["5stars"] as? Int
                let final = a! + 1
                print("FINAL = \(final)")
                self.ref.child("CourseReviews").child(AllVariables.courseselected).child("5stars").setValue(final)
                })
            }
        })
        
    }
    
    
    
    
    
    
}

