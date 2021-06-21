//
//  ChecklistItem.swift
//  Checklists
//
//  Created by Aleksandr Ataev on 21.05.2021.
//

import Foundation
import UserNotifications

class ChecklistItem: NSObject, Codable {
    
    var text = ""
    var checked: Bool
    var dueDate = Date()
    var shouldRemind = false
    var itemID = -1
    
    func scheduleNotification() {
        removeNotification()
        if shouldRemind && dueDate > Date() {
            let content = UNMutableNotificationContent()
            content.title = "Reminder:"
            content.body = text
            content.sound = UNNotificationSound.default
            let calendar = Calendar(identifier: .gregorian)
            let components = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: dueDate)
            let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: false)
            let request = UNNotificationRequest(identifier: "\(itemID)", content: content, trigger: trigger)
            let center = UNUserNotificationCenter.current()
            center.add(request)
        }
    }
    
    func removeNotification() {
        let center = UNUserNotificationCenter.current()
        center.removePendingNotificationRequests(withIdentifiers: ["\(itemID)"])
    }
    
    init(text: String, checked: Bool = false) {
        self.text = text
        self.checked = checked
        itemID = DataModel.nextChecklistItemID()
        super.init()
    }
    
    deinit {
        removeNotification()
    }
}
