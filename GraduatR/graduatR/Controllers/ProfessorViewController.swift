//
//  ProfessorViewController.swift
//  graduatR
//
//  Created by Dhriti Chawla on 3/13/18.
//  Copyright © 2018 Simona Virga. All rights reserved.
//

import UIKit

class ProfessorViewController: UIViewController {
    var profs = [String]()
    
    func fetchData () {
        
        let url:String = "https://api.purdue.io/odata/Instructors"
        let urlRequest = URL(string: url)
        
        if let URL = urlRequest {
            let task = URLSession.shared.dataTask(with: URL) { (data, response, error) in
                if (error != nil) {
                    print ("============")
                    print (error?.localizedDescription)
                } else {
                    if let stringData = String(data: data!, encoding: String.Encoding.utf8) {
                        //print ("what is DATA????????? ....")
                        //print (stringData)
                        do {
                            if let data = data,
                                let json = try JSONSerialization.jsonObject(with: data) as? [String: Any],
                                let value = json["value"] as? [[String: Any]] {
                                for val in value {
                                    
                                    
                                        if let name = val["Name"] as? String {
                                            
                                                self.profs.append(name)
                                                
                                        }
                                    print (self.profs)
//                                        self.tableView.reloadData()
                                    }
                                }
//                            self.refresh.endRefreshing()
//                            
                        } catch {
                            print ("Error is : \(error)")
                        }
                    }
                    
                }
                
            }; task.resume()
            
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
        // Do any additional setup after loading the view.
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
