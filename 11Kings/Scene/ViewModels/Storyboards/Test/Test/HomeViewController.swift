//
//  TBHomeViewController.swift
//  TeamBanao
//
//  Created by Developer on 02/02/19.
//  Copyright © 2019 Rickey_iDev. All rights reserved.
//

import UIKit

class HomeViewController: BaseViewController {
    
    @IBOutlet weak private var aHomeTableView: UITableView!
    
    var refreshControl = UIRefreshControl()
    private var bannerDataArray = [BannerResponse]() {
        didSet {
            aHomeTableView.reloadDataInMainQueue()
        }
    }
    
    var userDetailsArray = [UserDetailsResponse]() {
        didSet {
            configureUserFullData()
        }
    }
    var panDetailsArray = [PanDetailResponse]() {
        didSet {
            configurePanData()
        }
    }
    var bankDetailsArray = [BankDetailResponse]() {
        didSet {
            configureBankData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
        getUserProfileData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addNavigationBar(navigationTitle: "Club11", titleContentMode: .left, isNavImageShow: false, isBackButtonShow: false, isWalletButtonShow: true)
//        getUserProfileData()
        getBankDetails()
        getPanDetails()
        getBannerData()
        aHomeTableView.reloadData()
        addPullToRefresh()
    }
    
    fileprivate func registerCell() {
        aHomeTableView.register(UINib(nibName: BannerTVCell.identifier(), bundle: nil), forCellReuseIdentifier: BannerTVCell.identifier())
        aHomeTableView.register(UINib(nibName: HomeContestTVCell.identifier(), bundle: nil), forCellReuseIdentifier: HomeContestTVCell.identifier())
    }
    
    func addPullToRefresh() {
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(refreshData(sender:)), for: .valueChanged)
        aHomeTableView.refreshControl = refreshControl
    }
    
    @objc func refreshData(sender:AnyObject) {
        getBankDetails()
        getPanDetails()
        getBannerData()
        aHomeTableView.reloadData()
        self.refreshControl.endRefreshing()
    }
    
    func getUserProfileData() {
        showActivityIndicator(sMessage: "Loading...")
        let headers = [
            "content-type": "application/x-www-form-urlencoded",
            "cache-control": "no-cache"
        ]
        let parameters = ["user_id": UserDefaults.standard.object(forKey: kUserId) ?? -1]
        
        NetworkManager.post_Request(urlService: kUserDetailsURL, param: parameters, head: headers) { (response) in
            self.hideActivityIndicator()
            do {
                if response != nil {
                    let responseData = try JSONSerialization.data(withJSONObject: response!, options: [])
                    let responseModel = try JSONDecoder().decode([UserDetailsResponse].self, from: responseData)
                    self.userDetailsArray = responseModel
                }
            } catch {
                Loader.showAlert(message: "Status code 500: server internal error")
            }
        }
    }
    
    
    func getBankDetails() {
        showActivityIndicator(sMessage: "Loading...")
        let headers = [
            "content-type": "application/x-www-form-urlencoded",
            "cache-control": "no-cache"
        ]
        let parameters = ["id": UserDefaults.standard.object(forKey: kUserId) ?? -1]
        
        NetworkManager.post_Request(urlService: kBankDetailsURL, param: parameters, head: headers) { (response) in
            self.hideActivityIndicator()
            do {
                if response != nil {
                    let responseData = try JSONSerialization.data(withJSONObject: response!, options: [])
                    let responseModel = try JSONDecoder().decode([BankDetailResponse].self, from: responseData)
                    self.bankDetailsArray = responseModel
                }
            } catch {
                Loader.showAlert(message: "Status code 500: server internal error")
            }
        }
    }
    
