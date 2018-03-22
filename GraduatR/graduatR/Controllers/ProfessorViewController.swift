//
//  ProfessorViewController.swift
//  graduatR
//
//  Created by Dhriti Chawla on 3/13/18.
//  Copyright © 2018 Simona Virga. All rights reserved.
//

import UIKit

class ProfessorViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    
    var profs = [String]()
     let searchBar = UISearchBar()
    @IBOutlet weak var tableView: UITableView!
    var filteredArrayName = [String]()
    
    var showSearchResults = false
    
    var refresh: UIRefreshControl!
    
    
    func fetchData () {
        
        let url:String = "https://api.purdue.io/odata/Instructors"
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
                                        let clusterid = val["InstructorClusterId"] as? Int
//                                    if (clusterid == 8000) {
//                                        break
//                                    }
//
                                        if let name = val["Name"] as? String {
                                            
                                                self.profs.append(name)
                                                
                                        }
                                          self.tableView.reloadData()
                                    }
                                }
                            self.refresh.endRefreshing()
                            print (self.profs)
//                            
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
       
        // Do any additional setup after loading the view.
        createSearchBar()
        fetchData()
        
        refresh = UIRefreshControl()
        refresh.addTarget(self, action: #selector(CourseTableViewController.didPullToRefresh(_:)), for: .valueChanged)
        
        tableView.insertSubview(refresh, at: 0)
        
        tableView.reloadData()
        tableView.delegate = self
        tableView.dataSource = self
    }

    
    func createSearchBar() {
        
        searchBar.showsCancelButton = false
        searchBar.placeholder = "Search a professor...."
        searchBar.delegate = self
        
        self.navigationItem.titleView = searchBar
        
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let mySearch = searchBar.text!
        filteredArrayName = profs.filter({( name: String) -> Bool in
            return name.lowercased().range(of:searchText.lowercased()) != nil
        })
        
        
        
        if mySearch == "" {
            showSearchResults = false
            self.tableView.reloadData()
        } else {
            showSearchResults = true
            self.tableView.reloadData()
        }
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
    }
    
    // MARK: - Table view data source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (showSearchResults) {
            return filteredArrayName.count
        }
        else {
            return profs.count
            
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProfCell", for: indexPath) as! ProfCell
        
        if (showSearchResults){
            
            let nam = filteredArrayName[indexPath.row]
            cell.profName.text = nam
            
            
            cell.initials.text = nam[0]
            
        }
        else {
            let nam = profs[indexPath.row]
            cell.profName.text = nam
            
            cell.initials.text = nam[0]
            
        }
        return cell
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
extension String {
    subscript (i: Int) -> Character {
        return self[index(startIndex, offsetBy: i)]
    }
    subscript (i: Int) -> String {
        return String(self[i] as Character)
    }
    subscript (r: Range<Int>) -> String {
        let start = index(startIndex, offsetBy: r.lowerBound)
        let end = index(startIndex, offsetBy: r.upperBound)
        return String(self[Range(start ..< end)])
    }
}
