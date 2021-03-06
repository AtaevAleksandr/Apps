//
//  EditHighScoreTableViewController.swift
//  Bullseye
//
//  Created by Aleksandr Ataev on 10.05.2021.
//  Copyright © 2021 Razeware. All rights reserved.
//

import UIKit

protocol EditHighScoreTableViewControllerDelegate: AnyObject {
    func editHighScoreTableViewControllerDidCancel(_ controller: EditHighScoreTableViewController)
    func editHighScoreTableViewController(_ controller: EditHighScoreTableViewController, didFinishEditing item: HighScoreItem)
}

class EditHighScoreTableViewController: UITableViewController, UITextFieldDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        textField.becomeFirstResponder()
        textField.text = highScoreItem.name
    }
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var doneBarButton: UIBarButtonItem!
    
    weak var delegate: EditHighScoreTableViewControllerDelegate?
    var highScoreItem: HighScoreItem!
    
    // MARK: - Actions
    @IBAction func cancel() {
        delegate?.editHighScoreTableViewControllerDidCancel(self)
    }
    @IBAction func done() {
        highScoreItem.name = textField.text!
        delegate?.editHighScoreTableViewController(self, didFinishEditing: highScoreItem)
    }
    
    // MARK:- Table View Delegates
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return nil
    }
    
    // MARK: - Text Field Delegates
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let oldText = textField.text!
        let stringRange = Range(range, in: oldText)!
        let newText = oldText.replacingCharacters(in: stringRange, with: string)
        doneBarButton.isEnabled = !newText.isEmpty
        return true
    }
}
