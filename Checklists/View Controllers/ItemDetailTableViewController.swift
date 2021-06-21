//
//  ItemDetailTableViewController.swift
//  Checklists
//
//  Created by Aleksandr Ataev on 21.05.2021.
//

import UIKit
import UserNotifications

protocol ItemDetailTableViewControllerDelegate: AnyObject {
    func itemDetailTableViewControllerDidCancel(_ controller: ItemDetailTableViewController)
    func itemDetailTableViewController(_ controller: ItemDetailTableViewController, didFinishAdding item: ChecklistItem)
    func itemDetailTableViewController(_ controller: ItemDetailTableViewController, didFinishEditing item: ChecklistItem)
}

class ItemDetailTableViewController: UITableViewController, UITextFieldDelegate {
    
    var itemToEdit: ChecklistItem?
    weak var delegate: ItemDetailTableViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
        
        if let item = itemToEdit {
            title = "Edit item"
            textField.text = item.text
            doneBarButton.isEnabled = true
            shouldRemindSwitch.isOn = item.shouldRemind
            datepicker.date = item.dueDate
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        textField.becomeFirstResponder()
    }
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var doneBarButton: UIBarButtonItem!
    @IBOutlet var shouldRemindSwitch: UISwitch!
    @IBOutlet var datepicker: UIDatePicker!
    
    // MARK: - Table View Delegates
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return nil
    }
    
    // MARK: - Actions
    @IBAction func cancel() {
        delegate?.itemDetailTableViewControllerDidCancel(self)
    }
    
    @IBAction func done() {
        if let item = itemToEdit {
            item.text = textField.text!
            item.shouldRemind = shouldRemindSwitch.isOn
            item.dueDate = datepicker.date
            item.scheduleNotification()
            delegate?.itemDetailTableViewController(self, didFinishEditing: item)
        } else {
            let item = ChecklistItem(text: textField.text!, checked: false)
            item.shouldRemind = shouldRemindSwitch.isOn
            item.dueDate = datepicker.date
            item.scheduleNotification()
            delegate?.itemDetailTableViewController(self, didFinishAdding: item)
        }
    }
    
    @IBAction func shouldRemindToggled(_ switchControl: UISwitch) {
        textField.resignFirstResponder()
        if switchControl.isOn {
            let center = UNUserNotificationCenter.current()
            center.requestAuthorization(options: [.alert, .sound]) { _, _ in
            }
        }
    }
    
    // MARK: - Text Field Delegates
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let oldText = textField.text!
        let stringRange = Range(range, in: oldText)!
        let newText = oldText.replacingCharacters(in: stringRange, with: string)
        doneBarButton.isEnabled = !newText.isEmpty
        return true
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        doneBarButton.isEnabled = false
        return true
    }
}
