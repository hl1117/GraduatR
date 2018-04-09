//
//  SameCourseStudentChatViewController.swift
//  graduatR
//
//  Created by Dhriti Chawla on 4/9/18.
//  Copyright © 2018 Simona Virga. All rights reserved.
//

import UIKit
import Firebase
import JSQMessagesViewController


class SameCourseStudentChatViewController: JSQMessagesViewController {
    
    var name = String()
    var username = String()
    
    
    var channelRef: DatabaseReference!
    
    var channel: String? {
        didSet {
            title = name 
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        print (username)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
