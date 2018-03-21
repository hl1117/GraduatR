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
        if (!AllVariables.books.contains(titleField.text!)) {
            let c = "Book\(AllVariables.books.endIndex)"
            print(AllVariables.books.endIndex)
            print(",,,,,,,")
            
        if (titleField.text != "") {
            if (authorField.text != "") {
                if (courseTitle.text != "") {
                    if (priceField.text != "") {
                        AllVariables.books.append(titleField.text!)
                        ref.child("Sellers").child(c).setValue(["Username": AllVariables.Username, "Title": titleField.text!, "Author": authorField.text!, "Course": courseTitle.text!, "Price": priceField.text!])
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
    }
        else {
            
            let alert = UIAlertController(title: "Error", message: "You are already selling this book!", preferredStyle: .alert)
            let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
                print ("ok tappped")
            }
            alert.addAction(OKAction)
            self.present(alert, animated: true) {
                print("ERROR")
        }
    }
        self.dismiss(animated: true, completion: nil)
        
    
}
}
