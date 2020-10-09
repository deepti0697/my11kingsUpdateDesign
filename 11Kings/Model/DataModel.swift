//
//  DataModel.swift
//  DreamTeam
//
//  Created by Test on 12/05/20.
//  Copyright © 2020 Macbook. All rights reserved.
//

import Foundation
import SwiftyJSON
struct MsgStatusResponse: Codable {
    let msg : String?
    let status : Int?
    
    enum CodingKeys: String, CodingKey {
        
        case msg = "msg"
        case status = "status"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        msg = try values.decodeIfPresent(String.self, forKey: .msg)
        status = try values.decodeIfPresent(Int.self, forKey: .status)
    }
    
}
struct BannerResponses  {
    let id : Int?
    let title : String?
    let link:String?
    let image : String?
    let is_maintenance:Int?
    init(json:JSON){
        self.id = json["id"].intValue
        self.title = json["title"].stringValue
        self.image = json["image"].stringValue
        self.link = json["link"].stringValue
        self.is_maintenance = json["is_maintenance"].intValue
    }
}
struct BannerResponse : Codable {
    let id : Int?
    let title : String?
    let url : String?
    let image : String?
    
    enum CodingKeys: String, CodingKey {
        
        case id = "id"
        case title = "title"
        case url = "url"
        case image = "image"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        url = try values.decodeIfPresent(String.self, forKey: .url)
        image = try values.decodeIfPresent(String.self, forKey: .image)
    }
    
}
struct contestWinner:Codable {
    var winingAmount:String?
    var percent:String?
    var rank:String?
    
}
struct playingHistory {
    let total_match_play:Int?
    let total_league_play:Int?
    let total_contest_win: Int?
    let total_winning: Double?
    init(json:JSON) {
        self.total_match_play = json["total_match_play"].intValue
        self.total_league_play = json["total_league_play"].intValue
        self.total_winning = json["total_winning"].doubleValue
        self.total_contest_win = json["total_contest_win"].intValue
    }
}
struct PanResponse {
    let panname : String?
    let pannumber : String?
    let pandob : String?
    let image : String?
    let status : Int?
    init(json:JSON) {
        self.panname = json["panname"].stringValue
        self.pannumber = json["pannumber"].stringValue
        self.pandob = json["image"].stringValue
        self.image = json["image"].stringValue
        self.status = json["status"].intValue
    }
}

struct PanDetailResponse : Codable {
    let panname : String?
    let pannumber : String?
    let pandob : String?
    let image : String?
    let imagetype : String?
    let status : Int?
    
    enum CodingKeys: String, CodingKey {
        
        case panname = "panname"
        case pannumber = "pannumber"
        case pandob = "pandob"
        case image = "image"
        case imagetype = "imagetype"
        case status = "status"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        panname = try values.decodeIfPresent(String.self, forKey: .panname)
        pannumber = try values.decodeIfPresent(String.self, forKey: .pannumber)
        pandob = try values.decodeIfPresent(String.self, forKey: .pandob)
        image = try values.decodeIfPresent(String.self, forKey: .image)
        imagetype = try values.decodeIfPresent(String.self, forKey: .imagetype)
        status = try values.decodeIfPresent(Int.self, forKey: .status)
    }
    
}
struct WithDrawAmountResponses {
    let msg : String?
    let status : Int?
    let amount : Int?
    let wining : Int?
    init(withdrawJson:JSON) {
        self.msg = withdrawJson["msg"].stringValue
        self.status = withdrawJson["status"].intValue
        self.amount = withdrawJson["amount"].intValue
        self.wining = withdrawJson["wining"].intValue
    }
}

struct WithDrawAmountResponse : Codable {
    let msg : String?
    let status : Int?
    let amount : Int?
    let wining : Int?
    
    enum CodingKeys: String, CodingKey {
        
        case msg = "msg"
        case status = "status"
        case amount = "amount"
        case wining = "wining"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        msg = try values.decodeIfPresent(String.self, forKey: .msg)
        status = try values.decodeIfPresent(Int.self, forKey: .status)
        amount = try values.decodeIfPresent(Int.self, forKey: .amount)
        wining = try values.decodeIfPresent(Int.self, forKey: .wining)
    }
    
}
struct myTransaction {
    let id:Int?
    let transaction_by: String?
    let add_amount: String?
    let deduct_amount: String
    let amount: String?
    let paymentstatus: String?
    let available: String?
    let transaction_id: String?
    let transaction_type: String?
    let teamname: String?
    let username: String?
    let created: String?
    init(json:JSON) {
        self.id = json["id"].intValue
        self.transaction_by = json["transaction_by"].stringValue
        self.add_amount = json["add_amount"].stringValue
        self.deduct_amount = json["deduct_amount"].stringValue
        self.amount  = json["amount"].stringValue
        self.paymentstatus = json["paymentstatus"].stringValue
        self.available = json["available"].stringValue
        self.transaction_id = json["transaction_id"].stringValue
        self.transaction_type = json["transaction_type"].stringValue
        self.teamname = json["teamname"].stringValue
        self.username = json["useername"].stringValue
        self.created = json["created"].stringValue
    }
}

struct AddFundWallet {
    let msg : String?
    let amount : Double?
    let status : Int?
    init(json:JSON) {
        self.msg = json["msg"].stringValue
        self.amount = json["amount"].doubleValue
        self.status = json["status"].intValue
    }
}
struct AddFundResponse : Codable {
    let msg : String?
    let amount : Double?
    let status : Int?
    
    enum CodingKeys: String, CodingKey {
        
        case msg = "msg"
        case amount = "amount"
        case status = "status"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        msg = try values.decodeIfPresent(String.self, forKey: .msg)
        amount = try values.decodeIfPresent(Double.self, forKey: .amount)
        status = try values.decodeIfPresent(Int.self, forKey: .status)
    }
}
struct VerifyMobileResponse : Decodable {
    let otp : IntToString?
    let msg : String?
    let status : Int?
    
    enum CodingKeys: String, CodingKey {
        
        case otp = "otp"
        case msg = "msg"
        case status = "status"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        otp = try values.decodeIfPresent(IntToString.self, forKey: .otp)
        msg = try values.decodeIfPresent(String.self, forKey: .msg)
        status = try values.decodeIfPresent(Int.self, forKey: .status)
    }
    
}
enum IntToString: Decodable {
    
    case string(String?)
    
    init(from decoder: Decoder) throws {
        if let int = try? decoder.singleValueContainer().decode(Int.self) {
            self = .string("\(int)")
            return
        } else if let string = try? decoder.singleValueContainer().decode(String.self) {
            self = .string(string)
            return
        }else {
            self = .string(nil)
            return
        }
    }
}
//
struct Categories : Codable {
    let id : Int?
    let name : String?
    let contest_sub_text : String?
    let contest_type_image : String?
    let sort_order : Int?
    let status : Int?
    let leagues : [Leagues]?
    let total_category_leagues : Int?
    //let contest_image_url : String?
    
    enum CodingKeys: String, CodingKey {
        
        case id = "id"
        case name = "name"
        case contest_sub_text = "contest_sub_text"
        case contest_type_image = "contest_type_image"
        case sort_order = "sort_order"
        case status = "status"
        case leagues = "leagues"
        case total_category_leagues = "total_category_leagues"
        // case contest_image_url = "contest_image_url"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        contest_sub_text = try values.decodeIfPresent(String.self, forKey: .contest_sub_text)
        contest_type_image = try values.decodeIfPresent(String.self, forKey: .contest_type_image)
        sort_order = try values.decodeIfPresent(Int.self, forKey: .sort_order)
        status = try values.decodeIfPresent(Int.self, forKey: .status)
        leagues = try values.decodeIfPresent([Leagues].self, forKey: .leagues)
        total_category_leagues = try values.decodeIfPresent(Int.self, forKey: .total_category_leagues)
        //contest_image_url = try values.decodeIfPresent(String.self, forKey: .contest_image_url)
    }
    
}

