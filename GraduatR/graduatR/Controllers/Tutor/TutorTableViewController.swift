//
//  TutorTableViewController.swift
//  graduatR
//
//  Created by Dhriti Chawla on 3/21/18.
//  Copyright © 2018 Simona Virga. All rights reserved.
//

import UIKit

class TutorTableViewController: UIViewController , UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate{
    
    @IBOutlet weak var navBar: UINavigationItem!
    @IBOutlet var tableView: UITableView!
    
    
    let searchBar = UISearchBar()
    var courseData = [[String: AnyObject]]()
    var names = [String]()
    var creds = [String]()
    
    // var numbers = [String]()
    
    var filteredArrayName = [String]()
    var filteredArrayName2 = [String]()
    var showSearchResults = false
    
    var refresh: UIRefreshControl!
    
    var SubjectId = ""
    var SubjectAbbr = ""
    
    
    func fetchData () {
        do {
            let file = Bundle.main.url(forResource: "Courses", withExtension: "json")
            print("DATAAAAAAA")
            let data = try Data(contentsOf: file!)
            let json = try JSONSerialization.jsonObject(with: data) as? [String : Any]
            let value = json!["value"] as? [[String: Any]]
            for val in value! {
                var currSubId = val["SubjectId"] as! String
                if ( currSubId == self.SubjectId) {
                    if let name = val["Title"] as? String {
                        if let num = val["Number"] as? String {
                            if let credits = val["CreditHours"] as? Int {
                                if let des = val["Description"] as? String {
                                    self.names.append("\(self.SubjectAbbr) \(num) \t \(name)")
                                    self.creds.append(" - Course Title: \(name) \n - Course Number: \(num) \n - Credit Hours: \(credits) \n \(des)")
                                }
                            }
                        }
                    }
                }
            }
            self.tableView.reloadData()
            self.tableView.delegate = self
            self.tableView.dataSource = self
        }
        catch {
            print("Error is: \(error)")
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createSearchBar()
        fetchData()
        
        refresh = UIRefreshControl()
        refresh.addTarget(self, action: #selector(TutorTableViewController.didPullToRefresh(_:)), for: .valueChanged)
        
        tableView.insertSubview(refresh, at: 0)
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
        filteredArrayName2 = creds.filter({( name: String) -> Bool in
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
        self.refresh.endRefreshing()
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "tutCourseCell", for: indexPath) as! TutCourseCell
        
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

        let vc = segue.destination as! TutorAddCourseViewController
        let cell = sender as! UITableViewCell
        let indexPath = tableView.indexPath(for: cell)!


        if (showSearchResults){

            let name = filteredArrayName[indexPath.row]
            vc.n = name
            let credos = filteredArrayName2[indexPath.row]
            vc.c = credos
            
            let subabbr = self.SubjectAbbr
            vc.sa = subabbr
        }
        else {
            let name = names[indexPath.row]
            vc.n = name

            let credos = creds[indexPath.row]
            vc.c = credos
            
            let subabbr = self.SubjectAbbr
            vc.sa = subabbr
        }



}
}
