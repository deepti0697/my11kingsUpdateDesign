//
//  PreviewViewController.swift
//  Club11
//
//  Created by Sudhansh Gupta on 08/06/19.
//

import UIKit

class PreviewViewController: UIViewController {

    @IBOutlet weak var aWKCaptainLabel: UILabel!
    @IBOutlet weak var aWKContainerView: UIView!
    @IBOutlet weak var aWKImageView: UIImageView!
    @IBOutlet weak var aWKNameLabel: UILabel!
    @IBOutlet weak var aWKCreditLabel: UILabel!
    @IBOutlet weak var aBat1CaptainLabel: UILabel!
    @IBOutlet weak var aBat1ContainerView: UIView!
    @IBOutlet weak var aBat1ImageView: UIImageView!
    @IBOutlet weak var aBat1NameLabel: UILabel!
    @IBOutlet weak var aBat1CreditLabel: UILabel!
    @IBOutlet weak var aBat2CaptainLabel: UILabel!
    @IBOutlet weak var aBat2ContainerView: UIView!
    @IBOutlet weak var aBat2ImageView: UIImageView!
    @IBOutlet weak var aBat2NameLabel: UILabel!
    @IBOutlet weak var aBat2CreditLabel: UILabel!
    @IBOutlet weak var aBat3CaptainLabel: UILabel!
    @IBOutlet weak var aBat3ContainerView: UIView!
    @IBOutlet weak var aBat3ImageView: UIImageView!
    @IBOutlet weak var aBat3NameLabel: UILabel!
    @IBOutlet weak var aBat3CreditLabel: UILabel!
    @IBOutlet weak var aBat4CaptainLabel: UILabel!
    @IBOutlet weak var aBat4ContainerView: UIView!
    @IBOutlet weak var aBat4ImageView: UIImageView!
    @IBOutlet weak var aBat4NameLabel: UILabel!
    @IBOutlet weak var aBat4CreditLabel: UILabel!
    @IBOutlet weak var aBat5CaptainLabel: UILabel!
    @IBOutlet weak var aBat5ContainerView: UIView!
    @IBOutlet weak var aBat5ImageView: UIImageView!
    @IBOutlet weak var aBat5NameLabel: UILabel!
    @IBOutlet weak var aBat5CreditLabel: UILabel!
    @IBOutlet weak var aAR1CaptainLabel: UILabel!
    @IBOutlet weak var aAR1ContainerView: UIView!
    @IBOutlet weak var aAR1ImageView: UIImageView!
    @IBOutlet weak var aAR1NameLabel: UILabel!
    @IBOutlet weak var aAR1CreditLabel: UILabel!
    @IBOutlet weak var aAR2CaptainLabel: UILabel!
    @IBOutlet weak var aAR2ContainerView: UIView!
    @IBOutlet weak var aAR2ImageView: UIImageView!
    @IBOutlet weak var aAR2NameLabel: UILabel!
    @IBOutlet weak var aAR2CreditLabel: UILabel!
    @IBOutlet weak var aAR3CaptainLabel: UILabel!
    @IBOutlet weak var aAR3ContainerView: UIView!
    @IBOutlet weak var aAR3ImageView: UIImageView!
    @IBOutlet weak var aAR3NameLabel: UILabel!
    @IBOutlet weak var aAR3CreditLabel: UILabel!
    @IBOutlet weak var aBall1CaptainLabel: UILabel!
    @IBOutlet weak var aBall1ContainerView: UIView!
    @IBOutlet weak var aBall1ImageView: UIImageView!
    @IBOutlet weak var aBall1NameLabel: UILabel!
    @IBOutlet weak var aBall1CreditLabel: UILabel!
    @IBOutlet weak var aBall2CaptainLabel: UILabel!
    @IBOutlet weak var aBall2ContainerView: UIView!
    @IBOutlet weak var aBall2ImageView: UIImageView!
    @IBOutlet weak var aBall2NameLabel: UILabel!
    @IBOutlet weak var aBall2CreditLabel: UILabel!
    @IBOutlet weak var aBall3CaptainLabel: UILabel!
    @IBOutlet weak var aBall3ContainerView: UIView!
    @IBOutlet weak var aBall3ImageView: UIImageView!
    @IBOutlet weak var aBall3NameLabel: UILabel!
    @IBOutlet weak var aBall3CreditLabel: UILabel!
    @IBOutlet weak var aBall4CaptainLabel: UILabel!
    @IBOutlet weak var aBall4ContainerView: UIView!
    @IBOutlet weak var aBall4ImageView: UIImageView!
    @IBOutlet weak var aBall4NameLabel: UILabel!
    @IBOutlet weak var aBall4CreditLabel: UILabel!
    @IBOutlet weak var aBall5CaptainLabel: UILabel!
    @IBOutlet weak var aBall5ContainerView: UIView!
    @IBOutlet weak var aBall5ImageView: UIImageView!
    @IBOutlet weak var aBall5NameLabel: UILabel!
    @IBOutlet weak var aBall5CreditLabel: UILabel!
    @IBOutlet weak var aTeamNameLabel: UILabel!
    @IBOutlet weak var aEditButton: UIButton!
    @IBOutlet weak var aCloseButton: UIButton!
    
