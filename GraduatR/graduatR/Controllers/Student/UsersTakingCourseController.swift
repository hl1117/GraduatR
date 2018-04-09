//
//  UsersTakingCourseController.swift
//  graduatR
//
//  Created by Dhriti Chawla on 4/5/18.
//  Copyright © 2018 Simona Virga. All rights reserved.
//

import UIKit
import Firebase

class UsersTakingCourseController: UIViewController , UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate{
    
    let ref = Database.database().reference()
    
    @IBOutlet weak var navBar: UINavigationItem!
    @IBOutlet var tableView: UITableView!
    var profpicmap = [String : String]()
    var unamemap = [String : String]()
    
    let searchBar = UISearchBar()
    var names = [String]()
    var uName = [String]()
    
    // var numbers = [String]()
    
    var filteredArrayName = [String]()
    var showSearchResults = false
    
    var refresh: UIRefreshControl!
    
    var SubjectAbbr = ""
    
    
    func fetchData () {
        print (AllVariables.courseselected)
        print ("......e..e..e..e.e..e..e.........")
        self.ref.child("Courses").child(AllVariables.courseselected).observeSingleEvent(of: DataEventType.value, with: { (snapshot) in
            let enumer = snapshot.children
            while let rest = enumer.nextObject() as? DataSnapshot {
                //self.names.removeAll()
                let vals = rest.value as? NSDictionary
                let fn = (vals?["Fname"] as? String)!
                let ln = (vals?["Lname"] as? String)!
                let prof = (vals?["ProfPic"] as? String ?? "")!
                if (!(self.uName.contains(rest.key))) {
                    self.names.append("\(fn) \(ln)")
                    let u = rest.key
                    self.uName.append(u)
                    self.unamemap["\(fn) \(ln)"] = u
                    self.profpicmap["\(fn) \(ln)"] = prof
                }
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
        refresh.addTarget(self, action: #selector(UsersTakingCourseController.didPullToRefresh(_:)), for: .valueChanged)
        
        tableView.insertSubview(refresh, at: 0)
        
        tableView.reloadData()
        tableView.delegate = self
        tableView.dataSource = self
        
        
        
    }
    
    func createSearchBar() {
        
        searchBar.showsCancelButton = false
        searchBar.placeholder = "Search a friend...."
        searchBar.delegate = self
        
        self.navigationItem.titleView = searchBar
    }
    func setProfilePicture(imageView:UIImageView, imageToSet:UIImage)
    {
        imageView.layer.cornerRadius = 10.0
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.layer.masksToBounds = true
        imageView.image = imageToSet
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserTakingClassCell", for: indexPath) as! UserTakingClassCell
        
        if (showSearchResults){
            
            let nam = filteredArrayName[indexPath.row]
            cell.name!.text = nam
            let unam = unamemap[nam]
            cell.username!.text = unam
            if (profpicmap[nam] != "") {
                let data = NSData(contentsOf: NSURL(string: profpicmap[nam]!)! as URL)
                setProfilePicture(imageView: cell.propic, imageToSet: UIImage(data: data! as Data)!)
            }
        }
        else {
            let nam = names[indexPath.row]
            cell.name!.text = nam
            let unam = unamemap[nam]
            cell.username!.text = unam
            if (profpicmap[nam] != "") {
                let data = NSData(contentsOf: NSURL(string: profpicmap[nam]!)! as URL)
                setProfilePicture(imageView: cell.propic, imageToSet: UIImage(data: data! as Data)!)
            }
        }
        return cell
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//
//        let vc = segue.destination as! TutorListDetailViewController
//        let cell = sender as! UITableViewCell
//        let indexPath = tableView.indexPath(for: cell)!
//
//
//        if (showSearchResults){
//
//            let name = filteredArrayName[indexPath.row]
//            vc.n = name
//            let un = uName[indexPath.row]
//            vc.u = un
//
//        }
//        else {
//            let name = names[indexPath.row]
//            vc.n = name
//            let un = uName[indexPath.row]
//            vc.u = un
//
//            let s = SubjectAbbr
//            vc.subs = s
//
//
//        }
//
//
//
//    }
    
}