struct playerMatchPoint {
    let player_name:String?
    let selected_by:String?
    let total_points:String?
    let is_topplayer:Int?
    let isSelected:Int?
    let team:String?
    let  captain_by:Int?
    let actual_total_points:Int?
    var breakup_points = [PlayerPointBreakup]()
    init(json:JSON) {
        self.is_topplayer = json["is_topplayer"].intValue
        self.isSelected = json["isSelected"].intValue
        self.actual_total_points = json["actual_total_points"].intValue
        self.player_name = json["player_name"].stringValue
        self.selected_by = json["selected_by"].stringValue
        self.total_points = json["total_points"].stringValue
        self.team = json["team"].stringValue
        self.captain_by = json["captain_by"].intValue
        guard let batterJSON = json["breakup_points"].array else { return  }
        let batters = batterJSON.map({ PlayerPointBreakup(json:  $0) })
        self.breakup_points = batters
    }
    
}
struct PlayerPointBreakup  {
    let event_name : String?
    let actual : String?
    let actual_points : Int
    init(json:JSON) {
        self.event_name = json["event_name"].stringValue
        self.actual = json["actual"].stringValue
        self.actual_points = json["actual_points"].intValue
    }
}
struct ChallengeRespnse {
    let id: Int?
    let challenge_id: Int?
    let name: String??
    let challenge_type: String?
    let winning_percentage:Int?
    let entryfee: Int?
    let winning_amount: String?
    let win_amount : String?
    let maximum_user: Int?
    let getjoinedpercentage: Int?
    let winners: Int?
    let userid: Int?
    let userrank: Int?
    let team_id: Int?
    let join_id: Int?
    let joinedusers: Int?
    let team1display: String?
    let team2display: String?
    let multi_entry: Int?
    let confirmed_challenge: Int?
    let is_running: Int?
    let is_free: Int?
    let join_with:String?
    let is_bonus: Int?
    let bonus_percent: String?
    let isselected: Bool?
    var matchkey:String?
    let refercode: String?
    let totalwinners:String?
    let pdf: String?
    let user_image :String?
    init(json:JSON) {
        self.id = json["id"].intValue
        self.challenge_id = json["challenge_id"].intValue
        self.name = json["name"].stringValue
        self.challenge_type = json["challenge_type"].stringValue
        self.winning_percentage = json["winning_percentage"].intValue
        self.entryfee = json["entryfee"].intValue
        self.winning_amount = json["winning_amount"].stringValue
        self.win_amount = json["win_amount"].stringValue
        self.maximum_user = json["maximum_user"].intValue
        self.getjoinedpercentage = json["getjoinedpercentage"].intValue
        self.winners = json["winners"].intValue
        self.userid = json["userid"].intValue
        self.userrank = json["userrank"].intValue
        self.team_id = json["team_id"].intValue
        self.join_id = json["join_id"].intValue
        self.joinedusers = json["joinedusers"].intValue
        self.team1display = json["team1display"].stringValue
        self.team2display = json["team2display"].stringValue
        self.multi_entry = json["multi_entry"].intValue
        self.confirmed_challenge = json["confirmed_challenge"].intValue
        self.is_running = json["is_running"].intValue
        self.is_free = json["is_free"].intValue
        self.is_bonus = json["is_bonus"].intValue
        self.bonus_percent = json["bonus_percent"].stringValue
        self.isselected = json["isselected"].bool
        self.join_with = json["join_with"].stringValue
        self.refercode = json["refercode"].stringValue
        self.totalwinners = json["totalwinners"].stringValue
        self.user_image = json["user_image"].stringValue
        self.pdf = json["pdf"].stringValue
        self.matchkey = json["matchkey"].stringValue
        
    }
}
struct CompareDataModel {
    let team1_name:String?
    let team2_name:String?
    let team1_rank: String?
    let team2_rank: String?
    let team1_image: String?
    let team2_image:String?
    let team1_points:Int?
    let team2_points:Int?
    let diff_points:String?
    let diff_text:String?
    let cvc_diff_text:String?
    let cvc_diff_points:String?
    let others_diff_text:String?
    let others_diff_points:String?
    let common_diff_text:String?
    let common_diff_points:String?
    var compare_c_vc : CompareCaptainVice?
    var other_players = [otherPlayer]()
    var common_players = [Commonplayers]()
    
    init(json:JSON) {
        self.team1_name = json["team1_name"].stringValue
        self.team2_name = json["team2_name"].stringValue
        self.team1_rank = json["team1_rank"].stringValue
        self.team2_rank = json["team2_rank"].stringValue
        self.team1_image = json["team1_image"].stringValue
        self.team2_image = json["team2_image"].stringValue
        self.team1_points = json["team1_points"].intValue
        self.team2_points = json["team2_points"].intValue
        
        self.common_diff_points = json["common_diff_points"].stringValue
        self.diff_text = json["diff_text"].stringValue
        self.diff_points = json["diff_points"].stringValue
        self.common_diff_text = json["common_diff_text"].stringValue
        self.cvc_diff_text = json["cvc_diff_text"].stringValue
        self.cvc_diff_points = json["cvc_diff_points"].stringValue
        self.others_diff_text = json["others_diff_text"].stringValue
        self.others_diff_points = json["others_diff_points"].stringValue
        
        
        self.compare_c_vc = CompareCaptainVice(json: json["compare_c_vc"])
        
        guard let otherinnver = json["other_players"].array else { return  }
        
        
        let getOtherPlayer = otherinnver.map({ otherPlayer(json: $0) })
        
        
        self.other_players = getOtherPlayer
        
        //
        
        
        guard let commoanPlayer = json["common_players"].array else { return  }
        let common = commoanPlayer.map({ Commonplayers(json:  $0) })
        self.common_players = common
        
    }
    
}
struct otherPlayer {
    var arrayOfInnerPlayer = [Otherplayers]()
    init(json:JSON) {
        
        
        guard let otherPlayer = json.array else { return  }
        
        
        let getOtherPlayer = otherPlayer.map({ Otherplayers(json:  $0) })
        
        
        self.arrayOfInnerPlayer = getOtherPlayer
    }
}
struct Otherplayers {
    let team: Int?
    let playerrole:String?
    let playercredit:String?
    let role: String?
    let playerpoints:String?
    let playername:String?
    let pid:Int?
    let image: String?
    let team_id:String?
    init(json:JSON) {
        self.team = json["team"].intValue
        self.playerrole = json["playerrole"].stringValue
        self.playercredit = json["playercredit"].stringValue
        self.role = json["role"].stringValue
        self.playerpoints = json["playerpoints"].stringValue
        self.playername = json["playername"].stringValue
        self.pid = json["pid"].intValue
        self.image = json["image"].stringValue
        self.team_id = json["team_id"].stringValue
    }
}

struct Commonplayers {
    let team: Int?
    let playerrole:String?
    let playercredit:String?
    let role: String?
    let playerpoints:String?
    let playername:String?
    let pid:Int?
    let image: String?
    let team_id:String?
    init(json:JSON) {
        self.team = json["team"].intValue
        self.playerrole = json["playerrole"].stringValue
        self.playercredit = json["playercredit"].stringValue
        self.role = json["role"].stringValue
        self.playerpoints = json["playerpoints"].stringValue
        self.playername = json["playername"].stringValue
        self.pid = json["pid"].intValue
        self.image = json["image"].stringValue
        self.team_id = json["team_id"].stringValue
    }
}
struct CompareCaptainVice {
    var captain  = [CaptainCompare]()
    var vice_captain = [ViceCaptainCompare]()
    init(json:JSON) {
        guard let batterJSON = json["captain"].array else { return  }
        let batters = batterJSON.map({ CaptainCompare(json:  $0) })
        self.captain = batters
        guard let viceCaptain = json["vice_captain"].array else { return  }
        let vCaptain = viceCaptain.map({ ViceCaptainCompare(json:  $0) })
        self.vice_captain = vCaptain
    }
}
struct CaptainCompare {
    let team: Int?
    let playerrole:String?
    let playercredit:String?
    let role: String?
    let playerpoints:String?
    let playername:String?
    let pid:Int?
    let image: String?
    let team_id:String?
    init(json:JSON) {
        self.team = json["team"].intValue
        self.playerrole = json["playerrole"].stringValue
        self.playercredit = json["playercredit"].stringValue
        self.role = json["role"].stringValue
        self.playerpoints = json["playerpoints"].stringValue
        self.playername = json["playername"].stringValue
        self.pid = json["pid"].intValue
        self.image = json["image"].stringValue
        self.team_id = json["team_id"].stringValue
    }
}

struct ViceCaptainCompare {
    let team: Int?
    let playerrole:String?
    let playercredit:String?
    let role: String?
    let playerpoints:String?
    let playername:String?
    let pid:Int?
    let image: String?
    let team_id:String?
    init(json:JSON) {
        self.team = json["team"].intValue
        self.playerrole = json["playerrole"].stringValue
        self.playercredit = json["playercredit"].stringValue
        self.role = json["role"].stringValue
        self.playerpoints = json["playerpoints"].stringValue
        self.playername = json["playername"].stringValue
        self.pid = json["pid"].intValue
        self.image = json["image"].stringValue
        self.team_id = json["team_id"].stringValue
    }
}
struct GetLEaderBoardResponse  {
    let userrank : Int?
    
    let points : String?
    let win_amount : String?
    let joinedusers : Int?
    let join_id : Int?
    let challenge_id : Int?
    let team_id : Int?
    let userid : Int?
    let team_number : Int?
    let name : String?
    var user_image:String?
    init(json:JSON) {
        self.userrank = json["userrank"].intValue
        
        self.points = json["points"].stringValue
        self.win_amount = json["win_amount"].stringValue
        self.joinedusers = json["joinedusers"].intValue
        self.join_id = json["join_id"].intValue
        self.challenge_id = json["challenge_id"].intValue
        self.team_id = json["team_id"].intValue
        self.userid = json["userid"].intValue
        self.team_number = json["team_number"].intValue
        self.name = json["name"].string
        self.user_image = json["user_image"].stringValue
        
    }
}
struct MyCatagries  {
    let id : Int?
    let name : String?
    let contest_sub_text : String?
    let contest_type_image : String?
    let sort_order : Int?
    let status : Int?
     let contest_image_url : String?
    var leagues = [MyLeague]()
    // let contest_type_image:String?
   
