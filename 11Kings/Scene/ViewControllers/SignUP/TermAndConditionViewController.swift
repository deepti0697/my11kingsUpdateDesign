//
//  TermAndConditionViewController.swift
//  DreamTeam
//
//  Created by Test on 13/05/20.
//  Copyright © 2020 Macbook. All rights reserved.
//

import UIKit
import WebKit
class TermAndConditionViewController: BaseClass {

    @IBOutlet weak var aWebView: WKWebView!
    override func viewDidLoad() {
            super.viewDidLoad()
            openWebView()
        }
        
        private func openWebView() {
            let url = URL(string:webBaseURL + kTermsConditionURl)
            if let urlLink = url {
                let request = URLRequest(url: urlLink)
                aWebView.load(request)
            }
        }
        
        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            addNavigationBar(navigationTitle: "Terms & Conditions", titleContentMode: .center, isNavImageShow: false, isBackButtonShow: true, isWalletButtonShow: false, isBinButtonShow: false)
        }

        override func handleBackButtonAction() {
            self.navigationController?.popViewController(animated: true)
        }
    }
