//
//  ViewModelItem.swift
//  graduatR
//
//  Created by Dhriti Chawla on 4/16/18.
//  Copyright © 2018 Simona Virga. All rights reserved.
//

import Foundation

class ViewModelItem {
    private var item: File
    var isSelected = false
    var title: String {
        return item.title
    }
    init(item: File) {
        self.item = item
        
    }
}

