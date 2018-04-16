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
    @IBOutlet weak var barChartView: BarChartView!
    var gradesAvg = ["A+", "A", "A-", "B+", "B", "B-", "C+", "C", "C-", "D+", "D", "D-", "F"]
    let units = [5.0, 3.0, 2.0, 9.0, 25.0, 35.0, 45.0, 5.0, 65.0, 15.0, 15.0, 25.0, 75.0]
    
    var viewLoad = false;
    
    @IBOutlet weak var avgGradeRecLabel: UILabel!
    
    @IBOutlet weak var examDiffLabel: UILabel!
    // @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    //@IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var average: UILabel!
    
   var reviews = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewLoad = true
        getdata()
        getData2()
        average.text = "Average rating: \(avgrating)"
        //setChart2(dataPoints: gradesAvg, values: units)
        
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
                    if (!(self.reviews.contains("Anonymous: \(review)"))) {
                        self.reviews.append("Anonymous: \(review)")
                    }
                    
                }
                else {
                    let review = snap["reviews"] as! String
                    if (!(self.reviews.contains("\(rest.key as! NSString): \(review)"))) {
                        self.reviews.append("\(rest.key as! NSString): \(review)")
                    }
                }
            }
            print("After")
        })
        
        getCourseAvg()
        //getGrades()
        
        
        self.tableView.reloadData()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        //getExamDifficulty()
      //  self.refresh.endRefreshing()

    }
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        getdata()
        getData2()
        
        //setChart2(dataPoints: gradesAvg, values: units)
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
                    if (!(self.reviews.contains("Anonymous: \(review)"))) {
                        self.reviews.append("Anonymous: \(review)")
                    }
                }
                else {
                    let review = snap["reviews"] as! String
                    if (!(self.reviews.contains("\(rest.key as! NSString): \(review)"))) {
                        self.reviews.append("\(rest.key as! NSString): \(review)")
                    }
                }
            }
        print("After")
        })
        getExamDifficulty()
        //getGrades()
        getCourseAvg()
        self.tableView.reloadData()
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    func getData2() {
        ref.observeSingleEvent(of: DataEventType.value, with: { (snapshotA) in
            print("WHAT3")
            if (!(snapshotA.hasChild("AllCourseGrades"))) {
                self.ref.child("AllCourseGrades").child(AllVariables.courseselected).setValue(["A+": 0, "A": 0, "A-": 0, "B+": 0, "B": 0, "B-": 0, "C+": 0, "C": 0, "C-": 0, "D+": 0, "D": 0, "D-": 0, "F": 0])
                
                AllVariables.coursegrade = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
                self.setChart2(dataPoints: self.gradesAvg, values: AllVariables.coursegrade)
                
            }
            else {
                self.ref.child("AllCourseGrades").observeSingleEvent(of: DataEventType.value, with: { (snapshotB) in
                    print("WHAT4")
                    if (!(snapshotB.hasChild(AllVariables.courseselected))) {
                        self.ref.child("AllCourseGrades").child(AllVariables.courseselected).setValue(["A+": 0, "A": 0, "A-": 0, "B+": 0, "B": 0, "B-": 0, "C+": 0, "C": 0, "C-": 0, "D+": 0, "D": 0, "D-": 0, "F": 0])
                        
                        
                        AllVariables.coursegrade = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
                        self.setChart2(dataPoints: self.gradesAvg, values: AllVariables.coursegrade)
                        
                        
                    }
                    else {
                        self.ref.child("AllCourseGrades").child(AllVariables.courseselected).observeSingleEvent(of: DataEventType.value, with: {(snapshot) in
                            let valu = snapshot.value as? NSDictionary
                            print("IMHERE")
                            let n1 = valu?["A+"] as? Double
                            let n2 = valu?["A"] as? Double
                            let n3 = valu?["A-"] as? Double
                            let n4 = valu?["B+"] as? Double
                            let n5 = valu?["B"] as? Double
                            let n6 = valu?["B-"] as? Double
                            let n7 = valu?["C+"] as? Double
                            let n8 = valu?["C"] as? Double
                            let n9 = valu?["C-"] as? Double
                            let n10 = valu?["D+"] as? Double
                            let n11 = valu?["D"] as? Double
                            let n12 = valu?["D-"] as? Double
                            let n13 = valu?["F"] as? Double
                            
                            
                            //let sum = (n1! * 1.0) + (n2! * 2.0) + (n3! * 3.0) + (n4! * 4.0) + (n5! * 5.0)
                           
                            //self.avgrating = (sum)/(n1!+n2!+n3!+n4!+n5!)
                            
                           // self.average.text = "Average rating: \(self.avgrating)"
                            AllVariables.coursegrade = [n1!, n2!, n3!, n4!, n5!, n6!, n7!, n8!, n9!, n10!, n11!, n12!, n13!]
                            
                            self.setChart2(dataPoints: self.gradesAvg, values: AllVariables.coursegrade)
                        })
                    }
                })
                
            }
            
        })
    }
    
    func setChart2(dataPoints: [String], values: [Double]) {
        var dataEntries: [BarChartDataEntry] = []
        
        for i in 0..<dataPoints.count {
            let dataEntry = BarChartDataEntry(x: values[i], y: Double(i))
                dataEntries.append(dataEntry)
        }
        
        let chartDataSet = BarChartDataSet(values: dataEntries, label: "units")
        let chartData = BarChartData(dataSet: chartDataSet)
        barChartView.data = chartData
        
//        var colors: [UIColor] = []
//
//        for _ in 0..<dataPoints.count {
//            let red = Double(arc4random_uniform(256))
//            let green = Double(arc4random_uniform(256))
//            let blue = Double(arc4random_uniform(256))
//
//            let color = UIColor(red: CGFloat(red/255), green: CGFloat(green/255), blue: CGFloat(blue/255), alpha: 1)
//            colors.append(color)
//        }
//
//        BarChartDataSet.colors = colors
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
                            //print("SUM \(sum)")
                            self.avgrating = (sum)/(n1!+n2!+n3!+n4!+n5!)
                            //print("AVG RATING = \(self.avgrating)")
                            
                            self.average.text = "Average rating: \(self.avgrating)"
                            AllVariables.courseratings = [n1!, n2!, n3!, n4!, n5!]
                            //print("THIS: \(AllVariables.courseratings)")
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
    
    func getCourseAvg()
    {
        
        self.ref.child("AllCourseGrades").child(AllVariables.courseselected).observeSingleEvent(of: DataEventType.value, with: {(snapshot) in
            let valu = snapshot.value as? NSDictionary
            print("IMHERE")
            let n1 = valu?["A+"] as? Double
            let n2 = valu?["A"] as? Double
            let n3 = valu?["A-"] as? Double
            let n4 = valu?["B+"] as? Double
            let n5 = valu?["B"] as? Double
            let n6 = valu?["B-"] as? Double
            let n7 = valu?["C+"] as? Double
            let n8 = valu?["C"] as? Double
            let n9 = valu?["C-"] as? Double
            let n10 = valu?["D+"] as? Double
            let n11 = valu?["D"] as? Double
            let n12 = valu?["D-"] as? Double
            let n13 = valu?["F"] as? Double
        
        
        if (n1 == nil || n2 == nil || n3 == nil || n4 == nil || n5 == nil || n6 == nil || n7 == nil || n8 == nil || n9 == nil || n10 == nil || n11 == nil || n12 == nil || n13 == nil) {
            
        }
        else {
            
            let partone = (n1! * 4.0) + (n2! * 4.0)
            let parttwo = (n3! * 3.7) + (n4! * 3.3) + (n5! * 3.0)
            let partthree = (n6! * 2.7) + (n7! * 2.3) + (n8! * 2.0)
            let partfour = (n9! * 1.7) + (n10! * 1.3) + (n11! * 1.0)
            let partfive = (n12! * 0.7) + (n13! * 0.0)
            
            let gradesSum = partone + parttwo + partthree + partfour + partfive
            
            let firsthalf = n1! + n2! + n3! + n4!
            let secondhalf = n5! + n6! + n7! + n8!
            let thirdhalf = n9! + n10! + n11! + n12! + n13!
            
            let avgGrades = (gradesSum)/(firsthalf + secondhalf + thirdhalf)
            
            if (avgGrades >= 0.0 && avgGrades < 0.7)
            {
                self.avgGradeRecLabel.text = "F"
                self.ref.child("CourseGrade").child(AllVariables.courseselected).setValue("F")
                
            } else if (avgGrades >= 0.7 && avgGrades < 1.0)
            {
                self.avgGradeRecLabel.text = "D-"
                self.ref.child("CourseGrade").child(AllVariables.courseselected).setValue("D-")
                
            } else if (avgGrades >= 1.0 && avgGrades < 1.3)
            {
                self.avgGradeRecLabel.text = "D"
                self.ref.child("CourseGrade").child(AllVariables.courseselected).setValue("D")
                
            } else if (avgGrades >= 1.3 && avgGrades < 1.7)
            {
                self.avgGradeRecLabel.text = "D+"
                self.ref.child("CourseGrade").child(AllVariables.courseselected).setValue("D+")
                
            } else if (avgGrades >= 1.7 && avgGrades < 2.0)
            {
                self.avgGradeRecLabel.text = "C-"
                self.ref.child("CourseGrade").child(AllVariables.courseselected).setValue("C-")
                
            } else if (avgGrades >= 2.0 && avgGrades < 2.3)
            {
                self.avgGradeRecLabel.text = "C"
                self.ref.child("CourseGrade").child(AllVariables.courseselected).setValue("C")
                
            } else if (avgGrades >= 2.3 && avgGrades < 2.7)
            {
                self.avgGradeRecLabel.text = "C+"
                self.ref.child("CourseGrade").child(AllVariables.courseselected).setValue("C+")
                
            } else if (avgGrades >= 2.7 && avgGrades < 3.0)
            {
                self.avgGradeRecLabel.text = "B-"
                self.ref.child("CourseGrade").child(AllVariables.courseselected).setValue("B-")
                
            } else if (avgGrades >= 3.0 && avgGrades < 3.3)
            {
                self.avgGradeRecLabel.text = "B"
                self.ref.child("CourseGrade").child(AllVariables.courseselected).setValue("B")
                
            } else if (avgGrades >= 3.3 && avgGrades < 3.7)
            {
                self.avgGradeRecLabel.text = "B+"
                self.ref.child("CourseGrade").child(AllVariables.courseselected).setValue("B+")
                
            } else if (avgGrades >= 3.7 && avgGrades < 4.0)
            {
                self.avgGradeRecLabel.text = "A-"
                self.ref.child("CourseGrade").child(AllVariables.courseselected).setValue("A-")
                
            } else if (avgGrades == 4.0)
            {
                self.avgGradeRecLabel.text = "A+/A"
                self.ref.child("CourseGrade").child(AllVariables.courseselected).setValue("A+/A")
                
            }
            
            //self.avgGradeRecLabel.text = "\(avgGrades)"
            if (avgGrades.isNaN == false) {
                print("THIS IS WHERE I CRASH")
                self.ref.child("CourseAvgGrade").child(AllVariables.courseselected).setValue(avgGrades)
            }
        }
            })
    
    }
    
    
    func getExamDifficulty()
    {
        self.ref.child("ExamReviews").child(AllVariables.courseselected).observeSingleEvent(of: DataEventType.value, with: {(snapshot) in
            let valu = snapshot.value as? NSDictionary
            print("IMHERE")
            let n1 = valu?["Diff1"] as? Double
            let n2 = valu?["Diff2"] as? Double
            let n3 = valu?["Diff3"] as? Double
            let n4 = valu?["Diff4"] as? Double
            let n5 = valu?["Diff5"] as? Double
          if (n1 == nil || n2 == nil || n3 == nil || n4 == nil || n5 == nil)
          {
                
          } else {

            let sum = (n1! * 1.0) + (n2! * 2.0) + (n3! * 3.0) + (n4! * 4.0) + (n5! * 5.0)
            print("SUM \(sum)")
            self.avgrating = (sum)/(n1!+n2!+n3!+n4!+n5!)
            print("AVG RATING = \(self.avgrating)")

            
            AllVariables.examrating = [n1!, n2!, n3!, n4!, n5!]
            print("THIS: \(AllVariables.examrating)")
            self.examDiffLabel.text = "\(self.avgrating)"
            if (self.avgrating.isNaN == false) {
                print("THIS IS WHERE I AM")
                self.ref.child("ExamAverageRating").child(AllVariables.courseselected).setValue(self.avgrating)
            }
            }
        })
    }
    
    
}
