//
//  TutorListViewController.swift
//  graduatR
//
//  Created by Dhriti Chawla on 3/22/18.
//  Copyright © 2018 Simona Virga. All rights reserved.
//

import UIKit
import Firebase

class TutorListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate{
    
    let ref = Database.database().reference()
    
    @IBOutlet weak var navBar: UINavigationItem!
    @IBOutlet var tableView: UITableView!
    
    
    let searchBar = UISearchBar()
    var names = [String]()
    
    // var numbers = [String]()
    
    var filteredArrayName = [String]()
    var showSearchResults = false
    
    var refresh: UIRefreshControl!
    
    var SubjectAbbr = ""
    
    
    func fetchData () {
        
        self.ref.child("TutorList").child(SubjectAbbr).observeSingleEvent(of: DataEventType.value, with: { (snapshot) in
            let enumer = snapshot.children
            while let rest = enumer.nextObject() as? DataSnapshot {
                self.names.removeAll()
                let vals = rest.value as? NSDictionary
                    let fn = (vals?["Fname"] as? String)!
                    let ln = (vals?["Lname"] as? String)!

                    self.names.append("\(fn) \(ln)")
            }
        })
        self.tableView.reloadData()
       
        print(names)
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createSearchBar()
        fetchData()
        
        refresh = UIRefreshControl()
        refresh.addTarget(self, action: #selector(TutorListViewController.didPullToRefresh(_:)), for: .valueChanged)
        
        tableView.insertSubview(refresh, at: 0)
        
        tableView.reloadData()
        tableView.delegate = self
        tableView.dataSource = self
        
        
        
    }
    
    func createSearchBar() {
        
        searchBar.showsCancelButton = false
        searchBar.placeholder = "Search a tutor...."
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "TutListCell", for: indexPath) as! TutListCell
        
        if (showSearchResults){
            
            let nam = filteredArrayName[indexPath.row]
            cell.nameLabel!.text = nam
            
            cell.initials.text = nam[0]
        }
        else {
            let nam = names[indexPath.row]
            cell.nameLabel!.text = nam
    
            cell.initials.text = nam[0]
        }
        return cell
    }
    
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//
//        let vc = segue.destination as! AddCourseViewController
//        let cell = sender as! UITableViewCell
//        let indexPath = tableView.indexPath(for: cell)!
//
//
//        if (showSearchResults){
//
//            let name = filteredArrayName[indexPath.row]
//            vc.n = name
//            let credos = filteredArrayName2[indexPath.row]
//            vc.c = credos
//        }
//        else {
//            let name = names[indexPath.row]
//            vc.n = name
//
//            let credos = creds[indexPath.row]
//            vc.c = credos
//        }
//
//
//
//    }

}