    var matchId = "" {
        didSet {
            getTeamPlayers()
        }
    }
    var teamID = ""
    var teamInfo = [Preview_Team_info]() {
        didSet {
            setupPreviewData()
        }
    }
    var wkArray = [Preview_Team_players_data]()
    var batArray = [Preview_Team_players_data]()
    var bowlArray = [Preview_Team_players_data]()
    var allArray = [Preview_Team_players_data]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
    }
    
    fileprivate func setupUI() {
        self.navigationController?.isNavigationBarHidden = true
        aWKContainerView.isHidden = true
        aAR1ContainerView.isHidden = true
        aAR2ContainerView.isHidden = true
        aAR3ContainerView.isHidden = true
        aBat1ContainerView.isHidden = true
        aBat2ContainerView.isHidden = true
        aBat3ContainerView.isHidden = true
        aBat4ContainerView.isHidden = true
        aBat5ContainerView.isHidden = true
        aBall1ContainerView.isHidden = true
        aBall2ContainerView.isHidden = true
        aBall3ContainerView.isHidden = true
        aBall4ContainerView.isHidden = true
        aBall5ContainerView.isHidden = true
        aWKCaptainLabel.isHidden = true
        aAR1CaptainLabel.isHidden = true
        aAR2CaptainLabel.isHidden = true
        aAR3CaptainLabel.isHidden = true
        aBat1CaptainLabel.isHidden = true
        aBat2CaptainLabel.isHidden = true
        aBat3CaptainLabel.isHidden = true
        aBat4CaptainLabel.isHidden = true
        aBat5CaptainLabel.isHidden = true
        aBall1CaptainLabel.isHidden = true
        aBall2CaptainLabel.isHidden = true
        aBall3CaptainLabel.isHidden = true
        aBall4CaptainLabel.isHidden = true
        aBall5CaptainLabel.isHidden = true
        aWKCaptainLabel.setCornerRadius(value: 7.5)
        aAR1CaptainLabel.setCornerRadius(value: 7.5)
        aAR2CaptainLabel.setCornerRadius(value: 7.5)
        aAR3CaptainLabel.setCornerRadius(value: 7.5)
        aBat1CaptainLabel.setCornerRadius(value: 7.5)
        aBat2CaptainLabel.setCornerRadius(value: 7.5)
        aBat3CaptainLabel.setCornerRadius(value: 7.5)
        aBat4CaptainLabel.setCornerRadius(value: 7.5)
        aBat5CaptainLabel.setCornerRadius(value: 7.5)
        aBall1CaptainLabel.setCornerRadius(value: 7.5)
        aBall2CaptainLabel.setCornerRadius(value: 7.5)
        aBall3CaptainLabel.setCornerRadius(value: 7.5)
        aBall4CaptainLabel.setCornerRadius(value: 7.5)
        aBall5CaptainLabel.setCornerRadius(value: 7.5)
    }
    
    fileprivate func getTeamPlayers() {
        showActivityIndicator(sMessage: "Please Wait")
        let headers = [
            "content-type": "application/json",
            "cache-control": "no-cache",
            "API-KEY": UserDefaults.standard.object(forKey: kUDKey)
            ]  as? [String : String]
        let parameters = ["user_id": UserDefaults.standard.object(forKey: kUserId) ?? -1,"match_id": matchId, "user_team_id": teamID] as [String : Any]
        
        TBNetworkManager.post_Request(urlService: KShowTeamOnGround, param: parameters, head: headers) { (response) in
            self.hideActivityIndicator()
            do {
                if response != nil {
                    let responseData = try JSONSerialization.data(withJSONObject: response!, options: [])
                    let responseModel = try JSONDecoder().decode(PreviewTeamResponse.self, from: responseData)
                    if responseModel.status == "success" {
                        if let teamData = responseModel.data {
                            if let tInfo = teamData.team_info {
                                self.teamInfo = tInfo
                            }
                        }
                    } else {
                        TBLoader.showAlert(message: responseModel.message ?? "")
                    }
                }
            } catch {
                print("Decoding failed!") // Show Alert
            }
        }
    }
    
    fileprivate func setupPreviewData() {
        for info in teamInfo {
            if let teamName = info.team_name {
                aTeamNameLabel.text = teamName
            }
            if let playerData = info.team_players_data {
                setupPreviewTeam(players: playerData)
            }
        }
    }
    
    fileprivate func setupPreviewTeam(players: [Preview_Team_players_data]) {
        for player in players {
            if let playerType = player.player_type {
                switch playerType {
                case "Wicket Keeper" :
                    wkArray.append(player)
                case "Batsman" :
                    batArray.append(player)
                case "All Rounder" :
                    allArray.append(player)
                case "Bowler" :
                    bowlArray.append(player)
                default:
                    break
                }
            }
        }
        setWKData()
        setBatData()
        setAllData()
        setBowlData()
    }
    
    fileprivate func setWKData() {
        for player in wkArray {
            aWKNameLabel.text = "\(player.player_fname ?? "") \(player.player_lname ?? "")"
            aWKCreditLabel.text = "\(player.player_value ?? "0") Cr"
            aWKContainerView.isHidden = false
            if player.captain == "1" {
                aWKCaptainLabel.isHidden = false
                aWKCaptainLabel.text = "C"
                aWKCaptainLabel.backgroundColor = UIColor(red: 255 / 255, green: 38 / 255, blue: 0 / 255, alpha: 1.0)
            }
            if player.vice_captain == "1" {
                aWKCaptainLabel.isHidden = false
                aWKCaptainLabel.text = "VC"
                aWKCaptainLabel.backgroundColor = UIColor(red: 15 / 255, green: 18 / 255, blue: 144 / 255, alpha: 1.0)
            }
        }
    }
    
    fileprivate func setBatData() {
        for (index,player) in batArray.enumerated() {
            switch index {
            case 0:
                aBat1NameLabel.text = "\(player.player_fname ?? "") \(player.player_lname ?? "")"
                aBat1CreditLabel.text = "\(player.player_value ?? "0") Cr"
                aBat1ContainerView.isHidden = false
                if player.captain == "1" {
                    aBat1CaptainLabel.isHidden = false
                    aBat1CaptainLabel.text = "C"
                    aBat1CaptainLabel.backgroundColor = UIColor(red: 255 / 255, green: 38 / 255, blue: 0 / 255, alpha: 1.0)
                }
                if player.vice_captain == "1" {
                    aBat1CaptainLabel.isHidden = false
                    aBat1CaptainLabel.text = "VC"
                    aBat1CaptainLabel.backgroundColor = UIColor(red: 15 / 255, green: 18 / 255, blue: 144 / 255, alpha: 1.0)
                }
            case 1:
                aBat2NameLabel.text = "\(player.player_fname ?? "") \(player.player_lname ?? "")"
                aBat2CreditLabel.text = "\(player.player_value ?? "0") Cr"
                aBat2ContainerView.isHidden = false
                if player.captain == "1" {
                    aBat2CaptainLabel.isHidden = false
                    aBat2CaptainLabel.text = "C"
                    aBat2CaptainLabel.backgroundColor = UIColor(red: 255 / 255, green: 38 / 255, blue: 0 / 255, alpha: 1.0)
                }
                if player.vice_captain == "1" {
                    aBat2CaptainLabel.isHidden = false
                    aBat2CaptainLabel.text = "VC"
                    aBat2CaptainLabel.backgroundColor = UIColor(red: 15 / 255, green: 18 / 255, blue: 144 / 255, alpha: 1.0)
                }
            case 2:
                aBat3NameLabel.text = "\(player.player_fname ?? "") \(player.player_lname ?? "")"
                aBat3CreditLabel.text = "\(player.player_value ?? "0") Cr"
                aBat3ContainerView.isHidden = false
                if player.captain == "1" {
                    aBat3CaptainLabel.isHidden = false
                    aBat3CaptainLabel.text = "C"
                    aBat3CaptainLabel.backgroundColor = UIColor(red: 255 / 255, green: 38 / 255, blue: 0 / 255, alpha: 1.0)
                }
                if player.vice_captain == "1" {
                    aBat3CaptainLabel.isHidden = false
                    aBat3CaptainLabel.text = "VC"
                    aBat3CaptainLabel.backgroundColor = UIColor(red: 15 / 255, green: 18 / 255, blue: 144 / 255, alpha: 1.0)
                }
            case 3:
                aBat4NameLabel.text = "\(player.player_fname ?? "") \(player.player_lname ?? "")"
                aBat4CreditLabel.text = "\(player.player_value ?? "0") Cr"
                aBat4ContainerView.isHidden = false
                if player.captain == "1" {
                    aBat4CaptainLabel.isHidden = false
                    aBat4CaptainLabel.text = "C"
                    aBat4CaptainLabel.backgroundColor = UIColor(red: 255 / 255, green: 38 / 255, blue: 0 / 255, alpha: 1.0)
                }
                if player.vice_captain == "1" {
                    aBat4CaptainLabel.isHidden = false
                    aBat4CaptainLabel.text = "VC"
                    aBat4CaptainLabel.backgroundColor = UIColor(red: 15 / 255, green: 18 / 255, blue: 144 / 255, alpha: 1.0)
                }
            case 4:
                aBat5NameLabel.text = "\(player.player_fname ?? "") \(player.player_lname ?? "")"
                aBat5CreditLabel.text = "\(player.player_value ?? "0") Cr"
                aBat5ContainerView.isHidden = false
                if player.captain == "1" {
                    aBat5CaptainLabel.isHidden = false
                    aBat5CaptainLabel.text = "C"
                    aBat5CaptainLabel.backgroundColor = UIColor(red: 255 / 255, green: 38 / 255, blue: 0 / 255, alpha: 1.0)
                }
                if player.vice_captain == "1" {
                    aBat5CaptainLabel.isHidden = false
                    aBat5CaptainLabel.text = "VC"
                    aBat5CaptainLabel.backgroundColor = UIColor(red: 15 / 255, green: 18 / 255, blue: 144 / 255, alpha: 1.0)
                }
            default:
                break
            }
        }
    }
    
    fileprivate func setAllData() {
        for (index,player) in allArray.enumerated() {
            switch index {
            case 0:
                aAR1NameLabel.text = "\(player.player_fname ?? "") \(player.player_lname ?? "")"
                aAR1CreditLabel.text = "\(player.player_value ?? "0") Cr"
                aAR1ContainerView.isHidden = false
                if player.captain == "1" {
                    aAR1CaptainLabel.isHidden = false
                    aAR1CaptainLabel.text = "C"
                    aAR1CaptainLabel.backgroundColor = UIColor(red: 255 / 255, green: 38 / 255, blue: 0 / 255, alpha: 1.0)
                }
                if player.vice_captain == "1" {
                    aAR1CaptainLabel.isHidden = false
                    aAR1CaptainLabel.text = "VC"
                    aAR1CaptainLabel.backgroundColor = UIColor(red: 15 / 255, green: 18 / 255, blue: 144 / 255, alpha: 1.0)
                }
            case 1:
                aAR2NameLabel.text = "\(player.player_fname ?? "") \(player.player_lname ?? "")"
                aAR2CreditLabel.text = "\(player.player_value ?? "0") Cr"
                aAR2ContainerView.isHidden = false
                if player.captain == "1" {
                    aAR2CaptainLabel.isHidden = false
                    aAR2CaptainLabel.text = "C"
                    aAR2CaptainLabel.backgroundColor = UIColor(red: 255 / 255, green: 38 / 255, blue: 0 / 255, alpha: 1.0)
                }
                if player.vice_captain == "1" {
                    aAR2CaptainLabel.isHidden = false
                    aAR2CaptainLabel.text = "VC"
                    aAR2CaptainLabel.backgroundColor = UIColor(red: 15 / 255, green: 18 / 255, blue: 144 / 255, alpha: 1.0)
                }
            case 2:
                aAR3NameLabel.text = "\(player.player_fname ?? "") \(player.player_lname ?? "")"
                aAR3CreditLabel.text = "\(player.player_value ?? "0") Cr"
                aAR3ContainerView.isHidden = false
                if player.captain == "1" {
                    aAR3CaptainLabel.isHidden = false
                    aAR3CaptainLabel.text = "C"
                    aAR3CaptainLabel.backgroundColor = UIColor(red: 255 / 255, green: 38 / 255, blue: 0 / 255, alpha: 1.0)
                }
                if player.vice_captain == "1" {
                    aAR3CaptainLabel.isHidden = false
                    aAR3CaptainLabel.text = "VC"
                    aAR3CaptainLabel.backgroundColor = UIColor(red: 15 / 255, green: 18 / 255, blue: 144 / 255, alpha: 1.0)
                }
            default:
                break
            }
        }
    }
    
    fileprivate func setBowlData() {
        for (index,player) in bowlArray.enumerated() {
            switch index {
            case 0:
                aBall1NameLabel.text = "\(player.player_fname ?? "") \(player.player_lname ?? "")"
                aBall1CreditLabel.text = "\(player.player_value ?? "0") Cr"
                aBall1ContainerView.isHidden = false
                if player.captain == "1" {
                    aBall1CaptainLabel.isHidden = false
                    aBall1CaptainLabel.text = "C"
                    aBall1CaptainLabel.backgroundColor = UIColor(red: 255 / 255, green: 38 / 255, blue: 0 / 255, alpha: 1.0)
                }
                if player.vice_captain == "1" {
                    aBall1CaptainLabel.isHidden = false
                    aBall1CaptainLabel.text = "VC"
                    aBall1CaptainLabel.backgroundColor = UIColor(red: 15 / 255, green: 18 / 255, blue: 144 / 255, alpha: 1.0)
                }
            case 1:
                aBall2NameLabel.text = "\(player.player_fname ?? "") \(player.player_lname ?? "")"
                aBall2CreditLabel.text = "\(player.player_value ?? "0") Cr"
                aBall2ContainerView.isHidden = false
                if player.captain == "1" {
                    aBall2CaptainLabel.isHidden = false
                    aBall2CaptainLabel.text = "C"
                    aBall2CaptainLabel.backgroundColor = UIColor(red: 255 / 255, green: 38 / 255, blue: 0 / 255, alpha: 1.0)
                }
                if player.vice_captain == "1" {
                    aBall2CaptainLabel.isHidden = false
                    aBall2CaptainLabel.text = "VC"
                    aBall2CaptainLabel.backgroundColor = UIColor(red: 15 / 255, green: 18 / 255, blue: 144 / 255, alpha: 1.0)
                }
            case 2:
                aBall3NameLabel.text = "\(player.player_fname ?? "") \(player.player_lname ?? "")"
                aBall3CreditLabel.text = "\(player.player_value ?? "0") Cr"
                aBall3ContainerView.isHidden = false
                if player.captain == "1" {
                    aBall3CaptainLabel.isHidden = false
                    aBall3CaptainLabel.text = "C"
                    aBall3CaptainLabel.backgroundColor = UIColor(red: 255 / 255, green: 38 / 255, blue: 0 / 255, alpha: 1.0)
                }
                if player.vice_captain == "1" {
                    aBall3CaptainLabel.isHidden = false
                    aBall3CaptainLabel.text = "VC"
                    aBall3CaptainLabel.backgroundColor = UIColor(red: 15 / 255, green: 18 / 255, blue: 144 / 255, alpha: 1.0)
                }
            case 3:
                aBall4NameLabel.text = "\(player.player_fname ?? "") \(player.player_lname ?? "")"
                aBall4CreditLabel.text = "\(player.player_value ?? "0") Cr"
                aBall4ContainerView.isHidden = false
                if player.captain == "1" {
                    aBall4CaptainLabel.isHidden = false
                    aBall4CaptainLabel.text = "C"
                    aBall4CaptainLabel.backgroundColor = UIColor(red: 255 / 255, green: 38 / 255, blue: 0 / 255, alpha: 1.0)
                }
                if player.vice_captain == "1" {
                    aBall4CaptainLabel.isHidden = false
                    aBall4CaptainLabel.text = "VC"
                    aBall4CaptainLabel.backgroundColor = UIColor(red: 15 / 255, green: 18 / 255, blue: 144 / 255, alpha: 1.0)
                }
            case 4:
                aBall5NameLabel.text = "\(player.player_fname ?? "") \(player.player_lname ?? "")"
                aBall5CreditLabel.text = "\(player.player_value ?? "0") Cr"
                aBall5ContainerView.isHidden = false
                if player.captain == "1" {
                    aBall5CaptainLabel.isHidden = false
                    aBall5CaptainLabel.text = "C"
                    aBall5CaptainLabel.backgroundColor = UIColor(red: 255 / 255, green: 38 / 255, blue: 0 / 255, alpha: 1.0)
                }
                if player.vice_captain == "1" {
                    aBall5CaptainLabel.isHidden = false
                    aBall5CaptainLabel.text = "VC"
                    aBall5CaptainLabel.backgroundColor = UIColor(red: 15 / 255, green: 18 / 255, blue: 144 / 255, alpha: 1.0)
                }
            default:
                break
            }
        }
    }
    
    @IBAction func aEditButtonAction(_ sender: Any) {
        
    }
    
    @IBAction func closeButtonAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
