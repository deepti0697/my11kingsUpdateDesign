//
//  ReferAndEarnViewController.swift
//  FantasyCricket
//
//  Created by Developer on 20/05/19.
//  Copyright © 2019 Rickey_iDev. All rights reserved.
//

import UIKit

class ReferAndEarnViewController: BaseClass {

    @IBOutlet weak var aCopyCodeBytton: UIButton!
   // @IBOutlet weak var aLabel: UILabel!
    @IBOutlet weak var aCodeLabel: UILabel!
    @IBOutlet weak var aShareButton: UIButton!
    @IBOutlet weak var aCouponView: UIView!
    
    var referCode = " "
    
    override func viewDidLoad() {
        super.viewDidLoad()
        aCouponView.setCornerRadius(value: 10)
        aShareButton.setCornerRadius(value: 10)
       // aLabel.setCornerRadius(value: 10)
        if let heroObject = UserDefaults.standard.value(forKey: "loginData") as? NSData {
        
        let UserDic = NSKeyedUnarchiver.unarchiveObject(with: heroObject as Data) as! NSDictionary
        referCode = UserDic.value(forKey: "refercode") as? String ?? " "
        aCopyCodeBytton.isHidden = referCode == " " ? true : false
        aCouponView.setDashedBorderView(color: .lightGray)
        aCodeLabel.text = referCode
    }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    @IBAction func aShareButtonAction(_ sender: Any) {
        
        let textToShare = [ "Here's ₹500 to play fantasy cricket with me on My11Kings and Also Earn Unlimited Real Cash with referred Friend for Lifetime . Click \(APP_DEL.appStoreUrl) to download My11Kings app & use My code \(referCode) To Register" ]
        let activityViewController = UIActivityViewController(activityItems: textToShare, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        activityViewController.excludedActivityTypes = [ UIActivity.ActivityType.airDrop, UIActivity.ActivityType.postToFacebook, UIActivity.ActivityType.mail ]
                self.present(activityViewController, animated: true, completion: nil)
    }
    
    @IBAction func copyButtonAction(_ sender: Any) {
        UIPasteboard.general.string = referCode
    }
    
    override func handleBackButtonAction() {
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func backtoMore(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
