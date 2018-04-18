//
//  ParentSubjectViewController.swift
//  graduatR
//
//  Created by Dhriti Chawla on 3/24/18.
//  Copyright © 2018 Simona Virga. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class ParentSubjectViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate,UISearchBarDelegate {
    
    
    @IBOutlet var collectionView: UICollectionView!
    let searchBar = UISearchBar()
    var courseData = [[String: AnyObject]]()
    var subjects = [String]()
    var subID = [String]()
    var hashmap = [String : String]()
    
    
    var filteredArrayName = [String]()
    var filteredArrayId = [String]()
    //   var filteredArrayNumber = [String]()
    var showSearchResults = false
    
    var refresh: UIRefreshControl!
    
    func fetchData () {
        do {
            let file = Bundle.main.url(forResource: "Subjects", withExtension: "json")
            print("DATAAAAAAA")
            let data = try Data(contentsOf: file!)
            let json = try JSONSerialization.jsonObject(with: data) as? [String : Any]
            let value = json!["value"] as? [[String: Any]]
            for val in value! {
                
                var currSubId = val["SubjectId"] as! String
                self.subID.append(currSubId)
                if let name = val["Abbreviation"] as? String {
                    self.subjects.append(name)
                    self.hashmap[name] = currSubId
                }
            }
            self.collectionView.reloadData()
            self.collectionView.delegate = self
            self.collectionView.dataSource = self
        }
        catch {
            print("Error is: \(error)")
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        createSearchBar()
        fetchData()
        
        refresh = UIRefreshControl()
        refresh.addTarget(self, action: #selector(ParentSubjectViewController.didPullToRefresh(_:)), for: .valueChanged)
        
        collectionView.refreshControl = refresh
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func createSearchBar() {
        
        searchBar.showsCancelButton = false
        searchBar.placeholder = "Search a subject...."
        searchBar.delegate = self
        
        self.navigationItem.titleView = searchBar
        
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        searchBar.endEditing(true)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        showSearchResults = true
        searchBar.endEditing(true)
        
        self.collectionView.reloadData()
    }
    
    
    @objc func didPullToRefresh(_ refreshControl: UIRefreshControl) {
        fetchData()
        self.refresh.endRefreshing()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let mySearch = searchBar.text!
        filteredArrayName = subjects.filter({( name: String) -> Bool in
            return name.lowercased().range(of:searchText.lowercased()) != nil
        })
        
        
        if searchBar.text == "" {
            showSearchResults = false
            self.collectionView.reloadData()
        } else {
            showSearchResults = true
            self.collectionView.reloadData()
        }
        
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if (showSearchResults) {
            return filteredArrayName.count
        }
        else {
            //  print(subjects.count)
            return subjects.count
        }
        
    }
    
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ParSubCell", for: indexPath) as! ParSubCell
        
        // self.collectionView.reloadData()
        // print(subjects)
        
        if (showSearchResults){
            
            let nam = filteredArrayName[indexPath.row]
            cell.sub!.text = nam
            
        }
        else {
            
            let nam = subjects[indexPath.row]
            
            cell.sub.text = nam
        }
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        let vc = segue.destination as! ParentCoursesViewController
        let cell = sender as! UICollectionViewCell
        let indexPath = collectionView.indexPath(for: cell)!


        if (showSearchResults){

            let sub = filteredArrayName[indexPath.row]
            vc.SubjectId = hashmap[sub]!
            vc.SubjectAbbr = sub

        }
        else {
            let name = subID[indexPath.row]

            vc.SubjectId = name
            let sub = subjects[indexPath.row]
            vc.SubjectAbbr = sub
        }
    }
    
    func clear()
    {
        AllVariables.Username = ""
        AllVariables.Fname = ""
        AllVariables.Lname = ""
        AllVariables.GPA = ""
        AllVariables.standing = ""
        AllVariables.courses.removeAll()
        AllVariables.profpic = ""
        AllVariables.bio = ""
        AllVariables.uid = ""
        AllVariables.books.removeAll()
        AllVariables.courseselected = ""
        AllVariables.profselected = ""
        AllVariables.courseratings.removeAll()
        AllVariables.coursegrade.removeAll()
        AllVariables.examrating.removeAll()
        AllVariables.profratings.removeAll()
        AllVariables.gpaAnon = ""
    }
    
    @IBAction func logoutButton(_ sender: Any) {
        if (Auth.auth().currentUser != nil)
        {
            do {
                try? Auth.auth().signOut()
                
                if (Auth.auth().currentUser == nil) {
                    print("PARENT LOG OUT")
                    let loginVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginViewController") as UIViewController
                    self.present(loginVC, animated: true, completion: nil)
                    clear()
                }
            }
        }
    }
    
}
