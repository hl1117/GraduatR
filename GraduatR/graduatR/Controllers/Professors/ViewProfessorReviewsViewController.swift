//
//  ViewProfessorReviewsViewController.swift
//  graduatR
//
//  Created by Simona Virga on 3/22/18.
//  Copyright © 2018 Simona Virga. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase
import Charts

class ViewProfessorReviewsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var pieChartView: PieChartView!
    var refresh: UIRefreshControl!
    var n = String()
    @IBOutlet weak var tableView: UITableView!
    let stars = ["One", "Two", "Three", "Four", "Five"]
    var avgrating = Double()
    var reviews = [String]()
    
    @IBOutlet weak var average: UILabel!
    var databaseRef = Database.database().reference()
    var storageRef = Storage.storage().reference()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getdata()
        average.text = "Average rating: \(avgrating)"
        // Do any additional setup after loading the view.
       // nameLabel.text = n
        
        refresh = UIRefreshControl()
//        refresh.addTarget(self, action: #selector(ViewProfessorReviewsViewController.didPullToRefresh(_:)), for: .valueChanged)
//
        tableView.insertSubview(refresh, at: 0)
        
        
        self.tableView.reloadData()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        //fetch from database
        print("hgjkhgjkhgjkhghhj")
        databaseRef.child("ProfessorReviews").child(AllVariables.profselected).child("Comments").observeSingleEvent(of: DataEventType.value, with: { (snapshotA) in
            
            print("before")
            for child in snapshotA.children {
                print("child")
                let snap = child as! DataSnapshot
                let key = snap.key
                let value = snap.value
                print("VALUE IS: \(value)")
                self.reviews.append(value! as! String)
                print("REVIEWS: \(self.reviews)")
                //print("key = \(key)    value = \(value!)")
            }
            print("After")
            
        })
        
        self.tableView.reloadData()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.refresh.endRefreshing()
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        getdata()
        self.tableView.reloadData()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        //fetch from database
        print("hgjkhgjkhgjkhghhj")
        databaseRef.child("ProfessorReviews").child(AllVariables.profselected).child("Comments").observeSingleEvent(of: DataEventType.value, with: { (snapshotA) in
            
            print("before")
            for child in snapshotA.children {
                print("child")
                let snap = child as! DataSnapshot
                let key = snap.key
                let value = snap.value
                print("VALUE IS: \(value)")
                if (!(self.reviews.contains(value! as! String))) {
                    self.reviews.append(value! as! String)
                }
                print("REVIEWS: \(self.reviews)")
                //print("key = \(key)    value = \(value!)")
            }
            print("After")
            
        })
        
        self.tableView.reloadData()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.refresh.endRefreshing()
        
    }
    func getdata() {
        databaseRef.observeSingleEvent(of: DataEventType.value, with: { (snapshotA) in
            print("WHAT3")
            if (!(snapshotA.hasChild("ProfessorReviews"))) {
                self.databaseRef.child("ProfessorReviews").child(AllVariables.profselected).setValue(["1stars": 0, "2stars": 0, "3stars": 0, "4stars": 0, "5stars": 0 ])
                
                AllVariables.profratings = [0, 0, 0, 0, 0]
                self.setChart(dataPoints: self.stars, values: AllVariables.profratings)
                
            }
            else {
                self.databaseRef.child("ProfessorReviews").observeSingleEvent(of: DataEventType.value, with: { (snapshotB) in
                    print("WHAT4")
                    if (!(snapshotB.hasChild(AllVariables.profselected))) {
                        self.databaseRef.child("ProfessorReviews").child(AllVariables.profselected).setValue(["1stars": 0, "2stars": 0, "3stars": 0, "4stars": 0, "5stars": 0 ])
                        
                        
                        AllVariables.profratings = [0, 0, 0, 0, 0]
                        self.setChart(dataPoints: self.stars, values: AllVariables.profratings)
                        
                        
                    }
                    else {
                        self.databaseRef.child("ProfessorReviews").child(AllVariables.profselected).observeSingleEvent(of: DataEventType.value, with: {(snapshot) in
                            let valu = snapshot.value as? NSDictionary
                            print("IMHERE")
                            let n1 = valu?["1stars"] as? Double
                            let n2 = valu?["2stars"] as? Double
                            let n3 = valu?["3stars"] as? Double
                            let n4 = valu?["4stars"] as? Double
                            let n5 = valu?["5stars"] as? Double
                            
                            let sum = (n1! * 1.0) + (n2! * 2.0) + (n3! * 3.0) + (n4! * 4.0) + (n5! * 5.0)
                            print("SUM \(sum)")
                            self.avgrating = (sum)/(n1!+n2!+n3!+n4!+n5!)
                            print("AVG RATING = \(self.avgrating)")
                            
                            self.average.text = "Average rating: \(self.avgrating)"
                            AllVariables.profratings = [n1!, n2!, n3!, n4!, n5!]
                            print("THIS: \(AllVariables.profratings)")
                            self.setChart(dataPoints: self.stars, values: AllVariables.profratings)
                        })
                    }
                })
                
            }
            
        })
    }
    
    func setChart(dataPoints: [String], values: [Double]) {
        
        var dataEntries: [ChartDataEntry] = []
        
        for i in 0..<dataPoints.count {
            print("THIS: \(AllVariables.profratings)")
            let dataEntry1 = PieChartDataEntry(value: values[i], label: dataPoints[i], data: dataPoints[i] as AnyObject)
            if (values[i] != 0.0) {
                dataEntries.append(dataEntry1)
            }
        }
        let pieChartDataSet = PieChartDataSet(values: dataEntries, label: "Number of Stars")
        let pieChartData = PieChartData(dataSet: pieChartDataSet)
        pieChartView.data = pieChartData
        
        var colors: [UIColor] = []
        
        for _ in 0..<dataPoints.count {
            let red = Double(arc4random_uniform(256))
            let green = Double(arc4random_uniform(256))
            let blue = Double(arc4random_uniform(256))
            
            let color = UIColor(red: CGFloat(red/255), green: CGFloat(green/255), blue: CGFloat(blue/255), alpha: 1)
            colors.append(color)
        }
        
        pieChartDataSet.colors = colors
    }
    
    
    func tableView(_ tableView:UITableView!, numberOfRowsInSection section:Int) -> Int
    {
        return reviews.count
    }
    
    func tableView(_ tableView: UITableView!, cellForRowAt indexPath: IndexPath!) -> UITableViewCell!
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProfessorReviewCell", for: indexPath) as! ProfessorReviewCell
        
                let review = reviews[indexPath.row]
                cell.reviewText.text = review
        
        return cell
    }
    
    
    
    
}

