//
//  PlayerStatusView.swift
//  11Kings
//
//  Created by uu on 02/07/20.
//  Copyright © 2020 Macbook. All rights reserved.
//

import Foundation
import UIKit
class PlayerStatusView : UIView {
    
    var closeButtonClouser: (() -> Void) = { }
    var notPlayingClosure: ((Bool) -> Void) = { _ in }
    var playingClosure: ((Bool) -> Void) = { _ in }
    @IBOutlet weak var playingBlank: UIImageView!
    @IBOutlet weak var notPlayingBlank: UIImageView!
    @IBOutlet weak var playing: UIButton!
    
    @IBAction func playingAction(_ sender: UIButton) {
        playingBlank.image = #imageLiteral(resourceName: "RedCircle")
         notPlayingBlank.image = #imageLiteral(resourceName: "path Blank")
        playingClosure(true)
    }

    @IBAction func closeView(_ sender: Any) {
        closeButtonClouser()
    }
    
    @IBAction func notPlaying(_ sender: Any) {
        notPlayingBlank.image = #imageLiteral(resourceName: "RedCircle")
        playingBlank.image = #imageLiteral(resourceName: "path Blank")
        notPlayingClosure(false)
    }
    
}
