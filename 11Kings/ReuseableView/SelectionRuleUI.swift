//
//  SelectionRuleUI.swift
//  DreamTeam
//
//  Created by Test on 07/06/20.
//  Copyright © 2020 Macbook. All rights reserved.
//

import Foundation
import UIKit
class SelectionRuleUI:UIView {
    var closeButtonClouser: (() -> Void) = { }
    @IBOutlet weak var animateView: UIView!
    
    @IBOutlet weak var closeBtn:UIButton!

    @IBAction func closeAction(_ sender: Any) {
        closeButtonClouser()
    }
   private func loadViewFromNib() {
//     animateView.autoresizingMask = true
    }
}
