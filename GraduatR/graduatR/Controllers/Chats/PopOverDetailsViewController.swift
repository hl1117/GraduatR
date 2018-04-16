//
//  PopOverDetailsViewController.swift
//  graduatR
//
//  Created by Swaraj Bhaduri on 4/15/18.
//  Copyright © 2018 Simona Virga. All rights reserved.
//

import UIKit
import Firebase

class PopOverDetailsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var hashmap = [String : String]()
    var groupname = ""
    var users = [String]()
    @IBOutlet weak var popuptable: UITableView!
    @IBOutlet weak var Popupview: UIView!
    let ref = Database.database().reference()
    @IBAction func Cancel(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func Leave(_ sender: UIButton) {
        Database.database().reference().child("Chats").child(AllVariables.Username).child(groupname).removeValue()
    Database.database().reference().child("GroupChats").child(groupname).child("chatUsers").child(AllVariables.Username).removeValue()
        let alert = UIAlertController(title: "WAIT", message: "If you choose to leave group you must re-add course to join group again!", preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "Thanks, got it!", style: .default) { (action) in
            print ("ok tappped")
          
            //self.performSegue(withIdentifier: "Allchats", sender: self)
            //self.dismiss(animated: false, completion: nil)
            
            self.presentingViewController?.dismiss(animated: true, completion: nil)
            
        }
        alert.addAction(OKAction)
        self.present(alert, animated: true) {
            print("ERROR")
        }
        
        
        // navigationController?.popToViewController(AllChatsTableViewController, animated: true)
        //self.present(AllChatsTableViewController(), animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.Popupview.layer.cornerRadius = 10
        self.Popupview.layer.masksToBounds = true
        getdata()
        // Do any additional setup after loading the view.
    }
    func getdata() {
        print("this group name is \(groupname)")
    Database.database().reference().child("GroupChats").child(self.groupname).child("chatUsers").observeSingleEvent(of: DataEventType.value, with: { snap in
            let enumer = snap.children
            while let rest = enumer.nextObject() as? DataSnapshot {
                let val = rest.value as? NSDictionary
                let fname = val?["Fname"] as! String
                let lname = val?["Lname"] as! String
                let name = "\(fname) \(lname)"
                self.hashmap[rest.key as String] = name
                self.users.append(rest.key as String)
            }
            self.popuptable.reloadData()
            self.popuptable.delegate = self
            self.popuptable.dataSource = self
        })
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return self.users.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GroupPeopleCell", for: indexPath) as! GroupPeopleCell
        let nam = self.hashmap[self.users[indexPath.row]]
        cell.textLabel?.text = nam
        return cell
    }

    
    
}