    init?(json:JSON) {
        
        self.id = json["id"].intValue
        self.name = json["name"].stringValue
        self.contest_sub_text = json["contest_sub_text"].stringValue
        self.contest_type_image = json["contest_type_image"].stringValue
        self.sort_order = json["sort_order"].intValue
        self.status = json["status"].intValue
         self.contest_image_url = json["contest_image_url"].stringValue
        guard let batterJSON = json["leagues"].array else { return  }
        let batters = batterJSON.map({ MyLeague(Leaguejson:  $0) })
        self.leagues = batters
        
        
        
    }
}

struct HomeContestResponse : Codable {
    let categories : [Categories]?
    let total_contest : Int?
    
    enum CodingKeys: String, CodingKey {
        
        case categories = "categories"
        case total_contest = "total_contest"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        categories = try values.decodeIfPresent([Categories].self, forKey: .categories)
        total_contest = try values.decodeIfPresent(Int.self, forKey: .total_contest)
    }
    
}

struct CreateContestResponses {
    let message : Bool?
    let challengeid : Int?
    
    init( json:JSON) {
        self.message = json["message"].bool
        self.challengeid = json["challengeid"].intValue
    }
}
struct CreateContestResponse : Codable {
    let message : Bool?
    let challengeid : Int?
    
    enum CodingKeys: String, CodingKey {
        
        case message = "message"
        case challengeid = "challengeid"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        message = try values.decodeIfPresent(Bool.self, forKey: .message)
        challengeid = try values.decodeIfPresent(Int.self, forKey: .challengeid)
    }
    
}
struct WinnerbreakUpResponse  {
    let id : Int?
    let winners : Int?
    let price : Double?
    let start_position : String?
    let total : Int?
    let description : String?
    init(json:JSON) {
        self.id = json["id"].intValue
        self.winners = json["winners"].intValue
        self.price = json["price"].doubleValue
        self.start_position = json["start_position"].stringValue
        self.total = json["total"].intValue
        self.description = json["description"].stringValue
    }
}
struct InvestMentAnalysis {
    let status : Int?
    var investment  : InvestmentResult?
    var wallet : InvestmentWallet?
    init(ijson:JSON) {
        self.status = ijson["status"].intValue
        self.investment = InvestmentResult(json: ijson["investment"])
        self.wallet = InvestmentWallet(walletJSON: ijson["wallet"])
    }
}
struct InvestmentResult {
    let total_invest:String?
    let total_recieve: String?
    let profit: String?
    let loss: String?
    init(json:JSON) {
        self.total_invest = json["total_invest"].stringValue
        self.total_recieve = json["total_recieve"].stringValue
        self.profit = json["profit"].stringValue
        self.loss = json["loss"].stringValue
    }
}

struct  InvestmentWallet {
    let total_deposit: String?
    let total_withdrawal: String?
    let profit: String?
    let loss : String?
    init(walletJSON : JSON) {
        self.total_deposit = walletJSON["total_deposit"].stringValue
        self.total_withdrawal = walletJSON["total_withdrawal"].stringValue
        self.profit = walletJSON["profit"].stringValue
        self.loss = walletJSON["loss"].stringValue
    }
}

struct MyLeague  {
    let id : Int?
    let name : String?
    let entryfee : Int?
    let win_amount : Int?
    let maximum_user : Int?
    let challenge_type : String?
    let winning_percentage : Int?
    let matchkey : String?
    let status : Int?
    let joinedusers : Int?
    let getjoinedpercentage : String?
    let multi_entry : Int?
    let confirmed_challenge : Int?
    let is_running : Int?
    let is_bonus : Int?
    let isselected : Bool?
    let isselectedid : String?
    let challenge_category_id : Int?
    let totalwinners : String?
    let bonus_percent:String?
    let announcement:String?
    let max_team_limit:Int?
    let first_rank_prize:Int?
    let first_rank_prizes:String?
    
    init(Leaguejson:JSON){
        
        self.id = Leaguejson["id"].intValue
        self.name = Leaguejson["name"].stringValue
        self.entryfee = Leaguejson["entryfee"].intValue
        self.win_amount = Leaguejson["win_amount"].intValue
        self.joinedusers = Leaguejson["joinedusers"].intValue
        self.challenge_type = Leaguejson["challenge_type"].stringValue
        self.matchkey = Leaguejson["matchkey"].stringValue
        self.status = Leaguejson["status"].intValue
        self.confirmed_challenge = Leaguejson["confirmed_challenge"].intValue
        self.is_running = Leaguejson["is_running"].intValue
        self.is_bonus = Leaguejson["is_bonus"].intValue
        self.isselectedid = Leaguejson["isselectedid"].stringValue
        self.challenge_category_id = Leaguejson["challenge_category_id"].intValue
        self.winning_percentage = Leaguejson["winning_percentage"].intValue
        self.getjoinedpercentage = Leaguejson["getjoinedpercentage"].stringValue
        self.multi_entry = Leaguejson["multi_entry"].intValue
        self.maximum_user = Leaguejson["maximum_user"].intValue
        self.totalwinners = Leaguejson["totalwinners"].stringValue
        self.bonus_percent = Leaguejson["bonus_percent"].stringValue
        self.isselected = Leaguejson["isselected"].bool
        self.announcement = Leaguejson["announcement"].stringValue
        self.max_team_limit = Leaguejson["max_team_limit"].intValue
        self.first_rank_prize = Leaguejson["first_rank_prize"].intValue
        self.first_rank_prizes = Leaguejson["first_rank_prizes"].stringValue
        
    }
}

struct Leagues : Codable {
    let id : Int?
    let name : String?
    let entryfee : Double?
    let win_amount : Double?
    let maximum_user : Int?
    let challenge_type : String?
    let winning_percentage : Int?
    let matchkey : String?
    let status : Int?
    let joinedusers : Int?
    let multi_entry : Int?
    let confirmed_challenge : Int?
    let is_running : Int?
    let is_bonus : Int?
    let isselected : Bool?
    let isselectedid : String?
    let challenge_category_id : Int?
    let totalwinners : String?
    
    enum CodingKeys: String, CodingKey {
        
        case id = "id"
        case name = "name"
        case entryfee = "entryfee"
        case win_amount = "win_amount"
        case maximum_user = "maximum_user"
        case challenge_type = "challenge_type"
        case winning_percentage = "winning_percentage"
        case matchkey = "matchkey"
        case status = "status"
        case joinedusers = "joinedusers"
        case multi_entry = "multi_entry"
        case confirmed_challenge = "confirmed_challenge"
        case is_running = "is_running"
        case is_bonus = "is_bonus"
        case isselected = "isselected"
        case isselectedid = "isselectedid"
        case challenge_category_id = "challenge_category_id"
        case totalwinners = "totalwinners"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        entryfee = try values.decodeIfPresent(Double.self, forKey: .entryfee)
        win_amount = try values.decodeIfPresent(Double.self, forKey: .win_amount)
        maximum_user = try values.decodeIfPresent(Int.self, forKey: .maximum_user)
        challenge_type = try values.decodeIfPresent(String.self, forKey: .challenge_type)
        winning_percentage = try values.decodeIfPresent(Int.self, forKey: .winning_percentage)
        matchkey = try values.decodeIfPresent(String.self, forKey: .matchkey)
        status = try values.decodeIfPresent(Int.self, forKey: .status)
        joinedusers = try values.decodeIfPresent(Int.self, forKey: .joinedusers)
        multi_entry = try values.decodeIfPresent(Int.self, forKey: .multi_entry)
        confirmed_challenge = try values.decodeIfPresent(Int.self, forKey: .confirmed_challenge)
        is_running = try values.decodeIfPresent(Int.self, forKey: .is_running)
        is_bonus = try values.decodeIfPresent(Int.self, forKey: .is_bonus)
        isselected = try values.decodeIfPresent(Bool.self, forKey: .isselected)
        isselectedid = try values.decodeIfPresent(String.self, forKey: .isselectedid)
        challenge_category_id = try values.decodeIfPresent(Int.self, forKey: .challenge_category_id)
        totalwinners = try values.decodeIfPresent(String.self, forKey: .totalwinners)
    }
    
}
struct  GetMatchDetails {
    let id : Int?
    let name : String?
    let format : String?
    let team1display:String
    let team2display:String?
    let   team1name:String?
    let team2name:String?
    let time_start : String?
    let team1logo:String?
    let team2logo:String?
    let seriesname:String?
    let short_nam:String?
    let series:String?
    let winnerstatus:String?
    let launch_status:String?
    let matchkey:String?
    let  lineup:Int?
    let is_leaderboard:Int?
    let announcement:String?
    init(json:JSON) {
        self.name = json["name"].stringValue
        self.format = json["format"].stringValue
        self.id = json["id"].int
        self.team1display = json["team1display"].stringValue
        self.team2display = json["team2display"].stringValue
        self.time_start = json["time_start"].stringValue
        self.team1logo = json["team1logo"].stringValue
        self.team2logo = json["team2logo"].stringValue
        self.seriesname = json["seriesname"].stringValue
        self.series = json["series"].stringValue
        self.winnerstatus = json["winnerstatus"].stringValue
        self.launch_status = json["launch_status"].stringValue
        self.short_nam = json["short_name"].string
        self.matchkey = json["matchkey"].stringValue
        self.lineup = json["lineup"].intValue
        self.team1name = json["team1name"].stringValue
        self.team2name = json["team2name"].stringValue
        self.announcement = json["announcement"].stringValue
        self.is_leaderboard = json["is_leaderboard"].intValue
    }
}

