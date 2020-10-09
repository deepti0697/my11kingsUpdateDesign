//
//  ToastView.swift
//  DreamTeam
//
//  Created by Test on 02/06/20.
//  Copyright © 2020 Macbook. All rights reserved.
//

import UIKit

class RuleView: UIView {
     var closeButtonClouser: (() -> Void) = { }
    @IBOutlet weak var animateView: UIView!
    
    @IBOutlet weak var closeBtn:UIButton!
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
      @IBAction func closeButtonAction(_ sender: Any) {
           closeButtonClouser()
    }
}
