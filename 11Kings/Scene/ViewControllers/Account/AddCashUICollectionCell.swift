//
//  AddCashUICollectionCell.swift
//  DreamTeam
//
//  Created by Test on 31/05/20.
//  Copyright © 2020 Macbook. All rights reserved.
//

import Foundation
import UIKit
protocol  openAddMoney {
    func openMoneVc(bonous:String,deposit:String,winning:String)
    func openWithdraw()
    func openInvestMent()
}

class AddCashUICollectionCell : UICollectionViewCell {
    
    var contestdata = [BalanceModel]()
    @IBOutlet weak var totalBalance: UILabel!
    @IBOutlet weak var cashBonous: UILabel!
    @IBOutlet weak var winningBalance: UILabel!
    @IBOutlet weak var utilizedBalance: UILabel!
    @IBOutlet weak var addCash: UIButton!
    @IBOutlet weak var withdrawCash: UIButton!
    var cash = ""
    var bonous = ""
    var winnig = ""
    var delegate:openAddMoney?

    override class func awakeFromNib() {
      
//        setup(balanceResponse:contestdata!)
    }
    func setup(contestdata:[BalanceModel]){
        if contestdata.count > 0 {
    cashBonous.text = contestdata[0].bonus ?? "0.0"
    totalBalance.text = "\(contestdata[0].totalamount ?? "0.0")"
    winningBalance.text = contestdata[0].winning ?? "0.0"
    utilizedBalance.text = contestdata[0].balance
    bonous = contestdata[0].bonus ?? "0.0"
            cash = "\(contestdata[0].totalamount ?? "0.0")"
            winnig = contestdata[0].winning ?? "0.0"
    }
    }
    @IBAction func withdrawCash(_ sender: Any) {
        self.delegate?.openWithdraw()
    }
    
    @IBAction func AddCash(_ sender: Any) {
        self.delegate?.openMoneVc(bonous:bonous , deposit: cash , winning: winnig )
    }
    
    @IBAction func openInvestMentAnalysis(_ sender: Any) {
        self.delegate?.openInvestMent()
    }
    
}
