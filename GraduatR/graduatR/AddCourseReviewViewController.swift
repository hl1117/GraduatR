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
    @IBOutlet weak var anonStatus: UISwitch!
    
    @IBOutlet weak var gradeReceivedTextField: UITextField!
    
    @IBOutlet weak var examControl: UISegmentedControl!
    
    let ref = Database.database().reference();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    @IBAction func addReviewButton(_ sender: Any)
    {
        
        if (anonStatus.isOn){
            
            print("REVIEW : \(courseReview.text)")
            print("JHEREE")
            if ((courseReview.text! != "")) {
                self.ref.child("CourseReviews").child(AllVariables.courseselected).child("Comments").child(AllVariables.Username).setValue(["Anonymity": "yes", "reviews": courseReview.text!])
            }
            print("REVIEW : \(courseReview.text)")
        }
      else if (!anonStatus.isOn) {
            if ((courseReview.text! != "")) {
                self.ref.child("CourseReviews").child(AllVariables.courseselected).child("Comments").child(AllVariables.Username).setValue(["Anonymity": "no", "reviews": courseReview.text!])
            }
            
        }

        
        let coursegrades = ["A+", "A" , "A-", "B+", "B", "B-", "C+", "C", "C-", "D+", "D", "D-", "F"]
        let coursegradeinputted = gradeReceivedTextField.text
        
        if (coursegradeinputted == "A+") {
            selectAplus()
        }
        
        if (coursegradeinputted == "A") {
            selectA()
        }
        
        if (coursegradeinputted == "A-") {
            selectAminus()
        }
        
        if (coursegradeinputted == "B+") {
            selectBplus()
        }
        
        if (coursegradeinputted == "B") {
            selectB()
        }
        
        if (coursegradeinputted == "B-") {
            selectBminus()
        }
        
        if (coursegradeinputted == "C+") {
            selectCplus()
        }
        
        if (coursegradeinputted == "C") {
            selectC()
        }
        
        if (coursegradeinputted == "C-") {
            selectCminus()
        }
        
        if (coursegradeinputted == "D+") {
            selectDplus()
        }
        
        if (coursegradeinputted == "D") {
            selectD()
        }
        
        if (coursegradeinputted == "D-") {
            selectDminus()
        }
        
        if (coursegradeinputted == "F") {
            selectF()
        }
        
        
        

        
        let examDifficulty = [1, 2, 3, 4, 5]
        let difficultyReview = examDifficulty[examControl.selectedSegmentIndex]
       
        if(difficultyReview == 1)
        {
            reviewOne()
        }
        
        if(difficultyReview == 2)
        {
            reviewTwo()
        }
        
        if(difficultyReview == 3)
        {
            reviewThree()
        }
        
        if(difficultyReview == 4)
        {
            reviewFour()
        }
        
        if(difficultyReview == 5)
        {
            reviewFive()
        }
    }
    
    func selectAplus()
    {
        
        self.ref.child("AllCourseGrades").observeSingleEvent(of: DataEventType.value, with: { (snapshotA) in
            print("WHAT4")
            if (!(snapshotA.hasChild(AllVariables.courseselected))) {
                self.ref.child("AllCourseGrades").child(AllVariables.courseselected).child("A+").setValue(1)
                self.ref.child("AllCourseGrades").child(AllVariables.courseselected).child("A").setValue(0)
                self.ref.child("AllCourseGrades").child(AllVariables.courseselected).child("A-").setValue(0)
                self.ref.child("AllCourseGrades").child(AllVariables.courseselected).child("B+").setValue(0)
                self.ref.child("AllCourseGrades").child(AllVariables.courseselected).child("B").setValue(0)
                self.ref.child("AllCourseGrades").child(AllVariables.courseselected).child("B-").setValue(0)
                self.ref.child("AllCourseGrades").child(AllVariables.courseselected).child("C+").setValue(0)
                self.ref.child("AllCourseGrades").child(AllVariables.courseselected).child("C").setValue(0)
                self.ref.child("AllCourseGrades").child(AllVariables.courseselected).child("C-").setValue(0)
                self.ref.child("AllCourseGrades").child(AllVariables.courseselected).child("D+").setValue(0)
                self.ref.child("AllCourseGrades").child(AllVariables.courseselected).child("D").setValue(0)
                self.ref.child("AllCourseGrades").child(AllVariables.courseselected).child("D-").setValue(0)
                self.ref.child("AllCourseGrades").child(AllVariables.courseselected).child("F").setValue(0)
                
                self.ref.child("AllCourseGrades").child(AllVariables.courseselected).child(AllVariables.Username).setValue("doesntmatterp2")
            }
            else {
                self.ref.child("AllCourseGrades").child(AllVariables.courseselected).observeSingleEvent(of: DataEventType.value, with: { (snapshotB) in
                    
                    let value = snapshotB.value as? NSDictionary
                    let a = value?["A+"] as? Int
                    let final = a! + 1
                    print("FINAL = \(final)")
                    if (!(snapshotB.hasChild(AllVariables.Username))) { self.ref.child("AllCourseGrades").child(AllVariables.courseselected).child("A+").setValue(final)
                        
                        self.ref.child("AllCourseGrades").child(AllVariables.courseselected).child(AllVariables.Username).setValue("doesntmatterp2")
                    }
                    else {
                        let alert = UIAlertController(title: "Rating Error", message: "You have already rated this course", preferredStyle: .alert)
                        let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
                            print ("ok tappped")
                        }
                        alert.addAction(OKAction)
                        self.present(alert, animated: true) {
                            print("ERROR")
                        }
                        print("error rating in")
                        
                    }
                    
                })
            }
            
        })
    }
    
    func selectA()
    {
        
        self.ref.child("AllCourseGrades").observeSingleEvent(of: DataEventType.value, with: { (snapshotA) in
            print("WHAT4")
            if (!(snapshotA.hasChild(AllVariables.courseselected))) {
                self.ref.child("AllCourseGrades").child(AllVariables.courseselected).child("A+").setValue(0)
                self.ref.child("AllCourseGrades").child(AllVariables.courseselected).child("A").setValue(1)
                self.ref.child("AllCourseGrades").child(AllVariables.courseselected).child("A-").setValue(0)
                self.ref.child("AllCourseGrades").child(AllVariables.courseselected).child("B+").setValue(0)
                self.ref.child("AllCourseGrades").child(AllVariables.courseselected).child("B").setValue(0)
                self.ref.child("AllCourseGrades").child(AllVariables.courseselected).child("B-").setValue(0)
                self.ref.child("AllCourseGrades").child(AllVariables.courseselected).child("C+").setValue(0)
                self.ref.child("AllCourseGrades").child(AllVariables.courseselected).child("C").setValue(0)
                self.ref.child("AllCourseGrades").child(AllVariables.courseselected).child("C-").setValue(0)
                self.ref.child("AllCourseGrades").child(AllVariables.courseselected).child("D+").setValue(0)
                self.ref.child("AllCourseGrades").child(AllVariables.courseselected).child("D").setValue(0)
                self.ref.child("AllCourseGrades").child(AllVariables.courseselected).child("D-").setValue(0)
                self.ref.child("AllCourseGrades").child(AllVariables.courseselected).child("F").setValue(0)
                
                self.ref.child("AllCourseGrades").child(AllVariables.courseselected).child(AllVariables.Username).setValue("doesntmatterp2")
            }
            else {
                self.ref.child("AllCourseGrades").child(AllVariables.courseselected).observeSingleEvent(of: DataEventType.value, with: { (snapshotB) in
                    
                    let value = snapshotB.value as? NSDictionary
                    let a = value?["A"] as? Int
                    let final = a! + 1
                    print("FINAL = \(final)")
                    if (!(snapshotB.hasChild(AllVariables.Username))) { self.ref.child("AllCourseGrades").child(AllVariables.courseselected).child("A").setValue(final)
                        
                        self.ref.child("AllCourseGrades").child(AllVariables.courseselected).child(AllVariables.Username).setValue("doesntmatterp2")
                    }
                    else {
                        let alert = UIAlertController(title: "Rating Error", message: "You have already rated this course", preferredStyle: .alert)
                        let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
                            print ("ok tappped")
                        }
                        alert.addAction(OKAction)
                        self.present(alert, animated: true) {
                            print("ERROR")
                        }
                        print("error rating in")
                        
                    }
                    
                })
            }
            
        })
    }
    
    func selectAminus()
    {
        
        self.ref.child("AllCourseGrades").observeSingleEvent(of: DataEventType.value, with: { (snapshotA) in
            print("WHAT4")
            if (!(snapshotA.hasChild(AllVariables.courseselected))) {
                self.ref.child("AllCourseGrades").child(AllVariables.courseselected).child("A+").setValue(0)
                self.ref.child("AllCourseGrades").child(AllVariables.courseselected).child("A").setValue(0)
                self.ref.child("AllCourseGrades").child(AllVariables.courseselected).child("A-").setValue(1)
                self.ref.child("AllCourseGrades").child(AllVariables.courseselected).child("B+").setValue(0)
                self.ref.child("AllCourseGrades").child(AllVariables.courseselected).child("B").setValue(0)
                self.ref.child("AllCourseGrades").child(AllVariables.courseselected).child("B-").setValue(0)
                self.ref.child("AllCourseGrades").child(AllVariables.courseselected).child("C+").setValue(0)
                self.ref.child("AllCourseGrades").child(AllVariables.courseselected).child("C").setValue(0)
                self.ref.child("AllCourseGrades").child(AllVariables.courseselected).child("C-").setValue(0)
                self.ref.child("AllCourseGrades").child(AllVariables.courseselected).child("D+").setValue(0)
                self.ref.child("AllCourseGrades").child(AllVariables.courseselected).child("D").setValue(0)
                self.ref.child("AllCourseGrades").child(AllVariables.courseselected).child("D-").setValue(0)
                self.ref.child("AllCourseGrades").child(AllVariables.courseselected).child("F").setValue(0)
                
                self.ref.child("AllCourseGrades").child(AllVariables.courseselected).child(AllVariables.Username).setValue("doesntmatterp2")
            }
            else {
                self.ref.child("AllCourseGrades").child(AllVariables.courseselected).observeSingleEvent(of: DataEventType.value, with: { (snapshotB) in
                    
                    let value = snapshotB.value as? NSDictionary
                    let a = value?["A-"] as? Int
                    let final = a! + 1
                    print("FINAL = \(final)")
                    if (!(snapshotB.hasChild(AllVariables.Username))) { self.ref.child("AllCourseGrades").child(AllVariables.courseselected).child("A-").setValue(final)
                        
                        self.ref.child("AllCourseGrades").child(AllVariables.courseselected).child(AllVariables.Username).setValue("doesntmatterp2")
                    }
                    else {
                        let alert = UIAlertController(title: "Rating Error", message: "You have already rated this course", preferredStyle: .alert)
                        let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
                            print ("ok tappped")
                        }
                        alert.addAction(OKAction)
                        self.present(alert, animated: true) {
                            print("ERROR")
                        }
                        print("error rating in")
                        
                    }
                    
                })
            }
            
        })
    }
    
    func selectBplus()
    {
        
        self.ref.child("AllCourseGrades").observeSingleEvent(of: DataEventType.value, with: { (snapshotA) in
            print("WHAT4")
            if (!(snapshotA.hasChild(AllVariables.courseselected))) {
                self.ref.child("AllCourseGrades").child(AllVariables.courseselected).child("A+").setValue(0)
                self.ref.child("AllCourseGrades").child(AllVariables.courseselected).child("A").setValue(0)
                self.ref.child("AllCourseGrades").child(AllVariables.courseselected).child("A-").setValue(0)
                self.ref.child("AllCourseGrades").child(AllVariables.courseselected).child("B+").setValue(1)
                self.ref.child("AllCourseGrades").child(AllVariables.courseselected).child("B").setValue(0)
                self.ref.child("AllCourseGrades").child(AllVariables.courseselected).child("B-").setValue(0)
                self.ref.child("AllCourseGrades").child(AllVariables.courseselected).child("C+").setValue(0)
                self.ref.child("AllCourseGrades").child(AllVariables.courseselected).child("C").setValue(0)
                self.ref.child("AllCourseGrades").child(AllVariables.courseselected).child("C-").setValue(0)
                self.ref.child("AllCourseGrades").child(AllVariables.courseselected).child("D+").setValue(0)
                self.ref.child("AllCourseGrades").child(AllVariables.courseselected).child("D").setValue(0)
                self.ref.child("AllCourseGrades").child(AllVariables.courseselected).child("D-").setValue(0)
                self.ref.child("AllCourseGrades").child(AllVariables.courseselected).child("F").setValue(0)
                
                self.ref.child("AllCourseGrades").child(AllVariables.courseselected).child(AllVariables.Username).setValue("doesntmatterp2")
            }
            else {
                self.ref.child("AllCourseGrades").child(AllVariables.courseselected).observeSingleEvent(of: DataEventType.value, with: { (snapshotB) in
                    
                    let value = snapshotB.value as? NSDictionary
                    let a = value?["B+"] as? Int
                    let final = a! + 1
                    print("FINAL = \(final)")
                    if (!(snapshotB.hasChild(AllVariables.Username))) { self.ref.child("AllCourseGrades").child(AllVariables.courseselected).child("B+").setValue(final)
                        
                        self.ref.child("AllCourseGrades").child(AllVariables.courseselected).child(AllVariables.Username).setValue("doesntmatterp2")
                    }
                    else {
                        let alert = UIAlertController(title: "Rating Error", message: "You have already rated this course", preferredStyle: .alert)
                        let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
                            print ("ok tappped")
                        }
                        alert.addAction(OKAction)
                        self.present(alert, animated: true) {
                            print("ERROR")
                        }
                        print("error rating in")
                        
                    }
                    
                })
            }
            
        })
    }
    
    func selectB()
    {
        
        self.ref.child("AllCourseGrades").observeSingleEvent(of: DataEventType.value, with: { (snapshotA) in
            print("WHAT4")
            if (!(snapshotA.hasChild(AllVariables.courseselected))) {
                self.ref.child("AllCourseGrades").child(AllVariables.courseselected).child("A+").setValue(0)
                self.ref.child("AllCourseGrades").child(AllVariables.courseselected).child("A").setValue(0)
                self.ref.child("AllCourseGrades").child(AllVariables.courseselected).child("A-").setValue(0)
                self.ref.child("AllCourseGrades").child(AllVariables.courseselected).child("B+").setValue(0)
                self.ref.child("AllCourseGrades").child(AllVariables.courseselected).child("B").setValue(1)
                self.ref.child("AllCourseGrades").child(AllVariables.courseselected).child("B-").setValue(0)
                self.ref.child("AllCourseGrades").child(AllVariables.courseselected).child("C+").setValue(0)
                self.ref.child("AllCourseGrades").child(AllVariables.courseselected).child("C").setValue(0)
                self.ref.child("AllCourseGrades").child(AllVariables.courseselected).child("C-").setValue(0)
                self.ref.child("AllCourseGrades").child(AllVariables.courseselected).child("D+").setValue(0)
                self.ref.child("AllCourseGrades").child(AllVariables.courseselected).child("D").setValue(0)
                self.ref.child("AllCourseGrades").child(AllVariables.courseselected).child("D-").setValue(0)
                self.ref.child("AllCourseGrades").child(AllVariables.courseselected).child("F").setValue(0)
                
                self.ref.child("AllCourseGrades").child(AllVariables.courseselected).child(AllVariables.Username).setValue("doesntmatterp2")
            }
            else {
                self.ref.child("AllCourseGrades").child(AllVariables.courseselected).observeSingleEvent(of: DataEventType.value, with: { (snapshotB) in
                    
                    let value = snapshotB.value as? NSDictionary
                    let a = value?["B"] as? Int
                    let final = a! + 1
                    print("FINAL = \(final)")
                    if (!(snapshotB.hasChild(AllVariables.Username))) { self.ref.child("AllCourseGrades").child(AllVariables.courseselected).child("B").setValue(final)
                        
                        self.ref.child("AllCourseGrades").child(AllVariables.courseselected).child(AllVariables.Username).setValue("doesntmatterp2")
                    }
                    else {
                        let alert = UIAlertController(title: "Rating Error", message: "You have already rated this course", preferredStyle: .alert)
                        let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
                            print ("ok tappped")
                        }
                        alert.addAction(OKAction)
                        self.present(alert, animated: true) {
                            print("ERROR")
                        }
                        print("error rating in")
                        
                    }
                    
                })
            }
            
        })
    }
    
    func selectBminus()
    {
        
        self.ref.child("AllCourseGrades").observeSingleEvent(of: DataEventType.value, with: { (snapshotA) in
            print("WHAT4")
            if (!(snapshotA.hasChild(AllVariables.courseselected))) {
                self.ref.child("AllCourseGrades").child(AllVariables.courseselected).child("A+").setValue(0)
                self.ref.child("AllCourseGrades").child(AllVariables.courseselected).child("A").setValue(0)
                self.ref.child("AllCourseGrades").child(AllVariables.courseselected).child("A-").setValue(0)
                self.ref.child("AllCourseGrades").child(AllVariables.courseselected).child("B+").setValue(0)
                self.ref.child("AllCourseGrades").child(AllVariables.courseselected).child("B").setValue(0)
                self.ref.child("AllCourseGrades").child(AllVariables.courseselected).child("B-").setValue(1)
                self.ref.child("AllCourseGrades").child(AllVariables.courseselected).child("C+").setValue(0)
                self.ref.child("AllCourseGrades").child(AllVariables.courseselected).child("C").setValue(0)
                self.ref.child("AllCourseGrades").child(AllVariables.courseselected).child("C-").setValue(0)
                self.ref.child("AllCourseGrades").child(AllVariables.courseselected).child("D+").setValue(0)
                self.ref.child("AllCourseGrades").child(AllVariables.courseselected).child("D").setValue(0)
                self.ref.child("AllCourseGrades").child(AllVariables.courseselected).child("D-").setValue(0)
                self.ref.child("AllCourseGrades").child(AllVariables.courseselected).child("F").setValue(0)
                
                self.ref.child("AllCourseGrades").child(AllVariables.courseselected).child(AllVariables.Username).setValue("doesntmatterp2")
            }
            else {
                self.ref.child("AllCourseGrades").child(AllVariables.courseselected).observeSingleEvent(of: DataEventType.value, with: { (snapshotB) in
                    
                    let value = snapshotB.value as? NSDictionary
                    let a = value?["B-"] as? Int
                    let final = a! + 1
                    print("FINAL = \(final)")
                    if (!(snapshotB.hasChild(AllVariables.Username))) { self.ref.child("AllCourseGrades").child(AllVariables.courseselected).child("B-").setValue(final)
                        
                        self.ref.child("AllCourseGrades").child(AllVariables.courseselected).child(AllVariables.Username).setValue("doesntmatterp2")
                    }
                    else {
                        let alert = UIAlertController(title: "Rating Error", message: "You have already rated this course", preferredStyle: .alert)
                        let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
                            print ("ok tappped")
                        }
                        alert.addAction(OKAction)
                        self.present(alert, animated: true) {
                            print("ERROR")
                        }
                        print("error rating in")
                        
                    }
                    
                })
            }
            
        })
    }
    
    func selectCplus()
    {
        
        self.ref.child("AllCourseGrades").observeSingleEvent(of: DataEventType.value, with: { (snapshotA) in
            print("WHAT4")
            if (!(snapshotA.hasChild(AllVariables.courseselected))) {
                self.ref.child("AllCourseGrades").child(AllVariables.courseselected).child("A+").setValue(0)
                self.ref.child("AllCourseGrades").child(AllVariables.courseselected).child("A").setValue(0)
                self.ref.child("AllCourseGrades").child(AllVariables.courseselected).child("A-").setValue(0)
                self.ref.child("AllCourseGrades").child(AllVariables.courseselected).child("B+").setValue(0)
                self.ref.child("AllCourseGrades").child(AllVariables.courseselected).child("B").setValue(0)
                self.ref.child("AllCourseGrades").child(AllVariables.courseselected).child("B-").setValue(0)
                self.ref.child("AllCourseGrades").child(AllVariables.courseselected).child("C+").setValue(1)
                self.ref.child("AllCourseGrades").child(AllVariables.courseselected).child("C").setValue(0)
                self.ref.child("AllCourseGrades").child(AllVariables.courseselected).child("C-").setValue(0)
                self.ref.child("AllCourseGrades").child(AllVariables.courseselected).child("D+").setValue(0)
                self.ref.child("AllCourseGrades").child(AllVariables.courseselected).child("D").setValue(0)
                self.ref.child("AllCourseGrades").child(AllVariables.courseselected).child("D-").setValue(0)
                self.ref.child("AllCourseGrades").child(AllVariables.courseselected).child("F").setValue(0)
                
                self.ref.child("AllCourseGrades").child(AllVariables.courseselected).child(AllVariables.Username).setValue("doesntmatterp2")
            }
            else {
                self.ref.child("AllCourseGrades").child(AllVariables.courseselected).observeSingleEvent(of: DataEventType.value, with: { (snapshotB) in
                    
                    let value = snapshotB.value as? NSDictionary
                    let a = value?["C+"] as? Int
                    let final = a! + 1
                    print("FINAL = \(final)")
                    if (!(snapshotB.hasChild(AllVariables.Username))) { self.ref.child("AllCourseGrades").child(AllVariables.courseselected).child("C+").setValue(final)
                        
                        self.ref.child("AllCourseGrades").child(AllVariables.courseselected).child(AllVariables.Username).setValue("doesntmatterp2")
                    }
                    else {
                        let alert = UIAlertController(title: "Rating Error", message: "You have already rated this course", preferredStyle: .alert)
                        let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
                            print ("ok tappped")
                        }
                        alert.addAction(OKAction)
                        self.present(alert, animated: true) {
                            print("ERROR")
                        }
                        print("error rating in")
                        
                    }
                    
                })
            }
            
        })
    }
    
    func selectC()
    {
        
        self.ref.child("AllCourseGrades").observeSingleEvent(of: DataEventType.value, with: { (snapshotA) in
            print("WHAT4")
            if (!(snapshotA.hasChild(AllVariables.courseselected))) {
                self.ref.child("AllCourseGrades").child(AllVariables.courseselected).child("A+").setValue(0)
                self.ref.child("AllCourseGrades").child(AllVariables.courseselected).child("A").setValue(0)
                self.ref.child("AllCourseGrades").child(AllVariables.courseselected).child("A-").setValue(0)
                self.ref.child("AllCourseGrades").child(AllVariables.courseselected).child("B+").setValue(0)
                self.ref.child("AllCourseGrades").child(AllVariables.courseselected).child("B").setValue(0)
                self.ref.child("AllCourseGrades").child(AllVariables.courseselected).child("B-").setValue(0)
                self.ref.child("AllCourseGrades").child(AllVariables.courseselected).child("C+").setValue(0)
                self.ref.child("AllCourseGrades").child(AllVariables.courseselected).child("C").setValue(1)
                self.ref.child("AllCourseGrades").child(AllVariables.courseselected).child("C-").setValue(0)
                self.ref.child("AllCourseGrades").child(AllVariables.courseselected).child("D+").setValue(0)
                self.ref.child("AllCourseGrades").child(AllVariables.courseselected).child("D").setValue(0)
                self.ref.child("AllCourseGrades").child(AllVariables.courseselected).child("D-").setValue(0)
                self.ref.child("AllCourseGrades").child(AllVariables.courseselected).child("F").setValue(0)
                
                self.ref.child("AllCourseGrades").child(AllVariables.courseselected).child(AllVariables.Username).setValue("doesntmatterp2")
            }
            else {
                self.ref.child("AllCourseGrades").child(AllVariables.courseselected).observeSingleEvent(of: DataEventType.value, with: { (snapshotB) in
                    
                    let value = snapshotB.value as? NSDictionary
                    let a = value?["C"] as? Int
                    let final = a! + 1
                    print("FINAL = \(final)")
                    if (!(snapshotB.hasChild(AllVariables.Username))) { self.ref.child("AllCourseGrades").child(AllVariables.courseselected).child("C").setValue(final)
                        
                        self.ref.child("AllCourseGrades").child(AllVariables.courseselected).child(AllVariables.Username).setValue("doesntmatterp2")
                    }
                    else {
                        let alert = UIAlertController(title: "Rating Error", message: "You have already rated this course", preferredStyle: .alert)
                        let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
                            print ("ok tappped")
                        }
                        alert.addAction(OKAction)
                        self.present(alert, animated: true) {
                            print("ERROR")
                        }
                        print("error rating in")
                        
                    }
                    
                })
            }
            
        })
    }
    
    func selectCminus()
    {
        
        self.ref.child("AllCourseGrades").observeSingleEvent(of: DataEventType.value, with: { (snapshotA) in
            print("WHAT4")
            if (!(snapshotA.hasChild(AllVariables.courseselected))) {
                self.ref.child("AllCourseGrades").child(AllVariables.courseselected).child("A+").setValue(0)
                self.ref.child("AllCourseGrades").child(AllVariables.courseselected).child("A").setValue(0)
                self.ref.child("AllCourseGrades").child(AllVariables.courseselected).child("A-").setValue(0)
                self.ref.child("AllCourseGrades").child(AllVariables.courseselected).child("B+").setValue(0)
                self.ref.child("AllCourseGrades").child(AllVariables.courseselected).child("B").setValue(0)
                self.ref.child("AllCourseGrades").child(AllVariables.courseselected).child("B-").setValue(0)
                self.ref.child("AllCourseGrades").child(AllVariables.courseselected).child("C+").setValue(0)
                self.ref.child("AllCourseGrades").child(AllVariables.courseselected).child("C").setValue(0)
                self.ref.child("AllCourseGrades").child(AllVariables.courseselected).child("C-").setValue(1)
                self.ref.child("AllCourseGrades").child(AllVariables.courseselected).child("D+").setValue(0)
                self.ref.child("AllCourseGrades").child(AllVariables.courseselected).child("D").setValue(0)
                self.ref.child("AllCourseGrades").child(AllVariables.courseselected).child("D-").setValue(0)
                self.ref.child("AllCourseGrades").child(AllVariables.courseselected).child("F").setValue(0)
                
                self.ref.child("AllCourseGrades").child(AllVariables.courseselected).child(AllVariables.Username).setValue("doesntmatterp2")
            }
            else {
                self.ref.child("AllCourseGrades").child(AllVariables.courseselected).observeSingleEvent(of: DataEventType.value, with: { (snapshotB) in
                    
                    let value = snapshotB.value as? NSDictionary
                    let a = value?["C-"] as? Int
                    let final = a! + 1
                    print("FINAL = \(final)")
                    if (!(snapshotB.hasChild(AllVariables.Username))) { self.ref.child("AllCourseGrades").child(AllVariables.courseselected).child("C-").setValue(final)
                        
                        self.ref.child("AllCourseGrades").child(AllVariables.courseselected).child(AllVariables.Username).setValue("doesntmatterp2")
                    }
                    else {
                        let alert = UIAlertController(title: "Rating Error", message: "You have already rated this course", preferredStyle: .alert)
                        let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
                            print ("ok tappped")
                        }
                        alert.addAction(OKAction)
                        self.present(alert, animated: true) {
                            print("ERROR")
                        }
                        print("error rating in")
                        
                    }
                    
                })
            }
            
        })
    }
    
    func selectDplus()
    {
        
        self.ref.child("AllCourseGrades").observeSingleEvent(of: DataEventType.value, with: { (snapshotA) in
            print("WHAT4")
            if (!(snapshotA.hasChild(AllVariables.courseselected))) {
                self.ref.child("AllCourseGrades").child(AllVariables.courseselected).child("A+").setValue(0)
                self.ref.child("AllCourseGrades").child(AllVariables.courseselected).child("A").setValue(0)
                self.ref.child("AllCourseGrades").child(AllVariables.courseselected).child("A-").setValue(0)
                self.ref.child("AllCourseGrades").child(AllVariables.courseselected).child("B+").setValue(0)
                self.ref.child("AllCourseGrades").child(AllVariables.courseselected).child("B").setValue(0)
                self.ref.child("AllCourseGrades").child(AllVariables.courseselected).child("B-").setValue(0)
                self.ref.child("AllCourseGrades").child(AllVariables.courseselected).child("C+").setValue(0)
                self.ref.child("AllCourseGrades").child(AllVariables.courseselected).child("C").setValue(0)
                self.ref.child("AllCourseGrades").child(AllVariables.courseselected).child("C-").setValue(0)
                self.ref.child("AllCourseGrades").child(AllVariables.courseselected).child("D+").setValue(1)
                self.ref.child("AllCourseGrades").child(AllVariables.courseselected).child("D").setValue(0)
                self.ref.child("AllCourseGrades").child(AllVariables.courseselected).child("D-").setValue(0)
                self.ref.child("AllCourseGrades").child(AllVariables.courseselected).child("F").setValue(0)
                
                self.ref.child("AllCourseGrades").child(AllVariables.courseselected).child(AllVariables.Username).setValue("doesntmatterp2")
            }
            else {
                self.ref.child("AllCourseGrades").child(AllVariables.courseselected).observeSingleEvent(of: DataEventType.value, with: { (snapshotB) in
                    
                    let value = snapshotB.value as? NSDictionary
                    let a = value?["D+"] as? Int
                    let final = a! + 1
                    print("FINAL = \(final)")
                    if (!(snapshotB.hasChild(AllVariables.Username))) { self.ref.child("AllCourseGrades").child(AllVariables.courseselected).child("D+").setValue(final)
                        
                        self.ref.child("AllCourseGrades").child(AllVariables.courseselected).child(AllVariables.Username).setValue("doesntmatterp2")
                    }
                    else {
                        let alert = UIAlertController(title: "Rating Error", message: "You have already rated this course", preferredStyle: .alert)
                        let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
                            print ("ok tappped")
                        }
                        alert.addAction(OKAction)
                        self.present(alert, animated: true) {
                            print("ERROR")
                        }
                        print("error rating in")
                        
                    }
                    
                })
            }
            
        })
    }
    
    func selectD()
    {
        
        self.ref.child("AllCourseGrades").observeSingleEvent(of: DataEventType.value, with: { (snapshotA) in
            print("WHAT4")
            if (!(snapshotA.hasChild(AllVariables.courseselected))) {
                self.ref.child("AllCourseGrades").child(AllVariables.courseselected).child("A+").setValue(0)
                self.ref.child("AllCourseGrades").child(AllVariables.courseselected).child("A").setValue(0)
                self.ref.child("AllCourseGrades").child(AllVariables.courseselected).child("A-").setValue(0)
                self.ref.child("AllCourseGrades").child(AllVariables.courseselected).child("B+").setValue(0)
                self.ref.child("AllCourseGrades").child(AllVariables.courseselected).child("B").setValue(0)
                self.ref.child("AllCourseGrades").child(AllVariables.courseselected).child("B-").setValue(0)
                self.ref.child("AllCourseGrades").child(AllVariables.courseselected).child("C+").setValue(0)
                self.ref.child("AllCourseGrades").child(AllVariables.courseselected).child("C").setValue(0)
                self.ref.child("AllCourseGrades").child(AllVariables.courseselected).child("C-").setValue(0)
                self.ref.child("AllCourseGrades").child(AllVariables.courseselected).child("D+").setValue(0)
                self.ref.child("AllCourseGrades").child(AllVariables.courseselected).child("D").setValue(1)
                self.ref.child("AllCourseGrades").child(AllVariables.courseselected).child("D-").setValue(0)
                self.ref.child("AllCourseGrades").child(AllVariables.courseselected).child("F").setValue(0)
                
                self.ref.child("AllCourseGrades").child(AllVariables.courseselected).child(AllVariables.Username).setValue("doesntmatterp2")
            }
            else {
                self.ref.child("AllCourseGrades").child(AllVariables.courseselected).observeSingleEvent(of: DataEventType.value, with: { (snapshotB) in
                    
                    let value = snapshotB.value as? NSDictionary
                    let a = value?["D"] as? Int
                    let final = a! + 1
                    print("FINAL = \(final)")
                    if (!(snapshotB.hasChild(AllVariables.Username))) { self.ref.child("AllCourseGrades").child(AllVariables.courseselected).child("D").setValue(final)
                        
                        self.ref.child("AllCourseGrades").child(AllVariables.courseselected).child(AllVariables.Username).setValue("doesntmatterp2")
                    }
                    else {
                        let alert = UIAlertController(title: "Rating Error", message: "You have already rated this course", preferredStyle: .alert)
                        let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
                            print ("ok tappped")
                        }
                        alert.addAction(OKAction)
                        self.present(alert, animated: true) {
                            print("ERROR")
                        }
                        print("error rating in")
                        
                    }
                    
                })
            }
            
        })
    }
    
    func selectDminus()
    {
        
        self.ref.child("AllCourseGrades").observeSingleEvent(of: DataEventType.value, with: { (snapshotA) in
            print("WHAT4")
            if (!(snapshotA.hasChild(AllVariables.courseselected))) {
                self.ref.child("AllCourseGrades").child(AllVariables.courseselected).child("A+").setValue(0)
                self.ref.child("AllCourseGrades").child(AllVariables.courseselected).child("A").setValue(0)
                self.ref.child("AllCourseGrades").child(AllVariables.courseselected).child("A-").setValue(0)
                self.ref.child("AllCourseGrades").child(AllVariables.courseselected).child("B+").setValue(0)
                self.ref.child("AllCourseGrades").child(AllVariables.courseselected).child("B").setValue(0)
                self.ref.child("AllCourseGrades").child(AllVariables.courseselected).child("B-").setValue(0)
                self.ref.child("AllCourseGrades").child(AllVariables.courseselected).child("C+").setValue(0)
                self.ref.child("AllCourseGrades").child(AllVariables.courseselected).child("C").setValue(0)
                self.ref.child("AllCourseGrades").child(AllVariables.courseselected).child("C-").setValue(0)
                self.ref.child("AllCourseGrades").child(AllVariables.courseselected).child("D+").setValue(0)
                self.ref.child("AllCourseGrades").child(AllVariables.courseselected).child("D").setValue(0)
                self.ref.child("AllCourseGrades").child(AllVariables.courseselected).child("D-").setValue(1)
                self.ref.child("AllCourseGrades").child(AllVariables.courseselected).child("F").setValue(0)
                
                self.ref.child("AllCourseGrades").child(AllVariables.courseselected).child(AllVariables.Username).setValue("doesntmatterp2")
            }
            else {
                self.ref.child("AllCourseGrades").child(AllVariables.courseselected).observeSingleEvent(of: DataEventType.value, with: { (snapshotB) in
                    
                    let value = snapshotB.value as? NSDictionary
                    let a = value?["D-"] as? Int
                    let final = a! + 1
                    print("FINAL = \(final)")
                    if (!(snapshotB.hasChild(AllVariables.Username))) { self.ref.child("AllCourseGrades").child(AllVariables.courseselected).child("D-").setValue(final)
                        
                        self.ref.child("AllCourseGrades").child(AllVariables.courseselected).child(AllVariables.Username).setValue("doesntmatterp2")
                    }
                    else {
                        let alert = UIAlertController(title: "Rating Error", message: "You have already rated this course", preferredStyle: .alert)
                        let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
                            print ("ok tappped")
                        }
                        alert.addAction(OKAction)
                        self.present(alert, animated: true) {
                            print("ERROR")
                        }
                        print("error rating in")
                        
                    }
                    
                })
            }
            
        })
    }
    
    func selectF()
    {
        
        self.ref.child("AllCourseGrades").observeSingleEvent(of: DataEventType.value, with: { (snapshotA) in
            print("WHAT4")
            if (!(snapshotA.hasChild(AllVariables.courseselected))) {
                self.ref.child("AllCourseGrades").child(AllVariables.courseselected).child("A+").setValue(0)
                self.ref.child("AllCourseGrades").child(AllVariables.courseselected).child("A").setValue(0)
                self.ref.child("AllCourseGrades").child(AllVariables.courseselected).child("A-").setValue(0)
                self.ref.child("AllCourseGrades").child(AllVariables.courseselected).child("B+").setValue(0)
                self.ref.child("AllCourseGrades").child(AllVariables.courseselected).child("B").setValue(0)
                self.ref.child("AllCourseGrades").child(AllVariables.courseselected).child("B-").setValue(0)
                self.ref.child("AllCourseGrades").child(AllVariables.courseselected).child("C+").setValue(0)
                self.ref.child("AllCourseGrades").child(AllVariables.courseselected).child("C").setValue(0)
                self.ref.child("AllCourseGrades").child(AllVariables.courseselected).child("C-").setValue(0)
                self.ref.child("AllCourseGrades").child(AllVariables.courseselected).child("D+").setValue(0)
                self.ref.child("AllCourseGrades").child(AllVariables.courseselected).child("D").setValue(0)
                self.ref.child("AllCourseGrades").child(AllVariables.courseselected).child("D-").setValue(0)
                self.ref.child("AllCourseGrades").child(AllVariables.courseselected).child("F").setValue(1)
                
                self.ref.child("AllCourseGrades").child(AllVariables.courseselected).child(AllVariables.Username).setValue("doesntmatterp2")
            }
            else {
                self.ref.child("AllCourseGrades").child(AllVariables.courseselected).observeSingleEvent(of: DataEventType.value, with: { (snapshotB) in
                    
                    let value = snapshotB.value as? NSDictionary
                    let a = value?["F"] as? Int
                    let final = a! + 1
                    print("FINAL = \(final)")
                    if (!(snapshotB.hasChild(AllVariables.Username))) { self.ref.child("AllCourseGrades").child(AllVariables.courseselected).child("F").setValue(final)
                        
                        self.ref.child("AllCourseGrades").child(AllVariables.courseselected).child(AllVariables.Username).setValue("doesntmatterp2")
                    }
                    else {
                        let alert = UIAlertController(title: "Rating Error", message: "You have already rated this course", preferredStyle: .alert)
                        let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
                            print ("ok tappped")
                        }
                        alert.addAction(OKAction)
                        self.present(alert, animated: true) {
                            print("ERROR")
                        }
                        print("error rating in")
                        
                    }
                    
                })
            }
            
        })
    }
    
    
    

    
    func reviewOne()
    {
        
        self.ref.child("ExamReviews").observeSingleEvent(of: DataEventType.value, with: { (snapshotA) in
            print("WHAT4")
            if (!(snapshotA.hasChild(AllVariables.courseselected))) {
                self.ref.child("ExamReviews").child(AllVariables.courseselected).child("Diff1").setValue(1)
                
                self.ref.child("ExamReviews").child(AllVariables.courseselected).child("Diff2").setValue(0)
                
                self.ref.child("ExamReviews").child(AllVariables.courseselected).child("Diff3").setValue(0)
                
                self.ref.child("ExamReviews").child(AllVariables.courseselected).child("Diff4").setValue(0)
                self.ref.child("ExamReviews").child(AllVariables.courseselected).child("Diff5").setValue(0)
                
                self.ref.child("ExamReviews").child(AllVariables.courseselected).child(AllVariables.Username).setValue("doesntmatterp2")
            }
            else {
                self.ref.child("ExamReviews").child(AllVariables.courseselected).observeSingleEvent(of: DataEventType.value, with: { (snapshotB) in
                    
                    let value = snapshotB.value as? NSDictionary
                    let a = value?["Diff1"] as? Int
                    let final = a! + 1
                    print("FINAL = \(final)")
                    if (!(snapshotB.hasChild(AllVariables.Username))) { self.ref.child("ExamReviews").child(AllVariables.courseselected).child("Diff1").setValue(final)
                        
                        self.ref.child("ExamReviews").child(AllVariables.courseselected).child(AllVariables.Username).setValue("doesntmatterp2")
                    }
                    else {
                        let alert = UIAlertController(title: "Rating Error", message: "You have already rated this course", preferredStyle: .alert)
                        let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
                            print ("ok tappped")
                        }
                        alert.addAction(OKAction)
                        self.present(alert, animated: true) {
                            print("ERROR")
                        }
                        print("error rating in")
                        
                    }
                    
                })
            }
           
        })
    }
    
    func reviewTwo()
    {
        
        self.ref.child("ExamReviews").observeSingleEvent(of: DataEventType.value, with: { (snapshotA) in
            print("WHAT4")
            if (!(snapshotA.hasChild(AllVariables.courseselected))) {
                self.ref.child("ExamReviews").child(AllVariables.courseselected).child("Diff2").setValue(1)
                
                self.ref.child("ExamReviews").child(AllVariables.courseselected).child("Diff1").setValue(0)
                
                self.ref.child("ExamReviews").child(AllVariables.courseselected).child("Diff3").setValue(0)
                
                self.ref.child("ExamReviews").child(AllVariables.courseselected).child("Diff4").setValue(0)
                self.ref.child("ExamReviews").child(AllVariables.courseselected).child("Diff5").setValue(0)
                
                self.ref.child("ExamReviews").child(AllVariables.courseselected).child(AllVariables.Username).setValue("doesntmatterp2")
            }
            else {
                self.ref.child("ExamReviews").child(AllVariables.courseselected).observeSingleEvent(of: DataEventType.value, with: { (snapshotB) in
                    
                    let value = snapshotB.value as? NSDictionary
                    let a = value?["Diff2"] as? Int
                    let final = a! + 1
                    print("FINAL = \(final)")
                    if (!(snapshotB.hasChild(AllVariables.Username))) { self.ref.child("ExamReviews").child(AllVariables.courseselected).child("Diff2").setValue(final)
                        
                        self.ref.child("ExamReviews").child(AllVariables.courseselected).child(AllVariables.Username).setValue("doesntmatterp2")
                    }
                    else {
                        let alert = UIAlertController(title: "Rating Error", message: "You have already rated this course", preferredStyle: .alert)
                        let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
                            print ("ok tappped")
                        }
                        alert.addAction(OKAction)
                        self.present(alert, animated: true) {
                            print("ERROR")
                        }
                        print("error rating in")
                        
                    }
                    
                })
            }
            
        })
    }
    
    func reviewThree()
    {
        
        self.ref.child("ExamReviews").observeSingleEvent(of: DataEventType.value, with: { (snapshotA) in
            print("WHAT4")
            if (!(snapshotA.hasChild(AllVariables.courseselected))) {
                self.ref.child("ExamReviews").child(AllVariables.courseselected).child("Diff3").setValue(1)
                
                self.ref.child("ExamReviews").child(AllVariables.courseselected).child("Diff2").setValue(0)
                
                self.ref.child("ExamReviews").child(AllVariables.courseselected).child("Diff1").setValue(0)
                
                self.ref.child("ExamReviews").child(AllVariables.courseselected).child("Diff4").setValue(0)
                self.ref.child("ExamReviews").child(AllVariables.courseselected).child("Diff5").setValue(0)
                
                self.ref.child("ExamReviews").child(AllVariables.courseselected).child(AllVariables.Username).setValue("doesntmatterp2")
            }
            else {
                self.ref.child("ExamReviews").child(AllVariables.courseselected).observeSingleEvent(of: DataEventType.value, with: { (snapshotB) in
                    
                    let value = snapshotB.value as? NSDictionary
                    let a = value?["Diff3"] as? Int
                    let final = a! + 1
                    print("FINAL = \(final)")
                    if (!(snapshotB.hasChild(AllVariables.Username))) { self.ref.child("ExamReviews").child(AllVariables.courseselected).child("Diff3").setValue(final)
                        
                        self.ref.child("ExamReviews").child(AllVariables.courseselected).child(AllVariables.Username).setValue("doesntmatterp2")
                    }
                    else {
                        let alert = UIAlertController(title: "Rating Error", message: "You have already rated this course", preferredStyle: .alert)
                        let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
                            print ("ok tappped")
                        }
                        alert.addAction(OKAction)
                        self.present(alert, animated: true) {
                            print("ERROR")
                        }
                        print("error rating in")
                        
                    }
                    
                })
            }
            
        })
    }
    
    func reviewFour()
    {
        
        self.ref.child("ExamReviews").observeSingleEvent(of: DataEventType.value, with: { (snapshotA) in
            print("WHAT4")
            if (!(snapshotA.hasChild(AllVariables.courseselected))) {
                self.ref.child("ExamReviews").child(AllVariables.courseselected).child("Diff4").setValue(1)
                
                self.ref.child("ExamReviews").child(AllVariables.courseselected).child("Diff2").setValue(0)
                
                self.ref.child("ExamReviews").child(AllVariables.courseselected).child("Diff3").setValue(0)
                
                self.ref.child("ExamReviews").child(AllVariables.courseselected).child("Diff1").setValue(0)
                self.ref.child("ExamReviews").child(AllVariables.courseselected).child("Diff5").setValue(0)
                
                self.ref.child("ExamReviews").child(AllVariables.courseselected).child(AllVariables.Username).setValue("doesntmatterp2")
            }
            else {
                self.ref.child("ExamReviews").child(AllVariables.courseselected).observeSingleEvent(of: DataEventType.value, with: { (snapshotB) in
                    
                    let value = snapshotB.value as? NSDictionary
                    let a = value?["Diff4"] as? Int
                    let final = a! + 1
                    print("FINAL = \(final)")
                    if (!(snapshotB.hasChild(AllVariables.Username))) { self.ref.child("ExamReviews").child(AllVariables.courseselected).child("Diff4").setValue(final)
                        
                        self.ref.child("ExamReviews").child(AllVariables.courseselected).child(AllVariables.Username).setValue("doesntmatterp2")
                    }
                    else {
                        let alert = UIAlertController(title: "Rating Error", message: "You have already rated this course", preferredStyle: .alert)
                        let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
                            print ("ok tappped")
                        }
                        alert.addAction(OKAction)
                        self.present(alert, animated: true) {
                            print("ERROR")
                        }
                        print("error rating in")
                        
                    }
                    
                })
            }
            
        })
    }
    
    func reviewFive()
    {
        
        self.ref.child("ExamReviews").observeSingleEvent(of: DataEventType.value, with: { (snapshotA) in
            print("WHAT4")
            if (!(snapshotA.hasChild(AllVariables.courseselected))) {
                self.ref.child("ExamReviews").child(AllVariables.courseselected).child("Diff5").setValue(1)
                
                self.ref.child("ExamReviews").child(AllVariables.courseselected).child("Diff2").setValue(0)
                
                self.ref.child("ExamReviews").child(AllVariables.courseselected).child("Diff3").setValue(0)
                
                self.ref.child("ExamReviews").child(AllVariables.courseselected).child("Diff4").setValue(0)
                self.ref.child("ExamReviews").child(AllVariables.courseselected).child("Diff1").setValue(0)
                
                self.ref.child("ExamReviews").child(AllVariables.courseselected).child(AllVariables.Username).setValue("doesntmatterp2")
            }
            else {
                self.ref.child("ExamReviews").child(AllVariables.courseselected).observeSingleEvent(of: DataEventType.value, with: { (snapshotB) in
                    
                    let value = snapshotB.value as? NSDictionary
                    let a = value?["Diff5"] as? Int
                    let final = a! + 1
                    print("FINAL = \(final)")
                    if (!(snapshotB.hasChild(AllVariables.Username))) { self.ref.child("ExamReviews").child(AllVariables.courseselected).child("Diff5").setValue(final)
                        
                        self.ref.child("ExamReviews").child(AllVariables.courseselected).child(AllVariables.Username).setValue("doesntmatterp2")
                    }
                    else {
                        let alert = UIAlertController(title: "Rating Error", message: "You have already rated this course", preferredStyle: .alert)
                        let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
                            print ("ok tappped")
                        }
                        alert.addAction(OKAction)
                        self.present(alert, animated: true) {
                            print("ERROR")
                        }
                        print("error rating in")
                        
                    }
                    
                })
            }
            
        })
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
                
                self.ref.child("CourseReviews").child(AllVariables.courseselected).child(AllVariables.Username).setValue("doesntmatterp2")
            }
            else {
                self.ref.child("CourseReviews").child(AllVariables.courseselected).observeSingleEvent(of: DataEventType.value, with: { (snapshotB) in
                    let value = snapshotB.value as? NSDictionary
                    let a = value?["1stars"] as? Int
                    let final = a! + 1
                    print("FINAL = \(final)")
                    if (!(snapshotB.hasChild(AllVariables.Username))) { self.ref.child("CourseReviews").child(AllVariables.courseselected).child("1stars").setValue(final)
                        
                        self.ref.child("CourseReviews").child(AllVariables.courseselected).child(AllVariables.Username).setValue("doesntmatterp2")
                    }
                    else {
                        let alert = UIAlertController(title: "Rating Error", message: "You have already rated this course", preferredStyle: .alert)
                        let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
                            print ("ok tappped")
                        }
                        alert.addAction(OKAction)
                        self.present(alert, animated: true) {
                            print("ERROR")
                        }
                        print("error rating in")
                        
                    }
                    
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
                
                self.ref.child("CourseReviews").child(AllVariables.courseselected).child(AllVariables.Username).setValue("doesntmatterp2")
            }
            else {
                self.ref.child("CourseReviews").child(AllVariables.courseselected).observeSingleEvent(of: DataEventType.value, with: { (snapshotB) in
                    
                    let value = snapshotB.value as? NSDictionary
                    let a = value?["2stars"] as? Int
                    let final = a! + 1
                    print("FINAL = \(final)")
                    if (!(snapshotB.hasChild(AllVariables.Username))) { self.ref.child("CourseReviews").child(AllVariables.courseselected).child("2stars").setValue(final)
                        
                        self.ref.child("CourseReviews").child(AllVariables.courseselected).child(AllVariables.Username).setValue("doesntmatterp2")
                    }
                    else {
                        let alert = UIAlertController(title: "Rating Error", message: "You have already rated this course", preferredStyle: .alert)
                        let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
                            print ("ok tappped")
                        }
                        alert.addAction(OKAction)
                        self.present(alert, animated: true) {
                            print("ERROR")
                        }
                        print("error rating in")
                        
                    }
                    
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
                
                self.ref.child("CourseReviews").child(AllVariables.courseselected).child(AllVariables.Username).setValue("doesntmatterp2")
            }
            else {
                self.ref.child("CourseReviews").child(AllVariables.courseselected).observeSingleEvent(of: DataEventType.value, with: { (snapshotB) in
                    
                    let value = snapshotB.value as? NSDictionary
                    let a = value?["3stars"] as? Int
                    let final = a! + 1
                    print("FINAL = \(final)")
                    if (!(snapshotB.hasChild(AllVariables.Username))) { self.ref.child("CourseReviews").child(AllVariables.courseselected).child("3stars").setValue(final)
                        
                        self.ref.child("CourseReviews").child(AllVariables.courseselected).child(AllVariables.Username).setValue("doesntmatterp2")
                    }
                    else {
                        let alert = UIAlertController(title: "Rating Error", message: "You have already rated this course", preferredStyle: .alert)
                        let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
                            print ("ok tappped")
                        }
                        alert.addAction(OKAction)
                        self.present(alert, animated: true) {
                            print("ERROR")
                        }
                        print("error rating in")
                        
                    }
                    
                    
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
                
                self.ref.child("CourseReviews").child(AllVariables.courseselected).child(AllVariables.Username).setValue("doesntmatterp2")
            }
            else {
                self.ref.child("CourseReviews").child(AllVariables.courseselected).observeSingleEvent(of: DataEventType.value, with: { (snapshotB) in
                    
                    
                    
                    let value = snapshotB.value as? NSDictionary
                    let a = value?["4stars"] as? Int
                    let final = a! + 1
                    print("FINAL = \(final)")
                    if (!(snapshotB.hasChild(AllVariables.Username))) { self.ref.child("CourseReviews").child(AllVariables.courseselected).child("4stars").setValue(final)
                        
                        self.ref.child("CourseReviews").child(AllVariables.courseselected).child(AllVariables.Username).setValue("doesntmatterp2")
                    }
                    else {
                        let alert = UIAlertController(title: "Rating Error", message: "You have already rated this course", preferredStyle: .alert)
                        let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
                            print ("ok tappped")
                        }
                        alert.addAction(OKAction)
                        self.present(alert, animated: true) {
                            print("ERROR")
                        }
                        print("error rating in")
                        
                    }
                    
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
                
                self.ref.child("CourseReviews").child(AllVariables.courseselected).child(AllVariables.Username).setValue("doesntmatterp2")
            }
            else {
                self.ref.child("CourseReviews").child(AllVariables.courseselected).observeSingleEvent(of: DataEventType.value, with: { (snapshotB) in
                    
                    if (!(snapshotB.hasChild(AllVariables.Username))) {
                        let value = snapshotB.value as? NSDictionary
                        let a = value?["5stars"] as? Int
                        let final = a! + 1
                        print("FINAL = \(final)")
                        self.ref.child("CourseReviews").child(AllVariables.courseselected).child("5stars").setValue(final)
                        
                        self.ref.child("CourseReviews").child(AllVariables.courseselected).child(AllVariables.Username).setValue("doesntmatterp2")
                    }
                    else {
                        let alert = UIAlertController(title: "Rating Error", message: "You have already rated this course", preferredStyle: .alert)
                        let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
                            print ("ok tappped")
                        }
                        alert.addAction(OKAction)
                        self.present(alert, animated: true) {
                            print("ERROR")
                        }
                        print("error rating in")
                        
                    }
                })
            }
        })
        
    }
    

    
    
    
    
}

