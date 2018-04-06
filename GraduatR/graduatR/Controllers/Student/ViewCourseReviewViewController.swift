//
//  ViewCourseReviewViewController.swift
//  graduatR
//
//  Created by Dhriti Chawla on 3/23/18.
//  Copyright © 2018 Simona Virga. All rights reserved.
//

import UIKit
import Charts
import Firebase

class ViewCourseReviewViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var avgrating = Double()
    var ref = Database.database().reference()
    @IBOutlet weak var pieChartView: PieChartView!
    let stars = ["One", "Two", "Three", "Four", "Five"]
    
   // @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    //@IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var average: UILabel!
    
   var reviews = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getdata()
        average.text = "Average rating: \(avgrating)"
        
        self.tableView.reloadData()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        //fetch from database
        print("hgjkhgjkhgjkhghhj")
        ref.child("CourseReviews").child(AllVariables.courseselected).child("Comments").observeSingleEvent(of: DataEventType.value, with: { (snapshotA) in
            
            print("before")
                //CourseReview-Course-Comments-snap
                let enumer = snapshotA.children
                while let rest = enumer.nextObject() as? DataSnapshot {
                    
                let snap = rest.value as! NSDictionary
                if (snap["Anonymity"] as! String! == "yes") {
                    let review = snap["reviews"] as! String
                    if (!(self.reviews.contains(review))) {
                        self.reviews.append("Anonymous: \(review)")
                    }
                }
                else {
                    let review = snap["reviews"] as! String
                    if (!(self.reviews.contains(review))) {
                        self.reviews.append("\(rest.key as! NSString): \(review)")
                    }
                }
            }
            print("After")
        })
        
        self.tableView.reloadData()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
      //  self.refresh.endRefreshing()

    }
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        getdata()
        self.tableView.reloadData()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        //fetch from database
        print("hgjkhgjkhgjkhghhj")
        ref.child("CourseReviews").child(AllVariables.courseselected).child("Comments").observeSingleEvent(of: DataEventType.value, with: { (snapshotA) in
            
            print("before")
            //CourseReview-Course-Comments-snap
            let enumer = snapshotA.children
            while let rest = enumer.nextObject() as? DataSnapshot {
                
                let snap = rest.value as! NSDictionary
                if (snap["Anonymity"] as! String! == "yes") {
                    let review = snap["reviews"] as! String
                    if (!(self.reviews.contains(review))) {
                        self.reviews.append("Anonymous: \(review)")
                    }
                }
                else {
                    let review = snap["reviews"] as! String
                    if (!(self.reviews.contains(review))) {
                        self.reviews.append("\(rest.key as! NSString): \(review)")
                    }
                }
            }
        print("After")
        })
        
        self.tableView.reloadData()
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    
    
    func getdata() {
        ref.observeSingleEvent(of: DataEventType.value, with: { (snapshotA) in
            print("WHAT3")
            if (!(snapshotA.hasChild("CourseReviews"))) {
                self.ref.child("CourseReviews").child(AllVariables.courseselected).setValue(["1stars": 0, "2stars": 0, "3stars": 0, "4stars": 0, "5stars": 0 ])
                
                AllVariables.courseratings = [0, 0, 0, 0, 0]
                self.setChart(dataPoints: self.stars, values: AllVariables.courseratings)
                
            }
            else {
                self.ref.child("CourseReviews").observeSingleEvent(of: DataEventType.value, with: { (snapshotB) in
                    print("WHAT4")
                    if (!(snapshotB.hasChild(AllVariables.courseselected))) {
                        self.ref.child("CourseReviews").child(AllVariables.courseselected).setValue(["1stars": 0, "2stars": 0, "3stars": 0, "4stars": 0, "5stars": 0 ])
                        
                        
                        AllVariables.courseratings = [0, 0, 0, 0, 0]
                        self.setChart(dataPoints: self.stars, values: AllVariables.courseratings)
                        
                        
                    }
                    else {
                        self.ref.child("CourseReviews").child(AllVariables.courseselected).observeSingleEvent(of: DataEventType.value, with: {(snapshot) in
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
                            AllVariables.courseratings = [n1!, n2!, n3!, n4!, n5!]
                            print("THIS: \(AllVariables.courseratings)")
                            self.setChart(dataPoints: self.stars, values: AllVariables.courseratings)
                        })
                    }
                })
                
            }
            
        })
    }

    func setChart(dataPoints: [String], values: [Double]) {
        
        var dataEntries: [ChartDataEntry] = []
        
        for i in 0..<dataPoints.count {
            print("THIS: \(AllVariables.courseratings)")
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "CourseReviewCell", for: indexPath) as! CourseReviewCell
        
        let review = reviews[indexPath.row]
        cell.reviewText.text = review
        
        return cell
    }
    
    
}
