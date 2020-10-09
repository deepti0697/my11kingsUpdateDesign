//
//  NavigationBarView.swift
//  Club11
//
//  Created by Developer on 26/05/19.
//

import UIKit

class NavigationBarView: UIView {

    @IBOutlet weak var upperView: UIView!
    @IBOutlet weak var binUIView: UIView!
    @IBOutlet weak var binButton: UIButton!
    @IBOutlet weak var aImageView: UIImageView!
    @IBOutlet weak private var aLeftTitleLabel: UILabel!
    @IBOutlet weak private var aCenterTitleLabel: UILabel!
    @IBOutlet weak private var aBackButton: UIButton!
    @IBOutlet weak private var aWalletButton: UIButton!
    
    weak var baseControllerObj: BaseClass?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        aWalletButton.isExclusiveTouch = true
        aBackButton.isExclusiveTouch = true
//        let newLayer = CAGradientLayer()
//        newLayer.colors = [UIColor(red: 255, green: 253, blue: 166).cgColor,UIColor(red: 172, green: 135, blue: 54).cgColor]
//        newLayer.frame = upperView.frame
//        upperView.layer.addSublayer(newLayer)
    }
    
    func setNavigtionTitle(title: String, contentMode: UIView.ContentMode) {
        if contentMode == .left {
            aLeftTitleLabel.text = title
            aCenterTitleLabel.text = ""
            aImageView.image = UIImage(named: "sample")
        } else {
            aCenterTitleLabel.text = title
            aLeftTitleLabel.text = ""
            aImageView.image = UIImage(named: "")
        }
    }
    
    func showNaviGationTitle(show: Bool) {
        aCenterTitleLabel.isHidden = show
        aLeftTitleLabel.isHidden = show
    }
    
    func showNaviGationBackButton(show: Bool) {
        aBackButton.isHidden = show
        aBackButton.tintColor = .white
    }
    
    @IBAction func binButtonAction(_ sender: Any) {
        baseControllerObj?.handleBinButtonAction()
    }
    func showNaviGationNotificationButton(show: Bool) {
        aWalletButton.isHidden = show
    }
    func showNaviGationNotificationBinButton(show: Bool) {
        binButton.isHidden = show
        binUIView.isHidden = show
        
    }
    @IBAction func walletButtonAction(_ sender: UIButton) {
        baseControllerObj?.handleWalletButtonAction()
    }
    
    @IBAction func backButtonAction(_ sender: UIButton) {
        baseControllerObj?.handleBackButtonAction()
    }

}
