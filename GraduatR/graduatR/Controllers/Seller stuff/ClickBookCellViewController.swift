//
//  ClickBookCellViewController.swift
//  graduatR
//
//  Created by Swaraj Bhaduri on 4/10/18.
//  Copyright © 2018 Simona Virga. All rights reserved.
//

import UIKit

class ClickBookCellViewController: UIViewController {
    
    var bookname = String()
    var bookclass = String()
     var bookprice = String()
     var bookauthor = String()
    var seller = String()
    var selleruid = String()
    @IBOutlet weak var bCourse: UILabel!
    @IBOutlet weak var bAuthor: UILabel!
    @IBOutlet weak var bPrice: UILabel!
    @IBOutlet weak var pName: UILabel!
    @IBOutlet weak var sellerName: UILabel!
    @IBOutlet weak var sellerUser: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.bPrice.text = bookprice
        self.bAuthor.text = bookauthor
        self.bCourse.text = bookclass
        self.pName.text = bookname
        self.sellerUser.text = seller
        
        //according to UID we have to go into the database and get the
        //name of the seller... (we only have the username not name)
        self.sellerName.text = seller
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if (segue.identifier == "sellerChat") {
            
            let vc = segue.destination as! SellerChatViewController
            let name = self.seller
            vc.name = name
            let user = self.seller
            vc.username = user
            

        } else {
            
            let vc = segue.destination as! SelleProfileViewController
            let uid = self.selleruid
            vc.uid = uid
            
        }
    }
}
