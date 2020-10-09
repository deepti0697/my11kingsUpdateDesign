//
//  HomeContestCVCell.swift
//  TeamBanao
//
//  Created by Developer on 18/03/19.
//  Copyright © 2019 Rickey_iDev. All rights reserved.
//

import UIKit

class HomeContestCVCell: UICollectionViewCell {
    
    @IBOutlet weak var aNoDataLabel: UILabel!
    @IBOutlet weak var aTableView: UITableView!
    
    var selectedContest: ((LiveMatchResponse, String, HomeType) -> Void) = { _, _, _  in }
    var contestData = [LiveMatchResponse]() {
        didSet {
            aTableView.reloadDataInMainQueue()
        }
    }
    var homeType: HomeType = .live
    
    override func awakeFromNib() {
        super.awakeFromNib()
        registerCell()
    }
    
    @objc private func refreshWeatherData(_ sender: Any) {
        aTableView.reloadDataInMainQueue()
    }
    
    fileprivate func registerCell() {
        aTableView.register(UINib(nibName: ContestTVCell.identifier(), bundle: nil), forCellReuseIdentifier:  ContestTVCell.identifier())
    }
    
    func showNoDataLabel(show: Bool, text: String) {
        aNoDataLabel.isHidden = !show
        aNoDataLabel.text = text
    }
}

extension HomeContestCVCell: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contestData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:  ContestTVCell.identifier(), for: indexPath) as! ContestTVCell
        cell.homeType = homeType
        cell.configureMyContestCell(data: contestData[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedContest(contestData[indexPath.row], contestData[indexPath.row].format ?? "", homeType)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return kContestTVCellHeight
    }
}
