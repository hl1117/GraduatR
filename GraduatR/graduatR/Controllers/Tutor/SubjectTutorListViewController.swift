//
//  SubjectTutorListViewController.swift
//  graduatR
//
//  Created by Dhriti Chawla on 3/22/18.
//  Copyright © 2018 Simona Virga. All rights reserved.
//

import UIKit
import Firebase

class SubjectTutorListViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate,UISearchBarDelegate {
    
    
    @IBOutlet var collectionView: UICollectionView!
    let searchBar = UISearchBar()
    var courseData = [[String: AnyObject]]()
    var subjects = [String]()
    
    var filteredArrayName = [String]()
    var filteredArrayId = [String]()
    //   var filteredArrayNumber = [String]()
    var showSearchResults = false
    
    var refresh: UIRefreshControl!
    let ref = Database.database().reference()
    
    func fetchData () {
        self.ref.child("TutorList").observeSingleEvent(of: DataEventType.value, with: { (snapshot) in
            let enumer = snapshot.children
            while let rest = enumer.nextObject() as? DataSnapshot {
                let vals = rest.key as? String!
                self.subjects.append(vals!)
            }
            
        })
        print(self.subjects)
       
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        createSearchBar()
        fetchData()
        
        refresh = UIRefreshControl()
        refresh.addTarget(self, action: #selector(SubjectTutorListViewController.didPullToRefresh(_:)), for: .valueChanged)
        
        collectionView.insertSubview(refresh, at: 0)
        
        collectionView.reloadData()
        collectionView.delegate = self
        collectionView.dataSource = self
        
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
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TutSubCell", for: indexPath) as! TutSubCell
        
        // self.collectionView.reloadData()
        // print(subjects)
        
        if (showSearchResults){
            
            let nam = filteredArrayName[indexPath.row]
            cell.nameLabel!.text = nam
            
        }
        else {
            
            let nam = subjects[indexPath.row]
            
            cell.nameLabel.text = nam
        }
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        let vc = segue.destination as! TutorListViewController
        let cell = sender as! UICollectionViewCell
        let indexPath = collectionView.indexPath(for: cell)!


        if (showSearchResults){

            let sub = filteredArrayName[indexPath.row]
            vc.SubjectAbbr = sub

        }
        else {
            
            let sub = subjects[indexPath.row]
            vc.SubjectAbbr = sub
        }



    }

}
