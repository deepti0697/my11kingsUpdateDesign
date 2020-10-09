//
//  Constant.swift
//  Club11
//
//  Created by Developer on 17/05/19.
//  Copyright © 2019 Rickey_iDev. All rights reserved.
//

import Foundation
import UIKit

// MARK: DEVICE RELATED STUFF

enum UIUserInterfaceIdiom: Int {
    case Unspecified
    case Phone
    case Pad
}

struct ScreenSize {
    static let SCREEN_WIDTH = UIScreen.main.bounds.size.width
    static let SCREEN_HEIGHT = UIScreen.main.bounds.size.height
    static let SCREEN_MAX_LENGTH = max(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
    static let SCREEN_MIN_LENGTH = min(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
}

struct DeviceType {
    static let IS_IPHONE_4_OR_LESS = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH < 568.0
    static let IS_IPHONE_5 = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 568.0
    static let IS_IPHONE_6 = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 667.0
    static let IS_IPHONE_6P = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 736.0
    static let IS_IPHONE_X_OR_GREATER = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH >= 812.0
    static let IS_IPAD = UIDevice.current.userInterfaceIdiom == .pad && ScreenSize.SCREEN_MAX_LENGTH >= 1024.0
}

let homeTabOptions = ["Home", "My Matches", "Account", "More"]
let homeTabDefaultImage = ["ic_home 11", "trophy 11","user-silhouette 11", "menu-symbol-of-three-parallel-lines"]
let homeTabSelectedImage = ["ic_home 11","trophy Selected", "user-silhouette Selected", "menu-symbol-of-three-parallel-lines Selected"]

let contestTabOptions = ["Leagues", "Joined Leagues", "My Teams"]
let contestTabDefaultImage = ["leagues", "joined_leagues", "my_teams"]
let contestTabSelectedImage = ["leagues_active", "joined_leagues_active", "my_teams_active"]


let moreTitlesArray = ["Profile",
                       "Refer & Earn",
                       "Verify Account",
                       "Tournament Leaderboard",
                        "Fantasy Points System",
                        "Refer List",
                      "Privacy policy",
                       "Terms & Condition",
                        "About Us",
                        
                        "How To Play",
                        "Legalities",
                       "Contact us",
                       "Logout"
]
let moreImagesArray = [ "checkProfile",
                     "salary 11",
                     "verified-protection 11",
                     "LeadeboardTeamplte",
                       "analytics 11",
                       "search 11",
                       "balance 11",
                    
                       "docs 11",
                       "information 11",
                       "find 11",
                     
                     
                       "Legal",
                         "call 11",
                       "logout 11",
  "find 11",]


enum AccountCellType {
    case mobileCellType
    case pancardCellType
    case bankCellType
}

enum HomeType {
    case upcomming
    case live
    case result
}
enum MatchesType {
    case cricket
    case kabaddi
    case football
}

enum contestType {
    case AllContest
    case myJoinContest
    case myteam
}
// Constant views height
let kBannerTVCellIHeight: CGFloat = 150
let kContestTVCellHeight: CGFloat = 120
let kMyContestTVCellHeight: CGFloat = 150
let kToastHeightWithKeyBoard = 350
let kToastHeightDefault = 200

// Constant
let kUnderMaintainence = "Under Maintainence"
let kLoggedIn = "login"
let kUserId = "user_id"
let kRupeeIcon = "₹"
let kOTP = "otp"
let kEmailId = "email"
let kMobileNumber = "mobileNumber"
let kReferCode = "refercode"
let kSocialUserImage = "image"
let kTeamName = "teamName"
let kPanCardNo = "pancard"
let kBankAccountNo = "bankAccountNo"
let kOneDayMatch = "one-day"
let kT20Match = "t20"
let kInviteReferCode = "refercode"
let kAppStoreURL = "https://apps.apple.com/in/app/club11/id1470799448"
let kInsufficientBalance = "insufficient balance"
let kPleaseSelectTeam = "Please select team."


//MARK: API CONSTANTS
//http://dev.rglabs.net/repos/dev/11kings/api/auth/
let kProductionURl = "http://dev.rglabs.net/repos/dev/DT/api/auth/api/"
let kLiveURL = "https://my11kings.in/api/auth/"
let kBASE_URL = kLiveURL
let uploadPanBankImage = "upload-pan-image-android"
let profileImageUpdate = "update-profile-image"
let webBaseURL = "https://my11kings.in/"
let kBanner_URL = "get-banners"
let kLiveMatchURL = "leauges/livematchlist"
let kgetMatchList = "getmatchlist"
let kUpcomingMatchURL = "leauges/upcomingMatchlist"
let kResultsMatchURL = "leauges/Resultmatchlist"
let kRegisterUser = "register"
let kPlayerListURL = "getplayerlist"
let kCompare = "compare"
let kLoginURl = "login"
let KSaveTeamURL = ""
let kOTPRequest = "register"
let kSaveTeamURL = ""
let getTournamentSeries = "get-series"
let getTournamentLederboard = "get-series-leaderboard"
let getMatchLeaderBoard = "get-match-leaderboard"
let kGetChallengeURL = "get-challenges-by-category"
let kGetTotalLeague = "get-challenges-new"
let kgetReferCode = "get-refer-code"
let kForgotPassword = "forget-password"
let kMatchPoint = "matchplayerspoints"
let kRefreshContestDataURL = "refresh-scores-new"
let kMycontestUpcommingURl = "leauges/myJoinedMatches"
let kMycontestLiveURl = "leauges/myJoinedMatches_live"
let kMycontestResultURl = "leauges/myJoinedMatches_finished"
let kPrivacyPolicyURl = "privacy_policy"
let kTermsConditionURl = "terms_and_conditions"
let kAboutUsURl = "about_us"
let kHowToPlayURl = "how_to_play"
let kFantasyPointURl = "fantasy_point_system"
let kClub11PerkURL = "http://www.club11perks.in"
let kupdateTeam = "updateteamleauge"
let kMyTeamURL = "myjointeam"
let kMyJoinedLeagueURL = "myjoinedleauges"
let kMyBalance = "mybalance"
let kMYInvestment = "investments"
let kMyTransaction = "mytransaction"
let kMyPlayingHistory = "my-play-history"
let kApplyPromoCode = "verify-promo-code"
let kContestJoined = "joinleague"
let kReferredListURL = "referrallist"
let kTopWinnerURL = "winningamount"
let kWinnerbreakUpURL = "getscorecards"
let kVeriftyMobile = "verify_otp"
let kSendNewOtp = "send_new_otp"
let kverifyMobileOnRegister = "verify-otp-register"
let kVerifyMail = "send-new-mail"
let kcomissionList = "main-admin/commisionlist"
let kUserDetailsURL = "user-full-details"
let kAllProfileAvatarsUrl = "get_avatars"
let kUsableBalance = "myusablebalance"
let kUpdateAvatar = "update_avatar"
let kEditprofileURL = "edit-profile"
let kAllVerify = "all-verify"
let kPanDetailsURL = "see-pan-details"
let kBankDetailsURL = "seebankdetails"
let kCreateTeamURL = "create-team"
let kPlayerInfo = "playerfullinfo"
let kSocialLoginURL = "social-login"
let kJoinedByCode = "join-by-code"
let KShowTeamOnGround = "getteamtoshow"
let kNotification = "usernotifications"
let kJoinContest = "leauges/joinleauge"
let kBankVerify = "bank-verify"
let kUploadBankPanImage = "upload-pan-image"
let kUploadAndoirdPan = "upload-pan-image-android"
let kUploadImageUrl = ""
let kPanVerify = "verify-pan-request"
let kUpdateTeamName = "updateteamname"
let kLeaderboardURL = "leaderboard"
let kGetCategoryLeagues = "category-leagues"
let kFacebookURL = "https://www.facebook.com/My11kings/"
let kTwitterURL = "https://twitter.com/My11kings"
let kInstaGramURL = "https://www.instagram.com/my11kings/"
let kYoutubeURL = "https://www.youtube.com/channel/UCxOabJ9yxw-q-e8TyY5q3Bg?view_as=subscriber"
let kLegalitiesUrl = "legalities.html"
let kFairPlayUrl = "fair_play.html"
let kResetPasswordURL = "resetpassword"
let kMatchCodeResetURL = "matchcodeforreset"
let kCreateChallengeURL = "create-challenge"
let kEditTeamURL = "user_team_edit_info"
let kPayTmCheckSumURL = "get_paytm_checksum"
let kAmountWithDrawURl = "request-withdraw"
let kGetTokenURL = "get_token"
let kSwitchTeamURL = "leauges/updateteamchallenge"
let kInviteReferCodeURL = "verifyrefercode"
let kAndroidAddfundURL = "android-add-fund-api"
let kOrderId = "razorpay"
let kPlayerPointsURL = "leauges/matchplayerspoints"
let getChallengebycategory = "get-challenges-by-category"
let getPlayerinfoDetail = "playerfullinfo"
let getAllMatches = "myjoinedmatches?=live"
let changePassword = "change-password"
let referBonusList = "refer-bonus-list"
let testimonial = "testimonial-app"
let fqs = "legalities-app"
let socailLogin = "social-login"
//let
