//
//  TournamentLeaderViewController.swift
//  11Kings
//
//  Created by uu on 24/08/20.
//  Copyright © 2020 Macbook. All rights reserved.
//

import UIKit
import SwiftyJSON
class TournamentLeaderViewController: BaseClass {
    
    
    @IBOutlet weak var aTableView: UITableView!
    var id:Int?
    var tournamentLeaderBoardArray = [TournamentLeaderBoardResponse]() {
        didSet {
            aTableView.reloadDataInMainQueue()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: false)
        getTournamentSeeries()
    }
    
    
    fileprivate func registerCell() {
        aTableView.register(UINib(nibName: TournamentLeagueTableViewCell.identifier(), bundle: nil), forCellReuseIdentifier: TournamentLeagueTableViewCell.identifier())
    }
    
    @IBAction func backButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    fileprivate func getTournamentSeeries() {
        showActivityIndicator(sMessage: "Loading...")
        let headers = [
            "Content-Type":"application/json"]
        
        
        
        let param = ["user_id":UserDefaults.standard.value(forKey: kUserId)]
        
        NetworkManager.post_Request2(urlService: getTournamentSeries, param: param as [String : Any], head: headers)  { (response) in
            
            self.hideActivityIndicator()
            guard let data = response else { return }
            do{
                let json = try JSON(data:data as! Data)
                
                let results = json["result"]
                self.tournamentLeaderBoardArray.removeAll()
                for i in results.arrayValue {
                    self.tournamentLeaderBoardArray.append(TournamentLeaderBoardResponse(json: i))
                    
                    
                    
                }
                
            }
                
            catch{
                Loader.showAlert(message: "Inernal Error")
                print(error.localizedDescription)
            }
        }
        
    }
    
    
    fileprivate func getTournamentit(id:String) {
        showActivityIndicator(sMessage: "Loading...")
        let headers = [
            "Content-Type":"application/json"]
        
        
        
        let param = ["user_id":UserDefaults.standard.value(forKey: kUserId),"series_id":id]
        
        NetworkManager.post_Request2(urlService: getTournamentLederboard, param: param as [String : Any], head: headers)  { (response) in
            
            self.hideActivityIndicator()
            guard let data = response else { return }
            do{
                let json = try JSON(data:data as! Data)
                
                let results = json["result"]
                self.tournamentLeaderBoardArray.removeAll()
                for i in results.arrayValue {
                    self.tournamentLeaderBoardArray.append(TournamentLeaderBoardResponse(json: i))
                    
                    
                }
                
            }
                
            catch{
                Loader.showAlert(message: "Inernal Error")
                print(error.localizedDescription)
            }
        }
        
    }
}


extension TournamentLeaderViewController:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tournamentLeaderBoardArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TournamentLeagueTableViewCell.identifier(), for: indexPath) as! TournamentLeagueTableViewCell
        cell.selectionStyle = .none
        cell.configureCell(response: tournamentLeaderBoardArray[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let id =  tournamentLeaderBoardArray[indexPath.row].id ?? ""
        openViewController(controller: TournamentLeaderBoardSeriesViewController.self, storyBoard: .moreStoryBoard) { (vc) in
            vc.leaderTournamentName = self.tournamentLeaderBoardArray[indexPath.row].name
            
            vc.seriesId = id
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
}
