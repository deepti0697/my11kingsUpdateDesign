//
//  SelectionRuleForKabaddi.swift
//  DreamTeam
//
//  Created by Test on 13/06/20.
//  Copyright © 2020 Macbook. All rights reserved.
//

import UIKit

class SelectionRuleForKabaddi: UIView {

  
    var closeButtonClouser: (() -> Void) = { }
      @IBOutlet weak var animateView: UIView!
      
      @IBOutlet weak var closeBtn:UIButton!

      @IBAction func closeAction(_ sender: Any) {
          closeButtonClouser()
      }

}
