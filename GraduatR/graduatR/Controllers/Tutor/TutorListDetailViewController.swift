//
//  TutorListDetailViewController.swift
//  graduatR
//
//  Created by Dhriti Chawla on 3/22/18.
//  Copyright © 2018 Simona Virga. All rights reserved.
//

import UIKit
import Firebase

class TutorListDetailViewController: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var bio: UILabel!
    @IBOutlet weak var classes: UILabel!
    
    var n = String()
    var b = String()
    var c = String()
    var u = String()
    var subs = String()
    let ref = Database.database().reference()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bio.text = "something here"
        classes.text = "text here"
        
        // Do any additional setup after loading the view.
        self.ref.child("TutorList").child(subs).child(u).observeSingleEvent(of: DataEventType.value, with: { (snapshot) in
            
            let vals = snapshot.value as? NSDictionary
            let fn = (vals?["Fname"] as? String)!
            let ln = (vals?["Lname"] as? String)!
            
            self.n = "\(fn) \(ln)"
            
            let bio = (vals?["Bio"] as? String)!
            let cou = (vals?["Courses"] as? String)!
            
            self.b = "\(bio)"
            print (self.b)
            self.c = "\(cou)"
            
            self.nameLabel.text = self.n
            print (self.b)
            
            self.bio.text = self.b
            print (self.c)
            self.classes.text = self.c
        })
        
      
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
            
            let vc = segue.destination as! TutorChatViewController
        
            let name = n
            vc.name = name
            let user = u
            vc.username = user
        
    }
    
    

}