struct LeaderBoardSeriesDetail {
    let created:String?
    let id:Int?
    let image:String?
    let points :Int?
    let rank:Int?
    let series_id:Int?
    let  status :Int?
    let team :String?
    let updated:String?
    let user_id:Int?
    init(json:JSON) {
        self.created = json["created"].stringValue
        self.id = json["id"].intValue
        self.image = json["image"].stringValue
        self.points = json["points"].intValue
        self.series_id = json["series_id"].intValue
        self.status = json["status"].intValue
        self.rank = json["rank"].intValue
        self.team = json["team"].stringValue
        self.updated = json["updated"].stringValue
        self.user_id = json["user_id"].intValue
        
    }
}

struct  TournamentLeaderBoardResponse {
    let created_at:String?
    let end_date:String?
    let id:String?
    let is_leaderboard:Int?
    let name:String?
    let series_status:String
    let  slug:String?
    let start_date:String?
    init(json:JSON) {
        self.created_at = json["created_at"].string
        self.end_date = json["end_date"].stringValue
        self.id = json["id"].stringValue
        self.is_leaderboard = json["is_leaderboard"].intValue
        self.name = json["name"].stringValue
        self.series_status = json["series_status"].stringValue
        self.slug = json["slug"].stringValue
        self.start_date = json["start_date"].stringValue
    }

}
struct Getstatus : Codable {
    let status : Int?
    let image : String?
    
    enum CodingKeys: String, CodingKey {
        
        case status = "status"
        case image = "image"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Int.self, forKey: .status)
        image = try values.decodeIfPresent(String.self, forKey: .image)
    }
}

struct AllVerifyResponse : Codable {
    let mobile_verify : Int?
    let email_verify : Int?
    let bank_verify : Int?
    let pan_verify : Int?
    
    enum CodingKeys: String, CodingKey {
        
        case mobile_verify = "mobile_verify"
        case email_verify = "email_verify"
        case bank_verify = "bank_verify"
        case pan_verify = "pan_verify"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        mobile_verify = try values.decodeIfPresent(Int.self, forKey: .mobile_verify)
        email_verify = try values.decodeIfPresent(Int.self, forKey: .email_verify)
        bank_verify = try values.decodeIfPresent(Int.self, forKey: .bank_verify)
        pan_verify = try values.decodeIfPresent(Int.self, forKey: .pan_verify)
    }
    
}
struct AllVerifyResponses {
    let mobile_verify : Int?
    let email_verify : Int?
    let bank_verify : Int?
    let pan_verify : Int?
    
    init(json:JSON) {
        self.mobile_verify = json["mobile_verify"].intValue
        self.email_verify = json["email_verify"].intValue
        self.bank_verify = json["bank_verify"].intValue
        self.pan_verify = json["pan_verify"].intValue
    }
    
}
//struct MsgStatusResponse: Codable {
//    let msg : String?
//    let status : Int?
//
//    enum CodingKeys: String, CodingKey {
//
//        case msg = "msg"
//        case status = "status"
//    }
//
//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        msg = try values.decodeIfPresent(String.self, forKey: .msg)
//        status = try values.decodeIfPresent(Int.self, forKey: .status)
//    }
//
//}
struct BalanceModel  {
    let balance : String?
    let winning : String?
    let bonus : String?
    
    let total : String?
    let totalamount : String?
    let expireamount : Int?
    init(json:JSON) {
        self.balance = json["balance"].string
        self.winning = json["winning"].string
        self.bonus = json["bonus"].string
        self.total = json["total"].string
        self.totalamount = json["totalamount"].string
        self.expireamount = json["expireamount"].int
    }
}
struct MyBalanceModel : Codable {
    let balance : Double?
    let winning : Double?
    let bonus : Double?
    
    let total : Double?
    let totalamount : Double?
    let expireamount : Double?
    
    
    enum CodingKeys: String, CodingKey {
        
        case balance = "balance"
        case winning = "winning"
        case bonus = "bonus"
        
        case total = "total"
        case totalamount = "totalamount"
        case expireamount = "expireamount"
        
        
        
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        balance = try values.decodeIfPresent(Double.self, forKey: .balance)
        winning = try values.decodeIfPresent(Double.self, forKey: .winning)
        bonus = try values.decodeIfPresent(Double.self, forKey: .bonus)
        
        total = try values.decodeIfPresent(Double.self, forKey: .total)
        totalamount = try values.decodeIfPresent(Double.self, forKey: .totalamount)
        expireamount = try values.decodeIfPresent(Double.self, forKey: .expireamount)
        
    }
    
}

struct PaytmCheckSumResponse : Codable {
    let mID : String?
    let oRDER_ID : String?
    let cUST_ID : String?
    let iNDUSTRY_TYPE_ID : String?
    let cHANNEL_ID : String?
    let tXN_AMOUNT : String?
    let wEBSITE : String?
    let cALLBACK_URL : String?
    let eMAIL : String?
    let mOBILE_NO : String?
    let cHECKSUMHASH : String?
    
    enum CodingKeys: String, CodingKey {
        
        case mID = "MID"
        case oRDER_ID = "ORDER_ID"
        case cUST_ID = "CUST_ID"
        case iNDUSTRY_TYPE_ID = "INDUSTRY_TYPE_ID"
        case cHANNEL_ID = "CHANNEL_ID"
        case tXN_AMOUNT = "TXN_AMOUNT"
        case wEBSITE = "WEBSITE"
        case cALLBACK_URL = "CALLBACK_URL"
        case eMAIL = "EMAIL"
        case mOBILE_NO = "MOBILE_NO"
        case cHECKSUMHASH = "CHECKSUMHASH"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        mID = try values.decodeIfPresent(String.self, forKey: .mID)
        oRDER_ID = try values.decodeIfPresent(String.self, forKey: .oRDER_ID)
        cUST_ID = try values.decodeIfPresent(String.self, forKey: .cUST_ID)
        iNDUSTRY_TYPE_ID = try values.decodeIfPresent(String.self, forKey: .iNDUSTRY_TYPE_ID)
        cHANNEL_ID = try values.decodeIfPresent(String.self, forKey: .cHANNEL_ID)
        tXN_AMOUNT = try values.decodeIfPresent(String.self, forKey: .tXN_AMOUNT)
        wEBSITE = try values.decodeIfPresent(String.self, forKey: .wEBSITE)
        cALLBACK_URL = try values.decodeIfPresent(String.self, forKey: .cALLBACK_URL)
        eMAIL = try values.decodeIfPresent(String.self, forKey: .eMAIL)
        mOBILE_NO = try values.decodeIfPresent(String.self, forKey: .mOBILE_NO)
        cHECKSUMHASH = try values.decodeIfPresent(String.self, forKey: .cHECKSUMHASH)
    }
    
}

struct uploadImage {
    let image:String?
    let status:Int?
    init(json:JSON) {
        self.image = json["image"].stringValue
        self.status = json["status"].intValue
    }
}



struct MyContestLiveLeagues {
    let id: Int?
    let name: String?
    let short_name: String?
    let format : String?
    let series: Int?
    let team1name:String?
   let team2name:String?
    let seriesname: String?
    let team1display: String?
    let team2display: String?
    let matchkey: String?
    let winnerstatus: String?
    let launch_status: String?
    let match_status_key: String?
    let match_status: String?
    let sport_key: String?
    let joined_count: Int?
    let final_status: String?
    //"url": "http://fpapp.fantasypower11.com/",
    let team1logo: String?
    let team2logo : String?
    let lineup: Int?
    let team_count:Int?
        let announcement: String?
    let   winning_total:Int?
    
    let start_date : String?
    let time_start : String?
    
