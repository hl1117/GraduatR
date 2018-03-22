////
//  AddCourseReviewViewController.swift
//  graduatR
//
//  Created by Simona Virga on 3/21/18.
//  Copyright © 2018 Simona Virga. All rights reserved.
//

import UIKit

class AddCourseReviewViewController: UIViewController {
    
    @IBOutlet weak var star1: UIButton!
    @IBOutlet weak var star2: UIButton!
    @IBOutlet weak var star3: UIButton!
    @IBOutlet weak var star4: UIButton!
    @IBOutlet weak var star5: UIButton!
    
    
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
        
    }
    
    
    @IBAction func star1Rate(_ sender: UIButton) {
        
        if let image = UIImage(named:"icons8-christmas-star-50") {
            sender.setImage(UIImage(named:"icons8-christmas-star-filled-50"), for: .normal)
        }
        /*if let image = UIImage(named:"icons8-christmas-star-filled-50") {
         sender.setImage( UIImage(named:"icons8-christmas-star-50"), for: .normal)
         }*/
        
    }
    
    @IBAction func star2Rate(_ sender: UIButton) {
        
        if let image = UIImage(named:"icons8-christmas-star-50") {
            sender.setImage(UIImage(named:"icons8-christmas-star-filled-50"), for: .normal)
            star1.setImage(UIImage(named:"icons8-christmas-star-filled-50"), for: UIControlState.normal)
        }
        
        
        /*if let image = UIImage(named:"icons8-christmas-star-filled-50") {
         sender.setImage( UIImage(named:"icons8-christmas-star-50"), for: .normal)
         }*/
        
    }
    
    @IBAction func star3Rate(_ sender: UIButton) {
        
        if let image = UIImage(named:"icons8-christmas-star-50") {
            sender.setImage(UIImage(named:"icons8-christmas-star-filled-50"), for: .normal)
            star1.setImage(UIImage(named:"icons8-christmas-star-filled-50"), for: UIControlState.normal)
            star2.setImage(UIImage(named:"icons8-christmas-star-filled-50"), for: UIControlState.normal)
        }
        /*if let image = UIImage(named:"icons8-christmas-star-filled-50") {
         sender.setImage( UIImage(named:"icons8-christmas-star-50"), for: .normal)
         }*/
    }
    
    @IBAction func star4Rate(_ sender: UIButton) {
        
        if let image = UIImage(named:"icons8-christmas-star-50") {
            sender.setImage(UIImage(named:"icons8-christmas-star-filled-50"), for: .normal)
            star1.setImage(UIImage(named:"icons8-christmas-star-filled-50"), for: UIControlState.normal)
            star2.setImage(UIImage(named:"icons8-christmas-star-filled-50"), for: UIControlState.normal)
            star3.setImage(UIImage(named:"icons8-christmas-star-filled-50"), for: UIControlState.normal)
        }
        /* if let image = UIImage(named:"icons8-christmas-star-filled-50") {
         sender.setImage( UIImage(named:"icons8-christmas-star-50"), for: .normal)
         }*/
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
    }
    
}

