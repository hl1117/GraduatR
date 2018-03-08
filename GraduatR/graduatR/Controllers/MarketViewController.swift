//
//  MarketViewController.swift
//  graduatR
//
//  Created by Dhriti Chawla on 3/8/18.
//  Copyright © 2018 Simona Virga. All rights reserved.
//

import UIKit
import Firebase

class MarketViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {

    @IBOutlet weak var navBar: UINavigationItem!
    @IBOutlet var tableView: UITableView!
    
    let searchBar = UISearchBar()
    var booktitle = [String]()
    var bookauthor = [String]()
    var bookprice = [String]()
    var bookcourse = [String]()
    var sellername = [String]()
    
    var refresh: UIRefreshControl!
    
    
    var showSearchResults = false
    let databaseRef = Database.database().reference();
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        createSearchBar()
        
        refresh = UIRefreshControl()
        refresh.addTarget(self, action: #selector(MarketViewController.didPullToRefresh(_:)), for: .valueChanged)
        
        tableView.insertSubview(refresh, at: 0)
        
        tableView.reloadData()
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        databaseRef.child("Users").child("Sellers").observeSingleEvent(of: DataEventType.value, with: { snapshotA in
            let enumer = snapshotA.children
            while let rest = enumer.nextObject() as? DataSnapshot {
                let a = rest.value
                self.databaseRef.child("Users").child("Sellers").child(a as! String).observeSingleEvent(of: DataEventType.value, with: { snapshotB in
               //Check inside username enumer2 = number of books for username
                    let enumer2 = snapshotB.children
                    let nums = snapshotB.childrenCount
                    var i = 0;
                    while i < nums {
                        self.sellername.append(rest.value as! String)
                        i += 1
                    }
                //Loop inside every book
                    while let rest2 = enumer2.nextObject() as? DataSnapshot {
                        self.databaseRef.child("Users").child("Sellers").child(rest.value as! String).child(rest2.value as! String).observeSingleEvent(of: DataEventType.value, with: { snapshotC in
                            let value = snapshotC.value as? NSDictionary
                            //Book Details
                            self.booktitle.append(value?["Title"] as? String ?? "")
                            self.bookauthor.append(value?["Author"] as? String ?? "")
                            self.bookprice.append(value?["Price"] as? String ?? "")
                            self.bookcourse.append(value?["Course"] as? String ?? "")
                        })
                    }
                    })
                }
            })
    }
    
    func createSearchBar() {
        
        searchBar.showsCancelButton = false
        searchBar.placeholder = "Search a book...."
        searchBar.delegate = self
        
        self.navigationItem.titleView = searchBar
        
        
    }
    
    @objc func didPullToRefresh(_ refreshControl: UIRefreshControl) {
        viewDidAppear(true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let mySearch = searchBar.text!
//        filteredArrayName = names.filter({( name: String) -> Bool in
//            return name.lowercased().range(of:searchText.lowercased()) != nil
//        })
        
        
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if (showSearchResults) {
//            return filteredArrayName.count
//        }
//        else {
            return booktitle.count
            
//        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BookCell", for: indexPath) as! BookCell
        
//        if (showSearchResults){
//
//            let nam = filteredArrayName[indexPath.row]
//            cell.nameLabel!.text = nam
//
//        }
//        else {
            let nam = booktitle[indexPath.row]
            cell.title!.text = nam
//        }
        return cell
    }

    

   

}
