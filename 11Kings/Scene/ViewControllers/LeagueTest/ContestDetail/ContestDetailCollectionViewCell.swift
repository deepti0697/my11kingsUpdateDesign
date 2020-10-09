//
//  MyContestCollectionViewCell.swift
//  TeamBanao
//
//  Created by Developer on 23/02/19.
//  Copyright © 2019 Rickey_iDev. All rights reserved.
//

import UIKit

class ContestDetailCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var aTableView: UITableView!
//    @IBOutlet weak var aNoDataLabel: UILabel!
    var winnerBreakupArr = [Any]() {
        didSet {
            aTableView.reloadDataInMainQueue()
        }
    }
    var selectedContest: ((MyContestReponse, HomeType) -> Void) = { _, _ in }
    var contestData = [MyContestReponse]()
        
    
    var didSelectClousure: ((Int) -> Void) = { _ in }
    var homeType: HomeType = .live

    override func awakeFromNib() {
        super.awakeFromNib()
        aTableView.delegate = self
        aTableView.dataSource = self
        registerCell()
    }
    
    @objc private func refreshWeatherData(_ sender: Any) {
        aTableView.reloadDataInMainQueue()
    }
    
    func registerCell() {
           aTableView.register(UINib(nibName: WinnereBreakUpTVCell.identifier(), bundle: nil), forCellReuseIdentifier: WinnereBreakUpTVCell.identifier())
       }


    func showNoDataLabel(show: Bool, text: String) {
//        aNoDataLabel.isHidden = !show
//        aNoDataLabel.text = text
    }
   
}

extension ContestDetailCollectionViewCell: UITableViewDelegate, UITableViewDataSource {

   func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 30
    }
  
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return winnerBreakupArr.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: WinnereBreakUpTVCell.identifier(), for: indexPath) as! WinnereBreakUpTVCell
            cell.configureCell(data: winnerBreakupArr[indexPath.item])
            return cell
        }
        
    
    }

