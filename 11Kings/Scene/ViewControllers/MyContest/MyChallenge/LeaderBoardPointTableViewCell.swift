//
//  LeaderBoardPointTableViewCell.swift
//  11Kings
//
//  Created by uu on 17/08/20.
//  Copyright © 2020 Macbook. All rights reserved.
//

import UIKit

class LeaderBoardPointTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    @IBOutlet weak var playerteamName: UILabel!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
  
    @IBOutlet weak var cSelectedBy: UILabel!
    @IBOutlet weak var yourPlayer: UIImageView!
    @IBOutlet weak var playerImageView: UIImageView!
    @IBOutlet weak var point: UILabel!
    @IBOutlet weak var selectedBy: UILabel!
    @IBOutlet weak var playerName: UILabel!
    

    
    func configureCell(response:playerMatchPoint) {
        cSelectedBy.text = "\(response.captain_by ?? 0)%"
        playerName.text = response.player_name
        playerteamName.text = response.team ?? ""
        selectedBy.text = "\(response.selected_by ?? "0")%"
        point.text = response.total_points
        
    }
    

}
