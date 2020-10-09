//
//  ContactusWebVC.swift
//  Club11
//
//  Created by Developer on 12/06/19.
//

import UIKit

class ContactusWebVC: BaseClass {

    @IBOutlet weak var aWebView: UIWebView!
    
    var webUrlToOpen = ""
    var navTitle = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        openWebView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        addNavigationBar(navigationTitle: navTitle, titleContentMode: .center, isNavImageShow: false, isBackButtonShow: true, isWalletButtonShow: false)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    @IBAction func backButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    private func openWebView() {
        let url = URL(string: webUrlToOpen)
        if let urlLink = url {
            let request = URLRequest(url: urlLink)
            aWebView.loadRequest(request)
        }
    }

    override func handleBackButtonAction() {
        self.navigationController?.popViewController(animated: true)
    }


}
