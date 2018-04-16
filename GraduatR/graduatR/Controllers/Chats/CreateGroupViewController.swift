//
//  CreateGroupViewController.swift
//  graduatR
//
//  Created by Dhriti Chawla on 4/16/18.
//  Copyright © 2018 Simona Virga. All rights reserved.
//

import UIKit

class CreateGroupViewController: UIViewController, UITableViewDelegate {

    var viewModel = ViewModel()
    @IBOutlet weak var createbutton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBAction func create(_ sender: Any) {
        tableView.reloadData()
         print(viewModel.selectedItems.map { $0.title })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView?.allowsMultipleSelection = true
        tableView?.dataSource = viewModel as! UITableViewDataSource
        // set delegate to self
        tableView?.delegate = self
    }


}

//extension ViewController: UITableViewDelegate {
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        viewModel.items[indexPath.row].isSelected = true
//    }
//    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
//        viewModel.items[indexPath.row].isSelected = false
//    }
//}
