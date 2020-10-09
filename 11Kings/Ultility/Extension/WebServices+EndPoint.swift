//
//  WebService+EndPoint.swift
//  Kandora
//
//  Created by sanjay kumar on 31/03/20.
//  Copyright © 2020 RGInfotech. All rights reserved.
//

let baseUrl = "http://dev.rglabs.net/repos/keshav/dreamT/api/auth"

extension WebServices {
    
    enum EndPoint : String {
        case register = "/register"
        case verifyOtp = "verify_otp"
        case placeUrl = "https://maps.googleapis.com/maps/api/place/autocomplete/json?"
        case privacy = "http://caltexadminst.appinventive.com/term-condition"
        case terms = "1"
        case token = "api/token"
        case login = "api/login"
        case sociallogin = "user/social-login"
        case checkSocialLogin = "user/checkSocialLogin"
        case signup = "api/register"
        case forgotpassword = "api/forgot"
        case user = "api/user" //This is used for profile,password,view
        case address = "api/address"//This is used for list,add,edit,delete,view
        case storelist = "api/store_list"
        case store_review = "api/store_review"
        case category = "api/category_list"
        case productlist = "api/product_list"
        case product  = "api/product"
        case wishlist  = "api/wishlist"
        case cart  = "api/cart"
        case store_image  = "api/store_image"
        case shipping  = "api/shipping"
        case payment  = "api/payment"
        case checkout  = "api/checkout"
        case order  = "api/order"
        case review  = "api/review"
        case measurement  = "api/measurement"
        case kandora  = "api/kandora"
        case kandora_option  = "api/kandora_option"
        case measurement_cart  = "api/measurement_cart"
        case getChallengebyCategaory = "get-challenges-by-category"
        
//        case suggestions = "product/suggestion"
//        case productDetail = "product/info"
//        case likeUnlike = "product-like-unlike"
//        case share = "product/share"
//        case reportProduct = "user-report-product"
//        case featureProduct = "product-promotion"
//        case cart = "cart"
//        case logout = "user/logout"
//        case joinTag = "tag/request-member"
//        case profiledata
//        case managefriends = "manage-friend"
//        case guest = "user-guest"
//        case userProfile = "user/profile"
//        case userProduct = "user/product"
//        case notificationList = "notification/list"
//        case updateProfile = "user/update-profile"
//        case readNotification = "notification/mark-read"
//        case verifyOtp = "user/verify-phone"
//        case follow = "user/friend-follow"
//        case friends = "user/friends"
//        case removeFriend = "user/friend-remove"
//        case rating = "rating"
//        case ratingReply = "rating/reply"
//        case createCustomer = "payment/create/Customer"
//        case updateToken = "user/update-device-token"
//        case refresh
//        case charge = "payment/create/charges"
//        case saveBankDetails = "payment/save/bankDetails"
//        case getBankData = "payment/bankData"
//        case createMerchant = "payment/create/Merchant"
//        case cardDetails = "payment/user/card-details"
//        case addCard = "payments/add-card"
        
        
        var path : String {
            let url = baseUrl
            return url + self.rawValue
            
        }
    }
}
class UrlService {
    static let shared = UrlService()
    static let register = "http://dev.rglabs.net/repos/dev/DT/api/auth/register"
    static let verify_register_OTP = "http://dev.rglabs.net/repos/dev/DT/api/auth/verify-otp-register"
      
     static let socialLogin = "http://dev.rglabs.net/repos/dev/DT/api/auth/social-login"
    static let login = "http://dev.rglabs.net/repos/dev/DT/api/auth/login"
    static let otp = "http://dev.rglabs.net/repos/dev/DT/api/auth/verify-otp-register"
    static let resendOtp = "http://dev.rglabs.net/repos/dev/DT/api/auth/send_new_otp"
    static let getmatchkey = "http://dev.rglabs.net/repos/dev/DT/api/auth/getmatchlist"
    static let getmatchList = "http://dev.rglabs.net/repos/dev/DT/api/auth/getmatchlist"
    }
    

