//
//  Checklist.swift
//  Checklists
//
//  Created by Aleksandr Ataev on 23.05.2021.
//

import UIKit

class Checklist: NSObject, Codable {
    
    var name = ""
    var items = [ChecklistItem]()
    var iconName = ""
    
    func countUncheckedItems() -> Int {
        var count = 0
        for item in items where !item.checked {
            count += 1
        }
        return count
    }
    
    init(name: String, iconName: String = "No Icon") {
        self.name = name
        self.iconName = iconName
        super.init()
    }
}

