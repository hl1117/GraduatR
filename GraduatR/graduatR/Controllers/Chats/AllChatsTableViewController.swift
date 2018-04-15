//
//  AllChatsTableViewController.swift
//  graduatR
//
//  Created by Dhriti Chawla on 4/15/18.
//  Copyright © 2018 Simona Virga. All rights reserved.
//

import UIKit
import Firebase

class AllChatsTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate{
    
    let ref = Database.database().reference()
    
    @IBOutlet weak var navBar: UINavigationItem!
    @IBOutlet var tableView: UITableView!
    
    
    let searchBar = UISearchBar()
    var names = [String]()
    
    // var numbers = [String]()
    
    var filteredArrayName = [String]()
    var showSearchResults = false
    var refresh: UIRefreshControl!
    

    func fetchData () {
        self.ref.child("Chats").child(AllVariables.Username).observeSingleEvent(of: DataEventType.value, with: { (snapshot) in
        let enumer = snapshot.children
        while let rest = enumer.nextObject() as? DataSnapshot {
        //self.names.removeAll()
        let u = rest.key as? NSString
            if (!self.names.contains(u as! String)){
                self.names.append(u! as String)
        
            }
        }
    
    self.tableView.reloadData()
    self.tableView.delegate = self
    self.tableView.dataSource = self
    })
    
    print(names)
    }
    
    
    override func viewDidLoad() {
    super.viewDidLoad()
    createSearchBar()
    fetchData()
    
    refresh = UIRefreshControl()
    refresh.addTarget(self, action: #selector(AllChatsTableViewController.didPullToRefresh(_:)), for: .valueChanged)
    
    tableView.insertSubview(refresh, at: 0)
    
    }
    
    func createSearchBar() {
    
    searchBar.showsCancelButton = false
    searchBar.placeholder = "Search a chat...."
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
    let cell = tableView.dequeueReusableCell(withIdentifier: "AllChatCell", for: indexPath) as! AllChatCell
    
    if (showSearchResults){
    
        let nam = filteredArrayName[indexPath.row]
        cell.chatName!.text = nam
    
       // cell.initials.text = nam[0]
    }
    else {
        let nam = names[indexPath.row]
        cell.chatName!.text = nam
    
        //cell.initials.text = nam[0]
    }
    return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
        let vc = segue.destination as! MyChatViewController
        let cell = sender as! UITableViewCell
        let indexPath = tableView.indexPath(for: cell)!
    
    
    if (showSearchResults){
        let username = filteredArrayName[indexPath.row]
        vc.username = username
      
        
        
        //        let user = u
        //        vc.name = user
    
    }
        else {
        let name = names[indexPath.row]
        vc.username = name
      
        
        //        let user = u
        //        vc.name = user
    
    
    }
    
    
    
    }

}
