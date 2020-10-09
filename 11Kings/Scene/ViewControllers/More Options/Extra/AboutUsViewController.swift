//
//  AboutUsViewController.swift
//  FantasyCricket
//
//  Created by Developer on 25/05/19.
//

import UIKit
import WebKit
class AboutUsViewController: BaseClass {

   
    
    @IBOutlet weak var webivew: WKWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        openWebView()
    }
    
    private func openWebView() {
        let url = URL(string: webBaseURL + kAboutUsURl)
        if let urlLink = url {
            let request = URLRequest(url: urlLink)
            webivew.load(request)
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
    
    override func handleBackButtonAction() {
        self.navigationController?.popViewController(animated: true)
    }
}