    init(joinLeagueJSON:JSON) {
        self.id = joinLeagueJSON["id"].intValue
        self.name = joinLeagueJSON["name"].stringValue
        self.team1display = joinLeagueJSON["team1display"].stringValue
        self.team2display = joinLeagueJSON["team2display"].stringValue
        self.matchkey = joinLeagueJSON["matchkey"].stringValue
        self.short_name = joinLeagueJSON["short_name"].string
        self.format = joinLeagueJSON["format"].stringValue
        self.series = joinLeagueJSON["series"].intValue
        self.seriesname = joinLeagueJSON["seriesname"].stringValue
        self.winnerstatus = joinLeagueJSON["winnerstatus"].stringValue
        self.launch_status = joinLeagueJSON["launch_status"].stringValue
        self.match_status = joinLeagueJSON["match_status"].stringValue
        self.sport_key = joinLeagueJSON["sport_key"].stringValue
        self.time_start = joinLeagueJSON["time_start"].stringValue
        self.team1logo = joinLeagueJSON["team1logo"].stringValue
        self.team2logo = joinLeagueJSON["team2logo"].stringValue
        self.start_date = joinLeagueJSON["start_date"].stringValue
        self.final_status = joinLeagueJSON["final_status"].stringValue
        self.lineup = joinLeagueJSON["lineup"].intValue
        self.joined_count = joinLeagueJSON["joined_count"].intValue
        self.match_status_key = joinLeagueJSON["match_status_key"].stringValue
        self.team_count = joinLeagueJSON["team_count"].intValue
 self.team1name = joinLeagueJSON["team1name"].stringValue
         self.team2name = joinLeagueJSON["team2name"].stringValue
          self.announcement = joinLeagueJSON["announcement"].stringValue
        self.winning_total = joinLeagueJSON["winning_total"].intValue
    }
}
struct ReferListResponse {
    let total_refers : Int?
    let name : String?
    let email : String?
    let amount : Int?
    let userid : Int?
    let date : String?
    init(json:JSON) {
        self.total_refers = json["total_refers"].intValue
        self.name = json["name"].stringValue
        self.email = json["email"].stringValue
        self.amount = json["Amount"].intValue
        self.userid = json["userid"].intValue
        self.date = json["date"].stringValue
    }
}
struct MessageResponses  {
    let status :Int?
    let message : String?
    init(json:JSON) {
        self.message = json["message"].string
        self.status = json["status"].intValue
    }
}
struct TeamUpdateMessageResponses  {
    let status :Int?
    let msg : String?
    init(json:JSON) {
        self.msg = json["msg"].stringValue
        self.status = json["status"].intValue
    }
}

//struct JoinLeagueResponse {
//let name : String?
//let teamid : Int?
//let refercode : String?
//let winamount : Double?
//let challenge_type : String?
//let winning_percentage : Double?
//let is_private : Int?
//let ismarathon : Int?
//let grand : Int?
//let confirmed : Int?
//let multi_entry : Int?
//let joinid : Int?
//let can_invite : Bool?
//let joinedusers : Int?
//let matchkey : String?
//let challenge_id : Int?
//let entryfee : Double?
//let maximum_user : Int?
//let price_card : [PriceCard]?
//let totalwinners : Int?
//let pricecardstatus : Int?
//let jointeams : [Jointeams]?
//let userrank : Int?
//let status : Int?
//    init(joinResponse:JSON) {
//        self.name = joinResponse["name"].stringValue
//        self.teamid = joinResponse["teamid"].intValue
//        
//        self.refercode = joinResponse["refercode"].stringValue
//        self.winamount = joinResponse["winamount"].doubleValue
//        self.winning_percentage = joinResponse["winning_percentage"].doubleValue
//        self.challenge_type = joinResponse["challenge_type"].stringValue
//        self.is_private = joinResponse["is_private"].intValue
//        self.ismarathon = joinResponse["ismarathon"].intValue
//        self.grand = joinResponse["grand"].intValue
//        self.confirmed = joinResponse["confirmed"].intValue
//        self.multi_entry = joinResponse["multi_entry"].intValue
//        self.joinid = joinResponse["joinid"].intValue
//        self.can_invite = joinResponse["can_invite"].boolValue
////        self.joinedusers = joinResponse
//    }
//}
struct BankResponses  {
    let status :Int?
    let msg : String?
    init(json:JSON) {
        self.msg = json["message"].stringValue
        self.status = json["status"].intValue
    }
}
struct MessageResponse : Codable {
    let message : String?
    
    enum CodingKeys: String, CodingKey {
        case message = "message"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        message = try values.decodeIfPresent(String.self, forKey: .message)
    }
}

struct LiveMatchResponse : Codable {
    let id : Int?
    
    enum CodingKeys: String, CodingKey {
        
        case id = "id"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        
    }
}
struct UserContestReponse  {
    //let matchkey : String?
    //let name : String?
    //let short_name : String?
    //let team1display : String?
    //let team2display : String?
    //let joined_count : Int?
    //let start_date : String?
    //let status : String?
    //let launch_status : String?
    //let final_status : String?
    //let series_name : String?
    //let team1logo : String?
    //let team2logo : String?
    //    init(json:JSON) {
    //
    //    }
    
}
struct AvatarUpdateResponse  {
    let status : String?
    let message : String?
    
    
    
    init(json:JSON) {
        self.status = json["status"].stringValue
        self.message = json["message"].stringValue
    }
}

struct joinedLeaguesResponse {
    let id: Int?
    let name: String?
    let short_name: String?
    let format : String?
    let series: Int?
    let seriesname: String?
    let team1display: String?
    let team2display: String?
    let matchkey: String?
    let winnerstatus: String?
    let launch_status: String?
    let match_status_key: String?
    let match_status: String?
    let sport_key: String?
    // let joined_count: Int?
    let final_status: String?
    //"url": "http://fpapp.fantasypower11.com/",
    let team1logo: String?
    let team2logo : String?
    let lineup: Int?
    //    let matchopenstatus: String?
    
    let start_date : String?
    let time_start : String?
    init(joinLeagueJSON:JSON) {
        self.id = joinLeagueJSON["id"].intValue
        self.name = joinLeagueJSON["name"].stringValue
        self.team1display = joinLeagueJSON["team1display"].stringValue
        self.team2display = joinLeagueJSON["team2display"].stringValue
        self.matchkey = joinLeagueJSON["matchkey"].stringValue
        self.short_name = joinLeagueJSON["short_name"].string
        self.format = joinLeagueJSON["format"].stringValue
        self.series = joinLeagueJSON["series"].intValue
        self.seriesname = joinLeagueJSON["seriesname"].stringValue
        self.winnerstatus = joinLeagueJSON["winnerstatus"].stringValue
        self.launch_status = joinLeagueJSON["launch_status"].stringValue
        self.match_status = joinLeagueJSON["match_status"].stringValue
        self.sport_key = joinLeagueJSON["sport_key"].stringValue
        self.time_start = joinLeagueJSON["time_start"].stringValue
        self.team1logo = joinLeagueJSON["team1logo"].stringValue
        self.team2logo = joinLeagueJSON["team2logo"].stringValue
        self.start_date = joinLeagueJSON["start_date"].stringValue
        self.final_status = joinLeagueJSON["final_status"].stringValue
        self.lineup = joinLeagueJSON["lineup"].intValue
        self.match_status_key = joinLeagueJSON["match_status_key"].stringValue
    }
}
struct BankDetailResponses {
    let accno : String?
    let ifsc : String?
    let bankname : String?
    let bankbranch : String?
    let state : String?
    let image : String?
    let imagetype : String?
    let status : Int?
    
    init(json:JSON) {
        self.accno = json["accno"].stringValue
        self.ifsc = json["ifsc"].stringValue
        self.bankname = json["bankname"].stringValue
        self.bankbranch = json["bankbranch"].stringValue
        self.state = json["state"].stringValue
        self.image = json["image"].stringValue
        self.imagetype = json["imagetype"].stringValue
        self.status = json["status"].intValue
    }
    
}
struct UpdateTeamResponse : Codable {
    let status : String?
    let code: Int?
    
    enum CodingKeys: String, CodingKey {
        case status = "status"
        case code = "code"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        code = try values.decodeIfPresent(Int.self, forKey: .code)
    }
    
}
struct BankDetailResponse : Codable {
    let accno : String?
    let ifsc : String?
    let bankname : String?
    let bankbranch : String?
    let state : String?
    let image : String?
    let imagetype : String?
    let status : Int?
    
    enum CodingKeys: String, CodingKey {
        
