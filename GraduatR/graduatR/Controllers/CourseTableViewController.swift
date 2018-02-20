//
//  CourseTableViewController.swift
//  graduatR
//
//  Created by Dhriti Chawla on 2/19/18.
//  Copyright © 2018 Simona Virga. All rights reserved.
//

import UIKit

class CourseTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    @IBOutlet var tableView: UITableView!
    
    var courseData = [[String: AnyObject]]()
    var names = [String]()
    var numbers = [String]()
    let list = ["Fruits", "vegetables"]
    var refresh: UIRefreshControl!
    
    var CsSubjectId = "940bae64-4147-446e-91f1-d9626640201f"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        refresh = UIRefreshControl()
        refresh.addTarget(self, action: #selector(CourseTableViewController.didPullToRefresh(_:)), for: .valueChanged)
        
        tableView.insertSubview(refresh, at: 0)
        
            tableView.reloadData()
            tableView.delegate = self
            tableView.dataSource = self
        
        fetchData()
            
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func didPullToRefresh(_ refreshControl: UIRefreshControl) {
        fetchData()
    }
    
    func fetchData () {
        
        let url:String = "https://api.purdue.io/odata/Courses"
        let urlRequest = URL(string: url)
        
        if let URL = urlRequest {
            let task = URLSession.shared.dataTask(with: URL) { (data, response, error) in
                if (error != nil) {
                    print ("============")
                    print (error?.localizedDescription)
                } else {
                    if let stringData = String(data: data!, encoding: String.Encoding.utf8) {
                        print ("what is DATA????????? ....")
                        //print (stringData)
                        do {
                            if let data = data,
                                let json = try JSONSerialization.jsonObject(with: data) as? [String: Any],
                                let value = json["value"] as? [[String: Any]] {
                                for val in value {
                                    var currSubId = val["SubjectId"] as! String
                                    
                                    //                                    print ("and it is ... \(currSubId)")
                                    //                                    print ("and this is ..\(self.CsSubjectId)")
                                    if ( currSubId == self.CsSubjectId) {
                                        
                                        if let name = val["Title"] as? String {
                                            self.names.append(name)
                                            print (self.names)
                                            
                                        }
                                        
                                        if let num = val["Number"] as? String {
                                            self.numbers.append(num)
                                            print (self.numbers)
                                            
                                        }
                                    }
                                }
                            }
                            
                            self.tableView.reloadData()
                            self.refresh.endRefreshing()
                        } catch {
                            print ("Error is : \(error)")
                        }
                    }
                   
                }
                
            }; task.resume()
        }
    }

    // MARK: - Table view data source

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return names.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "courseCell", for: indexPath) as! CourseCell
        
        let nam = names[indexPath.row]
        let num = numbers[indexPath.row]
        cell.numberLabel.text = num
        cell.nameLabel.text = nam
        
        return cell

    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

   
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