    func getPanDetails() {
        showActivityIndicator(sMessage: "Loading...")
        let headers = [
            "content-type": "application/x-www-form-urlencoded",
            "cache-control": "no-cache"
        ]
        let parameters = ["id": UserDefaults.standard.object(forKey: kUserId) ?? -1]
        
        NetworkManager.post_Request(urlService: kPanDetailsURL, param: parameters, head: headers) { (response) in
            self.hideActivityIndicator()
            do {
                if response != nil {
                    let responseData = try JSONSerialization.data(withJSONObject: response!, options: [])
                    let responseModel = try JSONDecoder().decode([PanDetailResponse].self, from: responseData)
                    self.panDetailsArray = responseModel
                }
            } catch {
                Loader.showAlert(message: "Status code 500: server internal error")
            }
        }
    }
    
    
    fileprivate func getBannerData() {
        showActivityIndicator(sMessage: "Loading...")
        let headers = [
            "content-type": "application/json",
            "cache-control": "no-cache"
            ]
        NetworkManager.get_Request(urlService: kBanner_URL, param: nil, head: headers) { (response) in
            self.hideActivityIndicator()
            do {
                if response != nil {
                    let responseData = try JSONSerialization.data(withJSONObject: response!, options: [])
                    let responseModel = try JSONDecoder().decode(Array<BannerResponse>.self, from: responseData)
                    if responseModel.count > 0 {
                        self.bannerDataArray = responseModel
                    } else {
                        Loader.showAlert(message: "Unable to get Banner data")
                    }
                }
            } catch {
                Loader.showAlert(message: "Status code 500: server internal error")
            }
        }
    }

    func bannerAction(bannerType: String) {
        
    }
    
    fileprivate func openAddMoneyView() {
        
    }
    
    func selectedContestAction(contest: LiveMatchResponse, format: String, homeType: HomeType) {
        switch homeType {
        case .upcomming:
            APP_DEL.contestFormat = format
            openContestViewController(contest: contest, homeType: homeType)
        default:
            openChallengeViewController(contest: contest, homeType: homeType)
        }
    }
    
    func openChallengeViewController(contest: LiveMatchResponse, homeType: HomeType) {
        openViewController(controller: MyChallengeViewController.self, storyBoard: .homeStoryBoard) { (vc) in
            vc.contestData = contest
            vc.homeType = homeType
        }
    }
    
    func openContestViewController(contest: LiveMatchResponse, homeType: HomeType) {
        openViewController(controller: LeaguesViewController.self, storyBoard: .homeStoryBoard) { (vc) in
            vc.contestData = contest
            vc.homeType = homeType
        }
    }
    
    func configureUserFullData() {
        for data in userDetailsArray {
            UserDefaults.standard.set(data.email, forKey: kEmailId)
            UserDefaults.standard.set(data.mobile, forKey: kMobileNumber)
            if let teamName = data.team {
                if teamName == "" {
                    openViewController(controller: UpdateTeamNameViewController.self, storyBoard: .homeStoryBoard) { (vc) in
                        vc.teamNameClouser = {[weak self] name in
                            if let _ = self {
                                UserDefaults.standard.set(name, forKey: kTeamName)
                            }
                        }
                    }
                } else {
                    UserDefaults.standard.set(teamName, forKey: kTeamName)
                }
            } else {
                openViewController(controller: UpdateTeamNameViewController.self, storyBoard: .homeStoryBoard) { (vc) in
                    
                }
            }
            UserDefaults.standard.set(data.refercode, forKey: kReferCode)
        }
    }
    
    func configurePanData() {
        for data in panDetailsArray {
            UserDefaults.standard.set(data.pannumber, forKey: kPanCardNo)
        }
    }
    
    func configureBankData() {
        for data in bankDetailsArray {
            UserDefaults.standard.set(data.accno, forKey: kBankAccountNo)
        }
    }
 }

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: BannerTVCell.identifier(), for: indexPath) as! BannerTVCell
            cell.bannerArr = bannerDataArray
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: HomeContestTVCell.identifier(), for: indexPath) as! HomeContestTVCell
            cell.selectedContest = { [weak self] contest, cFormat,homeType   in
                if let strongSelf = self {
                    strongSelf.selectedContestAction(contest: contest, format: cFormat, homeType: homeType)
                }
            }
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return kBannerTVCellIHeight
        } else {
            return (ScreenSize.SCREEN_HEIGHT - (kBannerTVCellIHeight + 100))
        }
        
    }
}