        case accno = "accno"
        case ifsc = "ifsc"
        case bankname = "bankname"
        case bankbranch = "bankbranch"
        case state = "state"
        case image = "image"
        case imagetype = "imagetype"
        case status = "status"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        accno = try values.decodeIfPresent(String.self, forKey: .accno)
        ifsc = try values.decodeIfPresent(String.self, forKey: .ifsc)
        bankname = try values.decodeIfPresent(String.self, forKey: .bankname)
        bankbranch = try values.decodeIfPresent(String.self, forKey: .bankbranch)
        state = try values.decodeIfPresent(String.self, forKey: .state)
        image = try values.decodeIfPresent(String.self, forKey: .image)
        imagetype = try values.decodeIfPresent(String.self, forKey: .imagetype)
        status = try values.decodeIfPresent(Int.self, forKey: .status)
    }
    
}
struct UserDetailsResponses : Codable {
    let id : Int?
    let username : String?
    let mobile : Int?
    let email : String?
    let dob : String?
    let dayOfBirth : String?
    let monthOfBirth : String?
    let yearOfBirth : String?
    let gender : String?
    let image : String?
    let avatar_id : Int?
    let avatar_image : String?
    let address : String?
    let city : String?
    let pincode : String?
    let walletamaount : Double?
    let verified : Int?
    let activation_status : String?
    let provider : String?
    let state : String?
    let country : String?
    let team : String?
    let teamfreeze : Int?
    let statefreeze : Int?
    let mobilefreeze : Int?
    let dobfreeze : Int?
    let refercode : String?
    let totalchallenges : Int?
    let totalwon : String?
    
    enum CodingKeys: String, CodingKey {
        
        case id = "id"
        case username = "username"
        case mobile = "mobile"
        case email = "email"
        case dob = "dob"
        case dayOfBirth = "DayOfBirth"
        case monthOfBirth = "MonthOfBirth"
        case yearOfBirth = "YearOfBirth"
        case gender = "gender"
        case image = "image"
        case avatar_id = "avatar_id"
        case avatar_image = "avatar_image"
        case address = "address"
        case city = "city"
        case pincode = "pincode"
        case walletamaount = "walletamaount"
        case verified = "verified"
        case activation_status = "activation_status"
        case provider = "provider"
        case state = "state"
        case country = "country"
        case team = "team"
        case teamfreeze = "teamfreeze"
        case statefreeze = "statefreeze"
        case mobilefreeze = "mobilefreeze"
        case dobfreeze = "dobfreeze"
        case refercode = "refercode"
        case totalchallenges = "totalchallenges"
        case totalwon = "totalwon"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        username = try values.decodeIfPresent(String.self, forKey: .username)
        mobile = try values.decodeIfPresent(Int.self, forKey: .mobile)
        email = try values.decodeIfPresent(String.self, forKey: .email)
        dob = try values.decodeIfPresent(String.self, forKey: .dob)
        dayOfBirth = try values.decodeIfPresent(String.self, forKey: .dayOfBirth)
        monthOfBirth = try values.decodeIfPresent(String.self, forKey: .monthOfBirth)
        yearOfBirth = try values.decodeIfPresent(String.self, forKey: .yearOfBirth)
        gender = try values.decodeIfPresent(String.self, forKey: .gender)
        image = try values.decodeIfPresent(String.self, forKey: .image)
        avatar_id = try values.decodeIfPresent(Int.self, forKey: .avatar_id)
        avatar_image = try values.decodeIfPresent(String.self, forKey: .avatar_image)
        address = try values.decodeIfPresent(String.self, forKey: .address)
        city = try values.decodeIfPresent(String.self, forKey: .city)
        pincode = try values.decodeIfPresent(String.self, forKey: .pincode)
        walletamaount = try values.decodeIfPresent(Double.self, forKey: .walletamaount)
        verified = try values.decodeIfPresent(Int.self, forKey: .verified)
        activation_status = try values.decodeIfPresent(String.self, forKey: .activation_status)
        provider = try values.decodeIfPresent(String.self, forKey: .provider)
        state = try values.decodeIfPresent(String.self, forKey: .state)
        country = try values.decodeIfPresent(String.self, forKey: .country)
        team = try values.decodeIfPresent(String.self, forKey: .team)
        teamfreeze = try values.decodeIfPresent(Int.self, forKey: .teamfreeze)
        statefreeze = try values.decodeIfPresent(Int.self, forKey: .statefreeze)
        mobilefreeze = try values.decodeIfPresent(Int.self, forKey: .mobilefreeze)
        dobfreeze = try values.decodeIfPresent(Int.self, forKey: .dobfreeze)
        refercode = try values.decodeIfPresent(String.self, forKey: .refercode)
        totalchallenges = try values.decodeIfPresent(Int.self, forKey: .totalchallenges)
        totalwon = try values.decodeIfPresent(String.self, forKey: .totalwon)
    }
    
}
struct UserDetailsResponse  {
    let id : Int?
    let username : String?
    let mobile : Int?
    let email : String?
    let dob : String?
    let dayOfBirth : String?
    let monthOfBirth : String?
    let yearOfBirth : String?
    let gender : String?
    let image : String?
    let address : String?
    let city : String?
    let pincode : String?
    let walletamaount : Double?
    let verified : Int?
    let activation_status : String?
    let provider : String?
    let state : String?
    let country : String?
    let team : String?
    let teamfreeze : Int?
    let statefreeze : Int?
    let mobilefreeze : Int?
    let dobfreeze : Int?
    let refercode : String?
    let totalchallenges : Int?
    let totalwon : String?
    
    init(userJson:JSON) {
        self.id = userJson["id"].intValue
        self.username = userJson["username"].stringValue
        self.mobile = userJson["mobile"].intValue
        self.email = userJson["email"].stringValue
        self.dob = userJson["dob"].stringValue
        self.dayOfBirth = userJson["dayOfBirth"].stringValue
        self.monthOfBirth = userJson["monthOfBirth"].stringValue
        self.yearOfBirth = userJson["yearOfBirth"].stringValue
        self.gender = userJson["gender"].stringValue
        self.image = userJson["image"].stringValue
        self.address = userJson["address"].stringValue
        self.city = userJson["city"].stringValue
        self.pincode = userJson["pincode"].stringValue
        self.walletamaount = userJson["walletamaount"].double
        self.verified = userJson["verified"].intValue
        self.activation_status = userJson["activation_status"].stringValue
        self.provider = userJson["provider"].stringValue
        self.state = userJson["state"].stringValue
        self.country = userJson["country"].stringValue
        self.team = userJson["team"].stringValue
        self.teamfreeze = userJson["teamfreeze"].intValue
        self.statefreeze = userJson["statefreeze"].intValue
        self.mobilefreeze = userJson["mobilefreeze"].intValue
        self.dobfreeze = userJson["dobfreeze"].intValue
        self.refercode = userJson["refercode"].stringValue
        self.totalchallenges = userJson["totalchallenges"].intValue
        self.totalwon = userJson["totalwon"].stringValue
        
    }
}
struct UpdateTeamResponses  {
let status : String?
let code: Int?
    init(json:JSON) {
        self.status = json["status"].stringValue
        self.code = json["code"].intValue
    }
}
struct MyContestReponse : Codable {
    let matchkey : String?
    let name : String?
    let short_name : String?
    let team1display : String?
    let team2display : String?
    let joined_count : Int?
    let start_date : String?
    let status : String?
    let launch_status : String?
    let final_status : String?
    let series_name : String?
    let team1logo : String?
    let team2logo : String?
    
    enum CodingKeys: String, CodingKey {
        
