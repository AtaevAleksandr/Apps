//
//  HighScoresTableViewController.swift
//  Bullseye
//
//  Created by Aleksandr Ataev on 09.05.2021.
//  Copyright © 2021 Razeware. All rights reserved.
//

import UIKit
import WebKit

class AboutViewController: UIViewController {
    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let url = Bundle.main.url(forResource: "BullsEye", withExtension: "html") {
            let request = URLRequest(url: url)
            webView.load(request)
        }
    }
    
    @IBAction func close() {
        dismiss(animated: true, completion: nil)
    }
}
