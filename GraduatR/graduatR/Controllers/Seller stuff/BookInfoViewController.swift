//
//  BookInfoViewController.swift
//  graduatR
//
//  Created by Dhriti Chawla on 3/8/18.
//  Copyright © 2018 Simona Virga. All rights reserved.
//

import UIKit
import Firebase

class BookInfoViewController: UIViewController {
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var authorField: UITextField!
    @IBOutlet weak var courseTitle: UITextField!
    @IBOutlet weak var priceField: UITextField!
    var ref: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
            ref = Database.database().reference()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func goBack(_ sender: Any) {
        var a = 0
        Database.database().reference().child("Sellers").observeSingleEvent(of: DataEventType.value, with: { (s) in
            let val = s.value as? NSDictionary
            a = Int(s.childrenCount)
            let c = "Book\(a)"
            print("dasdadadasdadsadasda")
            print(c)
            if (self.titleField.text != "") {
                if (self.authorField.text != "") {
                    if (self.courseTitle.text != "") {
                        if (self.priceField.text != "") {
                            AllVariables.books.append(self.titleField.text!)
                            self.ref.child("Sellers").child(c).setValue(["UID": AllVariables.uid, "Username": AllVariables.Username, "Title": self.titleField.text!, "Author": self.authorField.text!, "Course": self.courseTitle.text!, "Price": self.priceField.text!])
                        }
                        else {
                            let alert = UIAlertController(title: "Error", message: "Please provide a title!", preferredStyle: .alert)
                            let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
                                print ("ok tappped")
                            }
                            alert.addAction(OKAction)
                            self.present(alert, animated: true) {
                                print("ERROR")
                            }
                        }
                    }
                    else {
                        let alert = UIAlertController(title: "Error", message: "Please provide author name!", preferredStyle: .alert)
                        let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
                            print ("ok tappped")
                        }
                        alert.addAction(OKAction)
                        self.present(alert, animated: true) {
                            print("ERROR")
                        }
                    }
                }
                else {
                    let alert = UIAlertController(title: "Error", message: "Please provide course name!", preferredStyle: .alert)
                    let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
                        print ("ok tappped")
                    }
                    alert.addAction(OKAction)
                    self.present(alert, animated: true) {
                        print("ERROR")
                    }
                }
            }
            else {
                let alert = UIAlertController(title: "Error", message: "Please provide price!", preferredStyle: .alert)
                let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
                    print ("ok tappped")
                }
                alert.addAction(OKAction)
                self.present(alert, animated: true) {
                    print("ERROR")
                }
            }
            
            //self.dismiss(animated: true, completion: nil)
            self.navigationController?.popViewController(animated: true)
            
        })
            
        
}
}
