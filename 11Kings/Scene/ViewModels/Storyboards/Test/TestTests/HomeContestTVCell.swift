//
//  HomeContestTVCell.swift
//  TeamBanao
//
//  Created by Developer on 18/03/19.
//  Copyright © 2019 Rickey_iDev. All rights reserved.
//

import UIKit

class HomeContestTVCell: UITableViewCell {
    
    @IBOutlet weak var aFinishedButton: UIButton!
    @IBOutlet weak var aLiveButton: UIButton!
    @IBOutlet weak var aUpcommingButton: UIButton!
    @IBOutlet weak var aSelectionView: UIView!
    @IBOutlet weak var aCollectionView: UICollectionView!
    
    var selectedContest: ((LiveMatchResponse, String, HomeType) -> Void) = { _, _, _  in }
    var fixtureData: [LiveMatchResponse]?
    var liveData: [LiveMatchResponse]? {
        didSet {
            aCollectionView.reloadDataInMainQueue()
        }
    }
    var resultData: [LiveMatchResponse]? {
        didSet {
            aCollectionView.reloadDataInMainQueue()
        }
    }
    
    var visibleCellIndex = 0 {
        didSet {
            moveSelectionView(index: visibleCellIndex)
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        registerCell()
        getFixturesData()
        getLiveData()
        getResultData()
    }
    
    func registerCell() {
        aCollectionView.register(UINib(nibName: HomeContestCVCell.identifier(), bundle: nil), forCellWithReuseIdentifier: HomeContestCVCell.identifier())
    }
    
    @IBAction func liveButtonAction(_ sender: Any) {
        aCollectionView.scrollToItem(at: IndexPath(item: 1, section: 0), at: .centeredHorizontally, animated: true)
        moveSelectionView(index: 1)
    }
    
    @IBAction func UpcomingButtonAction(_ sender: Any) {
        aCollectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .centeredHorizontally, animated: true)
        moveSelectionView(index: 0)
    }
    
    @IBAction func FinishedButtonAction(_ sender: Any) {
        aCollectionView.scrollToItem(at: IndexPath(item: 2, section: 0), at: .centeredHorizontally, animated: true)
        moveSelectionView(index: 2)
    }
    
    fileprivate func moveSelectionView(index: Int) {
        let selectionViewWidth = Int(ScreenSize.SCREEN_WIDTH / 3)
        switch index {
        //Live
        case 1:
            aUpcommingButton.setTitleColor(.black, for: .normal)
            aFinishedButton.setTitleColor(.black, for: .normal)
            UIView.animate(withDuration: 0.2) {
                self.aSelectionView.frame = CGRect(x: selectionViewWidth, y: 35, width: selectionViewWidth, height: 5)
                self.aLiveButton.setTitleColor(.orange, for: .normal)
            }
        //upcoming
        case 0:
            aLiveButton.setTitleColor(.black, for: .normal)
            aFinishedButton.setTitleColor(.black, for: .normal)
            UIView.animate(withDuration: 0.2) {
                self.aSelectionView.frame = CGRect(x: 0, y: 35, width: selectionViewWidth, height: 5)
                self.aUpcommingButton.setTitleColor(.orange, for: .normal)
            }
        //Result
        case 2:
            aLiveButton.setTitleColor(.black, for: .normal)
            aUpcommingButton.setTitleColor(.black, for: .normal)
            UIView.animate(withDuration: 0.2) {
                self.aSelectionView.frame = CGRect(x: selectionViewWidth * index, y: 35, width: selectionViewWidth, height: 5)
                self.aFinishedButton.setTitleColor(.orange, for: .normal)
            }
        default:
            break
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        visibleCellIndex = Utility.findCenterCellIndex(collectionView: aCollectionView)
    }
    
    func getFixturesData() {
        let headers = [
            "content-type": "application/json",
            "cache-control": "no-cache"
        ]
        
        NetworkManager.post_Request(urlService: kUpcomingMatchURL, param: nil, head: headers) { (response) in
            do {
                if response != nil {
                    let responseData = try JSONSerialization.data(withJSONObject: response!, options: [])
                    let responseModel = try JSONDecoder().decode([LiveMatchResponse].self, from: responseData)
                    self.fixtureData = responseModel
                }
            } catch {
                Loader.showAlert(message: "Status code 500: server internal error")
            }
        }
    }
    
    func getLiveData() {
        let headers = [
            "content-type": "application/json",
            "cache-control": "no-cache"
        ]
        
        NetworkManager.post_Request(urlService: kLiveMatchURL, param: nil, head: headers) { (response) in
            do {
                if response != nil {
                    let responseData = try JSONSerialization.data(withJSONObject: response!, options: [])
                    let responseModel = try JSONDecoder().decode([LiveMatchResponse].self, from: responseData)
                    self.liveData = responseModel
                }
            } catch {
                Loader.showAlert(message: "Status code 500: server internal error")
            }
        }
    }
    
    func getResultData() {
        let headers = [
            "content-type": "application/json",
            "cache-control": "no-cache"
        ]
        
        NetworkManager.post_Request(urlService: kResultsMatchURL, param: nil, head: headers) { (response) in
            do {
                if response != nil {
                    let responseData = try JSONSerialization.data(withJSONObject: response!, options: [])
                    let responseModel = try JSONDecoder().decode([LiveMatchResponse].self, from: responseData)
                    self.resultData = responseModel
                }
            } catch {
                Loader.showAlert(message: "Status code 500: server internal error")
            }
        }
    }
    
}

extension HomeContestTVCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeContestCVCell.identifier(), for: indexPath) as! HomeContestCVCell
        
        switch indexPath.item {
        //upcoming
        case 0:
            cell.homeType = .upcomming
            if var fixData = fixtureData {
                if fixData.count > 0 {
//                    fixData = Sorting().sortingOfLeagueOfTime(arrayToSort: fixData as NSArray) as! [LiveMatchResponse]
                    cell.contestData = fixData
                    cell.showNoDataLabel(show: false, text: "")
                } else {
                    cell.showNoDataLabel(show: true, text: "No Upcomming Match Found")
                }
            } else {
                cell.showNoDataLabel(show: true, text: "No Upcomming Match Found")
            }
        //live
        case 1:
            cell.homeType = .live
            if var livData = liveData {
                if livData.count > 0 {
//                    livData = Sorting().sortingOfLeagueOfTime(arrayToSort: livData as NSArray) as! [LiveMatchResponse]
                    cell.contestData = livData
                    cell.showNoDataLabel(show: false, text: "")
                } else {
                    cell.showNoDataLabel(show: true, text: "No Live Match Found")
                }
            } else {
                cell.showNoDataLabel(show: true, text: "No Live Match Found")
            }
        //result
        case 2:
            cell.homeType = .result
            if var resData = resultData {
                if resData.count > 0 {
//                    resData = Sorting().sortingOfLeagueOfTime(arrayToSort: resData as NSArray) as! [LiveMatchResponse]
                    cell.contestData = resData
                    cell.showNoDataLabel(show: false, text: "")
                } else {
                    cell.showNoDataLabel(show: false, text: "No Finished Match Found")
                }
            } else {
                cell.showNoDataLabel(show: false, text: "No Finished Match Found")
            }
        default:
            break
        }
        cell.selectedContest = {[weak self] contest, cFormat, homeType   in
            if let strongSelf = self {
                strongSelf.selectedContest(contest, cFormat, homeType)
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: aCollectionView.frame.width, height: aCollectionView.frame.height)
    }
    
}
