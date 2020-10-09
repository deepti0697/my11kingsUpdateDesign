//
//  PlayingHistoryCollectionViewCell.swift
//  DreamTeam
//
//  Created by Test on 01/06/20.
//  Copyright © 2020 Macbook. All rights reserved.
//

import UIKit

class PlayingHistoryCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var matchPlayedLbl: UILabel!
    
    @IBOutlet weak var contestPlayedLbl: UILabel!
    
    @IBOutlet weak var contestWin: UILabel!
    
    @IBOutlet weak var totalWinning: UILabel!
    
    var playHistory:playingHistory?
    func configure(playing:playingHistory) {
        self.totalWinning.text =   "\(playing.total_winning ?? 0.0)"
        self.matchPlayedLbl.text = "\(playing.total_match_play ?? 0)"
        self.contestPlayedLbl.text = "\(playing.total_league_play ?? 0)"
        self.contestWin.text = "\(playing.total_contest_win ?? 0)"
        
    }
}
