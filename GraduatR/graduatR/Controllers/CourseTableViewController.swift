//
//  CourseTableViewController.swift
//  graduatR
//
//  Created by Dhriti Chawla Swaraj Bhaduri on 2/19/18.
//  Copyright © 2018 Simona Virga. All rights reserved.
//

import UIKit

class CourseTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate{
    
    @IBOutlet weak var navBar: UINavigationItem!
    @IBOutlet var tableView: UITableView!
    
    
    let searchBar = UISearchBar()
    var courseData = [[String: AnyObject]]()
    var names = [String]()
    
    // var numbers = [String]()
    
    var filteredArrayName = [String]()
    //   var filteredArrayNumber = [String]()
    var showSearchResults = false
    
    var refresh: UIRefreshControl!
    
    var CsSubjectId = "940bae64-4147-446e-91f1-d9626640201f"
    
    
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
                        //print ("what is DATA????????? ....")
                        //print (stringData)
                        do {
                            if let data = data,
                                let json = try JSONSerialization.jsonObject(with: data) as? [String: Any],
                                let value = json["value"] as? [[String: Any]] {
                                for val in value {
                                    var currSubId = val["SubjectId"] as! String
                                    
                                    if ( currSubId == self.CsSubjectId) {
                                        
                                        if let name = val["Title"] as? String {
                                            if let num = val["Number"] as? String {
                                                self.names.append("CS \(num) \t \(name)")
                                                //  print (self.names)
                                            }
                                        }
                                        self.tableView.reloadData()
                                    }
                                }
                            }
                            
                            
                            self.refresh.endRefreshing()
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
        createSearchBar()
        
        refresh = UIRefreshControl()
        refresh.addTarget(self, action: #selector(CourseTableViewController.didPullToRefresh(_:)), for: .valueChanged)
        
        tableView.insertSubview(refresh, at: 0)
        
        tableView.reloadData()
        tableView.delegate = self
        tableView.dataSource = self
        
        
        
    }
    
    func createSearchBar() {
        
        searchBar.showsCancelButton = false
        searchBar.placeholder = "Search a course...."
        searchBar.delegate = self
        
        self.navigationItem.titleView = searchBar
        
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let mySearch = searchBar.text!
        filteredArrayName = names.filter({( name: String) -> Bool in
            return name.lowercased().range(of:searchText.lowercased()) != nil
        })
        
        
        if searchBar.text == "" {
            showSearchResults = false
            self.tableView.reloadData()
        } else {
            showSearchResults = true
            self.tableView.reloadData()
        }
        
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        searchBar.endEditing(true)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        showSearchResults = true
        searchBar.endEditing(true)
        
        self.tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func didPullToRefresh(_ refreshControl: UIRefreshControl) {
        fetchData()
    }
    
    // MARK: - Table view data source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (showSearchResults) {
            return filteredArrayName.count
        }
        else {
            return names.count
            
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "courseCell", for: indexPath) as! CourseCell
        
        if (showSearchResults){
            
            let nam = filteredArrayName[indexPath.row]
            cell.nameLabel!.text = nam
            
        }
        else {
            let nam = names[indexPath.row]
            cell.nameLabel!.text = nam
        }
        return cell
    }


override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
    let vc = segue.destination as! AddCourseViewController
    let cell = sender as! UITableViewCell
    let indexPath = tableView.indexPath(for: cell)!
    
    
    if (showSearchResults){
        
        let name = filteredArrayName[indexPath.row]
        vc.n = name
        
    }
    else {
        let name = names[indexPath.row]
        vc.n = name
    }
    
    

    }
}
