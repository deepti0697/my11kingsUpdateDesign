//
//  PlayerPointTableViewCell.swift
//  DreamTeam
//
//  Created by Test on 04/06/20.
//  Copyright © 2020 Macbook. All rights reserved.
//

import UIKit

class PlayerPointTableViewCell: UITableViewCell {

  
    @IBOutlet weak var backGroundImage: UIImageView!
    @IBOutlet weak var yourPlayer: UIImageView!
    @IBOutlet weak var topPlayer: UIImageView!
    @IBOutlet weak var point: UILabel!
    @IBOutlet weak var selectedBy: UILabel!
    @IBOutlet weak var playerName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

       
    }
    func configureCell(response:playerMatchPoint) {
        playerName.text = response.player_name
        if response.is_topplayer == 1 {
            topPlayer.image = #imageLiteral(resourceName: "Group 8988")
        }
        else {
               topPlayer.image = nil
        }
        if response.isSelected == 1 {
                   yourPlayer.image = #imageLiteral(resourceName: "Group 8985")
               }
        else {
            yourPlayer.image = nil
        }
        selectedBy.text = "\(response.selected_by ?? "0") %"
        point.text = response.total_points
        
    }
    

}
