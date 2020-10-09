//
//  WinnerBreakupView.swift
//  Club11
//
//  Created by Developer on 29/05/19.
//

import UIKit

class WinnerBreakupView: UIView {

    @IBOutlet weak var aTotalAmountLabel: UILabel!
    @IBOutlet weak var aTableView: UITableView!
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    
    var closeButtonClouser: (() -> Void) = { }
    var winnerBreakupArr = [Any]()
    
    var totalAmmount = 0.0 {
        didSet {
            setData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        registerCell()
        aTotalAmountLabel.text = "\(kRupeeIcon)\(totalAmmount)"
    }
    
    func setData() {
        if aTotalAmountLabel != nil {
            aTotalAmountLabel.text = "\(kRupeeIcon)\(totalAmmount)"
        }
    }
    
    func registerCell() {
        aTableView.register(UINib(nibName: WinnereBreakUpTVCell.identifier(), bundle: nil), forCellReuseIdentifier: WinnereBreakUpTVCell.identifier())
    }
    
    
    @IBAction func closeButtonAction(_ sender: Any) {
        closeButtonClouser()
    }

}

// MARK: Table View Method
extension WinnerBreakupView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return winnerBreakupArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: WinnereBreakUpTVCell.identifier(), for: indexPath) as! WinnereBreakUpTVCell
        cell.configureCell(data: winnerBreakupArr[indexPath.item])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 30
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        self.tableViewHeight.constant = self.aTableView.contentSize.height
    }
}
