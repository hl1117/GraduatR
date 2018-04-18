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

