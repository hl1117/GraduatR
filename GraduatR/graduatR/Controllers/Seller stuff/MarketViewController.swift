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
    var filteredArrayName = [String]()
    
    var refresh: UIRefreshControl!
   
    var authormaps = [String: String]()
    var pricemaps = [String: String]()
    var coursemaps = [String: String]()
    var usernamemaps = [String: String]()
    var uidmaps = [String: String]()
    
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
        
        databaseRef.child("Sellers").observeSingleEvent(of: DataEventType.value, with: { (snapshotBooks) in
        let counter = 0;
        let enumer = snapshotBooks.children
        while let rest = enumer.nextObject() as? DataSnapshot {
            let vals = rest.value as? NSDictionary
            AllVariables.books.append((vals?["Title"] as? String)!)
            print((vals?["Title"] as? String)!)
        }
        })
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        var counter = 0;
        databaseRef.child("Sellers").observeSingleEvent(of: DataEventType.value, with: { snapshotA in
            let enumer = snapshotA.children
            while let rest = enumer.nextObject() as? DataSnapshot {
                let a = "Book\(counter)"
                self.databaseRef.child("Sellers").child(a).observeSingleEvent(of: DataEventType.value, with: { snapshotB in
                    
                    
                    //Book Details
                    let value = snapshotB.value as? NSDictionary
                    var title = value?["Title"] as? String ?? ""
                    
                    if (self.booktitle.contains(value?["Title"] as! String)){
                        var title = value?["Title"] as? String ?? ""
                        self.booktitle.append(title)
//                        self.bookprice.append(value?["Price"] as? String ?? "")
//                        self.bookcourse.append(value?["Course"] as? String ?? "")
//                        self.sellername.append(value?["Username"] as? String ?? "")
                        
                        self.authormaps[title] = value?["Author"] as? String ?? ""
                        self.pricemaps[title] = value?["Price"] as? String ?? ""
                        
                        self.coursemaps[title] = value?["Course"] as? String ?? ""
                        self.uidmaps[title] = value?["UID"] as? String ?? ""
                        self.usernamemaps[title] = value?["Username"] as? String ?? ""
                        }
                    })
                
                counter += 1
            
                }
            self.tableView.reloadData()
            self.tableView.delegate = self
            self.tableView.dataSource = self
            
            
             self.refresh.endRefreshing()
            
            
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
         filteredArrayName = booktitle.filter({( name: String) -> Bool in
            return name.lowercased().range(of:searchText.lowercased()) != nil
        })
        
        print("-------..----...------")
        print(filteredArrayName)
        print("-------..----...------")
        
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
        if (showSearchResults) {
            return filteredArrayName.count
        }
        else {
        print("BKT: \(booktitle)")
        
            return booktitle.count
            
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BookCell", for: indexPath) as! BookCell
        
        if (showSearchResults){
            let nam = filteredArrayName[indexPath.row]
            cell.title!.text = nam
            cell.author!.text = authormaps[nam]
            cell.price!.text = pricemaps[nam]
            cell.course!.text = coursemaps[nam]
            
        }
        else {
            print (booktitle)
        
            let ti = booktitle[indexPath.row]
            cell.title!.text = ti
        
            let au = bookauthor[indexPath.row]
            cell.author!.text = au
        
            let pr = bookprice[indexPath.row]
            cell.price!.text = pr
        
            let co = bookcourse[indexPath.row]
            cell.course!.text = co
        
        }
        return cell
    

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let vc = segue.destination as! ClickBookCellViewController
        let cell = sender as! UITableViewCell
        let indexPath = tableView.indexPath(for: cell)!
        
        if (showSearchResults){

            let name = filteredArrayName[indexPath.row]
            vc.bookname = name
            vc.bookauthor = authormaps[name]!
            vc.bookclass = coursemaps[name]!
            vc.bookprice = pricemaps[name]!
            vc.seller = usernamemaps[name]!
            vc.selleruid = uidmaps[name]!
            
        }
        else {
        
            let name = booktitle[indexPath.row]
            vc.bookname = name
            let auth = bookauthor[indexPath.row]
            vc.bookauthor = auth
            let pri = bookprice[indexPath.row]
            vc.bookprice = pri
            let cour = bookcourse[indexPath.row]
            vc.bookclass = cour
            let user = sellername[indexPath.row]
            vc.seller = user
            vc.selleruid = uidmaps[name]!
            
        }
        
        
    }

}