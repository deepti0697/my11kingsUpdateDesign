//
//  FQsViewController.swift
//  DreamTeam
//
//  Created by Test on 28/05/20.
//  Copyright © 2020 Macbook. All rights reserved.
//

import UIKit
import WebKit
class FQsViewController: BaseClass {

    @IBOutlet weak var aWebView: WKWebView!
     override func viewDidLoad() {
            super.viewDidLoad()
            openWebView()
        }
        
        private func openWebView() {
            let url = URL(string: webBaseURL + fqs)
            if let urlLink = url {
                let request = URLRequest(url: urlLink)
                aWebView.load(request)
            }
        }
        
        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            self.navigationController?.isNavigationBarHidden = true
        }
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
    }

    
    @IBAction func backButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    }