        case matchkey = "matchkey"
        case name = "name"
        case short_name = "short_name"
        case team1display = "team1display"
        case team2display = "team2display"
        case joined_count = "joined_count"
        case start_date = "start_date"
        case status = "status"
        case launch_status = "launch_status"
        case final_status = "final_status"
        case series_name = "series_name"
        case team1logo = "team1logo"
        case team2logo = "team2logo"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        matchkey = try values.decodeIfPresent(String.self, forKey: .matchkey)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        short_name = try values.decodeIfPresent(String.self, forKey: .short_name)
        team1display = try values.decodeIfPresent(String.self, forKey: .team1display)
        team2display = try values.decodeIfPresent(String.self, forKey: .team2display)
        joined_count = try values.decodeIfPresent(Int.self, forKey: .joined_count)
        start_date = try values.decodeIfPresent(String.self, forKey: .start_date)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        launch_status = try values.decodeIfPresent(String.self, forKey: .launch_status)
        final_status = try values.decodeIfPresent(String.self, forKey: .final_status)
        series_name = try values.decodeIfPresent(String.self, forKey: .series_name)
        team1logo = try values.decodeIfPresent(String.self, forKey: .team1logo)
        team2logo = try values.decodeIfPresent(String.self, forKey: .team2logo)
    }
    
}
struct myjoinedContest {
    let id : Int?
    let name : String?
    let challenge_id: Int?
    let challenge_type: String?
    let winning_percentage: Int?
    let entryfee: Int?
    let winning_amount: String?
    let win_amount: Int?
    let maximum_user: Int?
    let getjoinedpercentage: Int?
    let winners: Int?
    let userid: Int?
    let userrank: Int?
    let team_id: Int?
    let join_id: Int?
    let matchkey: String?
    let joinedusers: Int?
    let team1display: String
    let team2display: String?
    let  multi_entry:Int?
    let max_team_limit:Int?
    let confirmed_challenge: Int?
    let is_running: Int?
    let is_bonus: Int?
    let bonus_percent: Int?
    let isselected:Bool
    let isselectedid: String?
    let joinedleagueskey: Int?
    let points: Int?
    let isjoined: Bool?
    let join_with: Int?
    let refercode: String?
    let totalwinners: Int?
    let first_rank_prize: Int?
    let pdf: String?
    let user_image: String?
    let announcement:String?
    let is_free: Int?
    let  first_rank_prizes:String?
    init(json:JSON) {
        self.id = json["id"].intValue
        self.name = json["name"].stringValue
        self.challenge_id = json["challenge_id"].intValue
        self.challenge_type = json["challenge_type"].stringValue
        self.winning_percentage = json["winning_percentage"].intValue
        self.entryfee = json["entryfee"].intValue
        self.winning_amount = json["winning_amount"].stringValue
        self.win_amount = json["win_amount"].intValue
        self.maximum_user = json["maximum_user"].intValue
        self.getjoinedpercentage = json["getjoinedpercentage"].int
        self.winners = json["winners"].intValue
        self.userid = json["userid"].intValue
        self.userrank = json["userrank"].intValue
        self.team_id = json["team_id"].intValue
        self.join_id = json["join_id"].intValue
        self.matchkey = json["matchkey"].stringValue
        self.joinedusers = json["joinedusers"].intValue
        self.team1display = json["team1display"].stringValue
        self.team2display = json["team2display"].stringValue
        self.multi_entry = json["multi_entry"].intValue
        self.confirmed_challenge = json["confirmed_challenge"].intValue
        self.is_running = json["is_running"].intValue
        self.is_bonus = json["is_bonus"].intValue
        self.bonus_percent = json["bonus_percent"].intValue
        self.isselected = json["isselected"].boolValue
        self.isselectedid = json["isselectedid"].stringValue
        self.joinedleagueskey = json["joinedleagueskey"].intValue
        self.points = json["points"].intValue
        self.isjoined = json["isjoined"].boolValue
        self.join_with = json["join_with"].intValue
        self.refercode = json["refercode"].stringValue
        self.totalwinners = json["totalwinners"].intValue
        self.first_rank_prize = json["first_rank_prize"].intValue
        self.pdf = json["pdf"].stringValue
        self.user_image = json["user_image"].stringValue
        self.is_free = json["is_free"].intValue
        self.max_team_limit = json["max_team_limit"].intValue
         self.announcement = json["announcement"].stringValue
        self.first_rank_prizes = json["first_rank_prizes"].stringValue
    }
}

struct MyTeamResponses{
    let teamnumber:Int?
    let teamid: Int?
    let is_joined:Int?
    var  players:[PlayerDetail]?
    init(json:JSON) {
        self.teamnumber = json["teamnumber"].intValue
        self.teamid = json["teamid"].intValue
          self.is_joined = json["is_joined"].intValue
        guard let storePlayer = json["players"].array else { return  }
        let batters = storePlayer.map({ PlayerDetail(playerjson:  $0) })
        self.players = batters
      
    }
    
}
struct JoinLeagueResp {
    let message: String?
    let status: Bool?
    let grand: Int?
    let joinedusers: Int?
    let is_private: Bool?
    let multi_entry: Bool?
    let refercode: String?
    init(json:JSON) {
        self.message = json["message"].stringValue
        self.status = json["status"].boolValue
        self.grand = json["grand"].intValue
        self.joinedusers = json["joinedusers"].intValue
        self.is_private = json["is_private"].boolValue
        self.multi_entry = json["multi_entry"].boolValue
        self.refercode = json["refercode"].stringValue
    }
}

struct  userUsableBlc {
    let usertotalbalance : String?
    let usablebalance:String?
    let marathon: Int
    let is_bonus:Int
    init(json:JSON) {
        self.usertotalbalance = json["usertotalbalance"].stringValue
        self.usablebalance = json["usablebalance"].stringValue
        self.marathon = json["marathon"].intValue
        self.is_bonus = json["is_bonus"].intValue
    }
}

struct PlayerListResponses  {
    let image : String?
    var isSelected : String?
    let team : String?
    //  let teamname : String?
    let teamcolor : String?
    let series_points : Double?
    let role : String?
    let credit : String?
    let name : String?
    let id : Int?
    let teamcode : String?
    let vicecaptain: String?
    let captain:String?
    let playerkey : String?
    let start_date : String?
    let is_playing : Int?
    let is_playing_show : Int?
    let captain_selected_by:String?
    let vice_captain_selected_by:String?
    
    init(json:JSON) {
        self.image = json["image"].stringValue
        self.isSelected = json["isSelected"].stringValue
        self.team = json["team"].stringValue
        self.teamcolor = json["teamcolor"].stringValue
        self.series_points = json["series_points"].doubleValue
        self.role = json["role"].stringValue
        self.credit = json["credit"].stringValue
        //self.credit = json["name"].stringValue
        self.id = json["id"].intValue
        self.playerkey = json["playerkey"].stringValue
        self.start_date = json["start_date"].stringValue
        self.is_playing = json["is_playing"].intValue
        self.is_playing_show = json["is_playing_show"].intValue
        self.name = json["name"].stringValue
        self.teamcode = json["teamcode"].stringValue
        self.captain = json["captain"].stringValue
        self.vicecaptain = json["vicecaptain"].stringValue
        self.captain_selected_by = json["captain_selected_by"].stringValue
        self.vice_captain_selected_by = json["vice_captain_selected_by"].stringValue
        
    }
    
}

struct playerDetailinfo {
    let id: Int?
    let playername : String?
    let playerkey : String?
    let playercredit : String?
    let playerimage: String?
    let playerpoints: String?
    let battingstyle: String
    let bowlingstyle : String?
    let country: String?
    let dob: String
    let playerrole : String?
    let teams: String?
    let total_points:String?
    var  matches = [PlayerDetailInfoTable]()
    init(json:JSON) {
        self.id = json["id"].intValue
        self.playername = json["playername"].stringValue
        self.playerkey = json["playerkey"].stringValue
        self.playercredit = json["playercredit"].stringValue
        self.playerimage = json["playerimage"].stringValue
        self.playerpoints = json["playerpoints"].stringValue
        self.battingstyle = json["battingstyle"].stringValue
        self.bowlingstyle = json["bowlingstyle"].stringValue
        self.country = json["country"].stringValue
        self.dob = json["dob"].stringValue
        self.playerrole = json["playerrole"].stringValue
        self.teams = json["teams"].stringValue
        self.total_points = json["total_points"].stringValue
    guard let playerDetailTable = json["matches"].array else { return  }
        let getMatch = playerDetailTable.map({ PlayerDetailInfoTable(playerJson:  $0) })
    self.matches = getMatch
    }
}

struct PlayerDetailInfoTable {
    let matchdate:String?
    let  matchname:String?
    let playername : String?
    let selectper :String?
    let short_name :String
    let total_points :String?
     init(playerJson:JSON) {
        self.matchdate = playerJson["matchdate"].stringValue
        self.matchname = playerJson["matchname"].stringValue
        self.playername = playerJson["playername"].stringValue
        self.selectper = playerJson["selectper"].stringValue
        self.short_name = playerJson["short_name"].stringValue
        self.total_points = playerJson["total_points"].stringValue
    }
}
struct GetMatchleaderBoard {
    let id: Int?
               let series_id:Int?
               let match_id: String?
               let team_count: Int?
               let player_team_id: Int?
               let user_id: Int?
               let points: String?
               let created: String?
                let name: String?
    init(json:JSON) {
        self.id = json["id"].intValue
        self.series_id = json["series_id"].intValue
        self.match_id = json["match_id"].stringValue
        self.team_count = json["team_count"].intValue
        self.player_team_id = json["player_team_id"].intValue
        self.user_id = json["user_id"].intValue
        self.points = json["points"].stringValue
        self.created = json["created"].stringValue
        self.name = json["name"].stringValue
        
    }
    
}
struct PlayerDetail{
    let id : Int?
    let name : String?
    let role : String?
    let credit : String?
    let image : String?
    let team : String?
    let teamcolor : String?
    let vicecaptain : Int?
    let captain : Int?
    let series_points : Double?
    let is_playing:Int?
    
