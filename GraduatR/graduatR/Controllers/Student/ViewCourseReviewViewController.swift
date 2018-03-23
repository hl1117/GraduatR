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

class ViewCourseReviewViewController: UIViewController {
    var refresh: UIRefreshControl!
    
    let ref = Database.database().reference()
    @IBOutlet weak var pieChartView: PieChartView!
    let stars = ["1 stars", "2 stars", "3 stars", "4 stars", "5 stars"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        refresh = UIRefreshControl()
//        refresh.addTarget(self, action: #selector(ViewCourseReviewViewController.didPullToRefresh(_:)), for: .valueChanged)
//
//        AllVariables.courseratings = [100,0,0,0,0]
//        setChart(dataPoints: stars, values: AllVariables.courseratings)
//
        getdata()
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
                            
                            
                            AllVariables.courseratings = [n1!, n2!, n3!, n4!, n5!]
                            print("THIS: \(AllVariables.courseratings)")
                            self.setChart(dataPoints: self.stars, values: AllVariables.courseratings)
                        })
                    }
                })
                
            }
            
        })
    }
//    override func viewDidAppear(_ animated: Bool) {
//        getdata()
//        self.refresh.endRefreshing()
//    }
//    @objc func didPullToRefresh(_ refreshControl: UIRefreshControl) {
//
//        viewDidAppear(true)
//    }
//
    func setChart(dataPoints: [String], values: [Double]) {
        
        var dataEntries: [ChartDataEntry] = []
        
        for i in 0..<dataPoints.count {
            print("THIS: \(AllVariables.courseratings)")
            let dataEntry1 = ChartDataEntry(x: Double(i), y: values[i], data: dataPoints[i] as AnyObject)
            
            dataEntries.append(dataEntry1)
        }
        print(dataEntries[0].data)
        let pieChartDataSet = PieChartDataSet(values: dataEntries, label: "Units Sold")
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
}
