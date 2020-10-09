//
//  HowToPlayViewController.swift
//  FantasyCricket
//
//  Created by Developer on 25/05/19.
//

import UIKit
import WebKit
class TestimonialViewController: BaseClass {
   
    
    @IBOutlet weak var aWebView: WKWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        openWebView()
    }
    
    private func openWebView() {
        let url = URL(string: webBaseURL + testimonial)
        if let urlLink = url {
            let request = URLRequest(url: urlLink)
            aWebView.load(request)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        addNavigationBar(navigationTitle: "Testimonials", titleContentMode: .left, isNavImageShow: false, isBackButtonShow: true, isWalletButtonShow: false, isBinButtonShow: false)
        self.navigationController?.isNavigationBarHidden = true
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
    }

    override func handleBackButtonAction() {
        self.navigationController?.popViewController(animated: true)
    }
}
