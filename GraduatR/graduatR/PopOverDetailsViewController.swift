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
    
    var users = [String]()
    @IBOutlet weak var popuptable: UITableView!
    @IBOutlet weak var Popupview: UIView!
    let ref = Database.database().reference()
    @IBAction func Cancel(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func Leave(_ sender: UIButton) {
     
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.Popupview.layer.cornerRadius = 10
        self.Popupview.layer.masksToBounds = true
        getdata()
        // Do any additional setup after loading the view.
    }
    func getdata() {
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return users.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GroupPeopleCell", for: indexPath) as! GroupPeopleCell
        let nam = users[indexPath.row]
        cell.textLabel?.text = nam
        return cell
    }

    
    
}
