//
//  ViewModel.swift
//  graduatR
//
//  Created by Dhriti Chawla on 4/16/18.
//  Copyright © 2018 Simona Virga. All rights reserved.
//

import Foundation



class ViewModel {
    var items = [ViewModelItem]()
    
    var selectedItems: [ViewModelItem] {
        return items.filter { return $0.isSelected }
    }
    
    let dataArray = [File(title: "Swifts"),
                     File(title: "Swifta"),
                     File(title: "Swiftr"),
                     File(title: "Swifte"),
                     File(title: "Swifty"),
                     File(title: "Swifti"),
                     File(title: "Swifto"),
                     File(title: "Swiftu")]
    init() {
        items = dataArray.map { ViewModelItem(item: $0) }
    }
    
    
}

//extension ViewModel: UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return items.count  // (1)
//    }
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        if let cell = tableView.dequeueReusableCell(withIdentifier: CustomCell.identifier, for: indexPath) as? CustomCell {
//            cell.item = items[indexPath.row] // (2)
//            // select/deselect the cell
//            if items[indexPath.row].isSelected {
//                tableView.selectRow(at: indexPath, animated: false, scrollPosition: .none) // (3)
//            } else {
//                tableView.deselectRow(at: indexPath, animated: false) // (4)
//            }
//            return cell
//        }
//        return UITableViewCell()
//    }
//}
