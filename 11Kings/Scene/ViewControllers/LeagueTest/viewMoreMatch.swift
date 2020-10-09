//
//  viewMoreMatch.swift
//  DreamTeam
//
//  Created by Test on 15/05/20.
//  Copyright © 2020 Macbook. All rights reserved.
//

import UIKit
protocol sendDatatoDetail {
    func check()
}
class viewMoreMatch: UITableViewCell {

     var captainClooseClouser: (() -> Void) = {}
    @IBOutlet weak var openDetailLeague: UIButton!
    var delegate:sendDatatoDetail?
    
    @IBAction func openDetailLeague(_ sender: Any) {
        captainClooseClouser()
        self.delegate?.check()
    }
    
}