    let is_playing_show:Int?
    init(playerjson:JSON) {
        self.id = playerjson["id"].intValue
        self.name = playerjson["name"].stringValue
        self.role = playerjson["role"].stringValue
        self.credit = playerjson["credit"].stringValue
        self.image = playerjson["image"].stringValue
        self.team = playerjson["team"].stringValue
        self.teamcolor = playerjson["teamcolor"].stringValue
        self.vicecaptain = playerjson["vicecaptain"].int
        self.series_points = playerjson["series_points"].doubleValue
        self.captain = playerjson["captain"].int
        self.is_playing = playerjson["is_playing"].intValue
        self.is_playing_show = playerjson["is_playing_show"].intValue
        
    }
}
struct LeaderBoardFootballDetail {
    let teamname: String?
    let teamnumber:Int?
    let points: Int?
    let status: Int?
    var Forward:[LeaderBoardPlayerDetail]?
    var Defender:[LeaderBoardPlayerDetail]?
    var Goalkeeper:[LeaderBoardPlayerDetail]?
    var Midfielder:[LeaderBoardPlayerDetail]?
    init(json:JSON) {
        self.teamname = json["teamname"].stringValue
        self.points = json["points"].intValue
        self.status = json["status"].intValue
        self.teamnumber = json["teamnumber"].intValue
        guard let bowlersPlayr = json["Forward"].array else { return  }
        let batters = bowlersPlayr.map({ LeaderBoardPlayerDetail(playerjson:  $0) })
        self.Forward = batters
        
        guard let batsmanPlayer = json["Defender"].array else { return  }
        let datas = batsmanPlayer.map({ LeaderBoardPlayerDetail(playerjson:  $0) })
        self.Defender = datas
        guard let keeperPlayer = json["Goalkeeper"].array else { return  }
        let dataKeeper = keeperPlayer.map({ LeaderBoardPlayerDetail(playerjson:  $0) })
        self.Goalkeeper = dataKeeper
        guard let allrounderPlyr = json["Midfielder"].array else { return  }
        let dataAllRoundr = allrounderPlyr.map({ LeaderBoardPlayerDetail(playerjson:  $0) })
        self.Midfielder = dataAllRoundr
    }
    
}
struct LeaderBoardKabaddiDetail {
    let teamname: String?
    
    let teamnumber:Int?
    let points: Int?
    let status: Int?
    
    var Center:[LeaderBoardPlayerDetail]?
    var Pointguard:[LeaderBoardPlayerDetail]?
    var Powerforward:[LeaderBoardPlayerDetail]?
    var Shootingguard :[LeaderBoardPlayerDetail]?
    var Smallforward :[LeaderBoardPlayerDetail]?
    init(json:JSON) {
        self.teamname = json["teamname"].stringValue
        self.points = json["points"].intValue
        self.status = json["status"].intValue
        self.teamnumber = json["teamnumber"].intValue
        
        
        guard let batsmanPlayer = json["Center"].array else { return  }
        let datas = batsmanPlayer.map({ LeaderBoardPlayerDetail(playerjson:  $0) })
        self.Center = datas
        guard let keeperPlayer = json["Point guard"].array else { return  }
        let dataKeeper = keeperPlayer.map({ LeaderBoardPlayerDetail(playerjson:  $0) })
        self.Pointguard = dataKeeper
        guard let allrounderPlyr = json["Power forward"].array else { return  }
        let dataAllRoundr = allrounderPlyr.map({ LeaderBoardPlayerDetail(playerjson:  $0) })
        self.Powerforward = dataAllRoundr
        guard let shhotingGuard = json["Shooting guard"].array else { return  }
        let shooting = shhotingGuard.map({ LeaderBoardPlayerDetail(playerjson:  $0) })
        self.Shootingguard = shooting
        guard let smallGuard = json["Small forward"].array else { return  }
        let small = smallGuard.map({ LeaderBoardPlayerDetail(playerjson:  $0) })
        self.Smallforward = small
        
    }
    
}
struct LeaderBoardDetail {
    let teamname: String?
    
    let teamnumber:Int?
    let points: Int?
    let status: Int?
    var bowler:[LeaderBoardPlayerDetail]?
    var batsman:[LeaderBoardPlayerDetail]?
    var keeper:[LeaderBoardPlayerDetail]?
    var allrounder:[LeaderBoardPlayerDetail]?
    init(json:JSON) {
        self.teamname = json["teamname"].stringValue
        self.points = json["points"].intValue
        self.status = json["status"].intValue
        self.teamnumber = json["teamnumber"].intValue
        guard let bowlersPlayr = json["bowler"].array else { return  }
        let batters = bowlersPlayr.map({ LeaderBoardPlayerDetail(playerjson:  $0) })
        self.bowler = batters
        
        guard let batsmanPlayer = json["batsman"].array else { return  }
        let datas = batsmanPlayer.map({ LeaderBoardPlayerDetail(playerjson:  $0) })
        self.batsman = datas
        guard let keeperPlayer = json["keeper"].array else { return  }
        let dataKeeper = keeperPlayer.map({ LeaderBoardPlayerDetail(playerjson:  $0) })
        self.keeper = dataKeeper
        guard let allrounderPlyr = json["allrounder"].array else { return  }
        let dataAllRoundr = allrounderPlyr.map({ LeaderBoardPlayerDetail(playerjson:  $0) })
        self.allrounder = dataAllRoundr
    }
    
}

struct  NotificationArray {
    let title:String?
    let created_at:String?
    init(json:JSON) {
        self.title = json["title"].stringValue
        self.created_at = json["created_at"].stringValue
    }
}

struct LeaderBoardPlayerDetail{
    let id : Int?
    let name : String?
    let role : String?
    let credit : String?
    let image : String?
    let team : String?
    let teamcolor : String?
    let vicecaptain : Int?
    let captain : Int?
    let totalPoint : Double?
    let points:Double?
    init(playerjson:JSON) {
        self.id = playerjson["id"].intValue
        self.name = playerjson["name"].stringValue
        self.role = playerjson["role"].stringValue
        self.credit = playerjson["credit"].stringValue
        self.image = playerjson["image"].stringValue
        self.team = playerjson["team"].stringValue
        self.teamcolor = playerjson["teamcolor"].stringValue
        self.vicecaptain = playerjson["vicecaptain"].int
        self.totalPoint = playerjson["totalPoint"].doubleValue
        self.captain = playerjson["captain"].int
        self.points = playerjson["points"].doubleValue
        
    }
}
// MARK: - Jointeam
struct Jointeams : Codable {
    let teamname : String?
    let teamid : Int?
    let teamnumber : Int?
    let points : Double?
    let userid : Int?
    let is_show : Bool?
    
    enum CodingKeys: String, CodingKey {
        
        case teamname = "teamname"
        case teamid = "teamid"
        case teamnumber = "teamnumber"
        case points = "points"
        case userid = "userid"
        case is_show = "is_show"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        teamname = try values.decodeIfPresent(String.self, forKey: .teamname)
        teamid = try values.decodeIfPresent(Int.self, forKey: .teamid)
        teamnumber = try values.decodeIfPresent(Int.self, forKey: .teamnumber)
        points = try values.decodeIfPresent(Double.self, forKey: .points)
        userid = try values.decodeIfPresent(Int.self, forKey: .userid)
        is_show = try values.decodeIfPresent(Bool.self, forKey: .is_show)
    }
    
}
struct PriceCard : Codable {
    let id : Int?
    let winners : Int?
    let price : Double?
    let start_position : StartPosition?
    let total : Int?
    let description : String?
    
    enum CodingKeys: String, CodingKey {
        
        case id = "id"
        case winners = "winners"
        case price = "price"
        case start_position = "start_position"
        case total = "total"
        case description = "description"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        winners = try values.decodeIfPresent(Int.self, forKey: .winners)
        price = try values.decodeIfPresent(Double.self, forKey: .price)
        start_position = try values.decodeIfPresent(StartPosition.self, forKey: .start_position)
        total = try values.decodeIfPresent(Int.self, forKey: .total)
        description = try values.decodeIfPresent(String.self, forKey: .description)
    }
    
}
enum StartPosition: Codable {
    case integer(Int)
    case string(String)
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Int.self) {
            self = .integer(x)
            return
        }
        if let x = try? container.decode(String.self) {
            self = .string(x)
            return
        }
        throw DecodingError.typeMismatch(StartPosition.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for StartPosition"))
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .integer(let x):
            try container.encode(x)
        case .string(let x):
            try container.encode(x)
        }
    }
}


struct Locktime : Codable {
    let date : String?
    let timezone_type : Int?
    let timezone : String?
    
    enum CodingKeys: String, CodingKey {
        
        case date = "date"
        case timezone_type = "timezone_type"
        case timezone = "timezone"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        date = try values.decodeIfPresent(String.self, forKey: .date)
        timezone_type = try values.decodeIfPresent(Int.self, forKey: .timezone_type)
        timezone = try values.decodeIfPresent(String.self, forKey: .timezone)
    }
    
}



//"razorpay_payment_id": "pay_29QQoUBi66xm2f",
//"razorpay_order_id": "order_9A33XWu170gUtm",
//"razorpay_signature":
// CasshFree
struct CashFreeResult : Codable {
    let orderId: String
    let referenceId: String
    let orderAmount: String
    let txStatus: String
    let txMsg: String
    let txTime: String
    let paymentMode: String
    let signature: String
    
    enum CodingKeys : String, CodingKey {
        case orderId
        case referenceId
        case orderAmount
        case txStatus
        case txMsg
        case txTime
        case paymentMode
        case signature
    }
}
struct RazorPayResult  {
let id:String?
let entity:String?
let amount:Int?
    

    init(json:JSON) {
        self.id = json["id"].stringValue
        self.entity = json["entity"].stringValue
        self.amount = json["amount"].intValue
    }
}
