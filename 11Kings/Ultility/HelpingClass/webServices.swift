//
//  WebServices.swift
//  Kandora
//
//  Created by sanjay kumar on 31/03/20.
//  Copyright © 2020 RGInfotech. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire

enum WebServices { }

extension NSError {
    
    convenience init(localizedDescription : String) {
        self.init(domain: "AppNetworkingError", code: 0, userInfo: [NSLocalizedDescriptionKey : localizedDescription])
    }
    
    convenience init(code : Int, localizedDescription : String) {
        self.init(domain: "AppNetworkingError", code: code, userInfo: [NSLocalizedDescriptionKey : localizedDescription])
    }
    
   
}

extension WebServices {
    
    // MARK:- Common POST API
    //=======================
    static func commonPostAPI(parameters: JSONDictionary,
                              endPoint: EndPoint,
                              loader: Bool = true,
                              success : @escaping SuccessResponse,
                              failure : @escaping FailureResponse) {
        
        AppNetworking.POST(endPoint: endPoint.path, parameters: parameters, loader: loader, success: { (json) in
            
            success(json)
           // let code = json[ApiKey.code].intValue
           // let msg = json[ApiKey.message].stringValue
            

//            switch code {
//            case ApiCode.success: success(json)
//            default: failure(NSError(code: code, localizedDescription: msg))
//            }
        }) { (error) in
            failure(error)
        }
    }
    

    static func commonGetAPI(parameters: JSONDictionary,
                              endPoint: EndPoint,
                              loader: Bool = true,
                              success : @escaping SuccessResponse,
                              failure : @escaping FailureResponse) {
        
        AppNetworking.GET(endPoint: endPoint.path, parameters: parameters, loader: loader, success: { (json) in
//            let code = json[ApiKey.code].intValue
//            let msg = json[ApiKey.message].stringValue
//            switch code {
//            case ApiCode.success: success(json)
//            default: failure(NSError(code: code, localizedDescription: msg))
//            }
        }) { (error) in
            failure(error)
        }
    }
    
   //MARK:- Get token First time
    
    static func getFirstTimeToken(parameters: JSONDictionary,
    success: @escaping SuccessResponse,
    failure: @escaping FailureResponse){
       // self.commonPostAPI(parameters: parameters, endPoint: .token, success: success, failure: failure)
                self.commonPostAPI(parameters: parameters, endPoint: .token, success: { (json) in
                  //  UserToken.main = UserToken(json: json)
                    success(json)
                }) { (error) -> (Void) in
                    failure(error)
                }
    }

    // MARK:- Sign Up
    //===============
    static func signUp(parameters: JSONDictionary,
                       success: @escaping SuccessResponse,
                       failure: @escaping FailureResponse) {
        
        
        
        self.commonPostAPI(parameters: parameters, endPoint: .signup, success: success, failure: failure)
        
//        self.commonPostAPI(parameters: parameters, endPoint: .signup, success: { (json) in
//            //UserProfile.main = UserProfile(json: json[ApiKey.data])
//           // success(UserProfile.main)
//        }) { (error) -> (Void) in
//            failure(error)
//        }
    }
    
    // MARK:- Login
    //=============
//    static func login(parameters: JSONDictionary,
//                      success: @escaping UserProfileControllerSuccess,
//                      failure: @escaping FailureResponse) {
//
//        self.commonPostAPI(parameters: parameters, endPoint: .login, success: { (json) in
//            UserProfile.main = UserProfile(json: json)
//            success(UserProfile.main)
//        }) { (error) -> (Void) in
//            failure(error)
//        }
//    }
    
    static func register(parameters: JSONDictionary,
                         success: @escaping SuccessResponse,failure: @escaping FailureResponse){
        self.commonPostAPI(parameters: parameters, endPoint: .register, success: success, failure: failure)
    }
    
    static func verifyOtp(parameters: JSONDictionary,
                     success: @escaping SuccessResponse,failure: @escaping FailureResponse){
    self.commonPostAPI(parameters: parameters, endPoint: .verifyOtp, success: success, failure: failure)
    }
    
    // MARK:- Forgot Password
    //=======================
    static func forgotPassword(parameters: JSONDictionary,
                               success: @escaping SuccessResponse,
                               failure: @escaping FailureResponse) {
        
        self.commonPostAPI(parameters: parameters, endPoint: .forgotpassword, success: success, failure: failure)
    }
    
    // MARK:- Forgot Password
    //=======================
    static func resetPassword(parameters: JSONDictionary,
                              success: @escaping SuccessResponse,
                              failure: @escaping FailureResponse) {
        
        self.commonPostAPI(parameters: parameters, endPoint: .user, success: success, failure: failure)
    }
    
    
    static func editProfile(parameters: JSONDictionary,
                               success: @escaping SuccessResponse,
                               failure: @escaping FailureResponse) {
         
              self.commonPostAPI(parameters: parameters, endPoint: .user, success: success, failure: failure)
       // self.commonPutAPI(parameters: parameters, endPoint: .user, success: success, failure: failure)
     }
    
    
    static func viewProfile(parameters: JSONDictionary,
                               success: @escaping SuccessResponse,
                               failure: @escaping FailureResponse) {
         
              self.commonPostAPI(parameters: parameters, endPoint: .user, success: success, failure: failure)
     }
    
    static func addressList(parameters: JSONDictionary,
                                success: @escaping SuccessResponse,
                                failure: @escaping FailureResponse) {
          
               self.commonPostAPI(parameters: parameters, endPoint: .address, success: success, failure: failure)
      }
    
    
    
  static func storeList(parameters: JSONDictionary,
  success: @escaping SuccessResponse,
  failure: @escaping FailureResponse){
    
    self.commonPostAPI(parameters: parameters, endPoint: .storelist, success: success, failure: failure)
    
    }
    
    static func storeReview(parameters: JSONDictionary,
     success: @escaping SuccessResponse,
     failure: @escaping FailureResponse){
       
       self.commonPostAPI(parameters: parameters, endPoint: .store_review, success: success, failure: failure)
       
       }
    
    
    
    static func getCategories(parameters: JSONDictionary,
                              success: @escaping SuccessResponse,
                              failure: @escaping FailureResponse) {
        
       self.commonPostAPI(parameters: parameters, endPoint: .category, success: success, failure: failure)
    }
    
    
    static func productList(parameters: JSONDictionary,
                              success: @escaping SuccessResponse,
                              failure: @escaping FailureResponse) {
        
       self.commonPostAPI(parameters: parameters, endPoint: .productlist, success: success, failure: failure)
    }
    
    static func productDetail(parameters: JSONDictionary,
                                success: @escaping SuccessResponse,
                                failure: @escaping FailureResponse) {
          
         self.commonPostAPI(parameters: parameters, endPoint: .product, success: success, failure: failure)
      }
    
    
    static func wishList(parameters: JSONDictionary,
                                   success: @escaping SuccessResponse,
                                   failure: @escaping FailureResponse) {
             
            self.commonPostAPI(parameters: parameters, endPoint: .wishlist, success: success, failure: failure)
         }
       
    static func cartList(parameters: JSONDictionary,
                                   success: @escaping SuccessResponse,
                                   failure: @escaping FailureResponse) {
             
            self.commonPostAPI(parameters: parameters, endPoint: .cart, success: success, failure: failure)
         }
    
    
    
    static func store_images(parameters: JSONDictionary,
                                     success: @escaping SuccessResponse,
                                     failure: @escaping FailureResponse) {
               
              self.commonPostAPI(parameters: parameters, endPoint: .store_image, success: success, failure: failure)
           }
      
    
    static func shipping(parameters: JSONDictionary,
                                     success: @escaping SuccessResponse,
                                     failure: @escaping FailureResponse) {
               
              self.commonPostAPI(parameters: parameters, endPoint: .shipping, success: success, failure: failure)
           }
    
    static func payment(parameters: JSONDictionary,
                                     success: @escaping SuccessResponse,
                                     failure: @escaping FailureResponse) {
               
              self.commonPostAPI(parameters: parameters, endPoint: .payment, success: success, failure: failure)
           }
    
    
    static func checkout(parameters: JSONDictionary,
                                     success: @escaping SuccessResponse,
                                     failure: @escaping FailureResponse) {
               
              self.commonPostAPI(parameters: parameters, endPoint: .checkout, success: success, failure: failure)
           }
    
    static func order(parameters: JSONDictionary,
                                     success: @escaping SuccessResponse,
                                     failure: @escaping FailureResponse) {
               
              self.commonPostAPI(parameters: parameters, endPoint: .order, success: success, failure: failure)
           }
    
    static func review(parameters: JSONDictionary,
                                     success: @escaping SuccessResponse,
                                     failure: @escaping FailureResponse) {
               
              self.commonPostAPI(parameters: parameters, endPoint: .review, success: success, failure: failure)
           }
    
    
    static func measurement(parameters: JSONDictionary,
                                     success: @escaping SuccessResponse,
                                     failure: @escaping FailureResponse) {
               
              self.commonPostAPI(parameters: parameters, endPoint: .measurement, success: success, failure: failure)
           }
  
    static func kandora(parameters: JSONDictionary,
                                     success: @escaping SuccessResponse,
                                     failure: @escaping FailureResponse) {
               
              self.commonPostAPI(parameters: parameters, endPoint: .kandora, success: success, failure: failure)
           }
    
    
    static func kandora_option(parameters: JSONDictionary,
                                      success: @escaping SuccessResponse,
                                      failure: @escaping FailureResponse) {
                
               self.commonPostAPI(parameters: parameters, endPoint: .kandora_option, success: success, failure: failure)
            }
     
    
    static func measurement_cart(parameters: JSONDictionary,
                                      success: @escaping SuccessResponse,
                                      failure: @escaping FailureResponse) {
                
               self.commonPostAPI(parameters: parameters, endPoint: .measurement_cart, success: success, failure: failure)
            }
    static func getchallengebyCategaory(parameters: JSONDictionary,
                                        success: @escaping SuccessResponse,
                                        failure: @escaping FailureResponse) {
                  
                 self.commonPostAPI(parameters: parameters, endPoint: .getChallengebyCategaory, success: success, failure: failure)
              }
//    static func shareProduct(parameters: JSONDictionary,
//                                  success: @escaping (_ data : JSON) -> (),
//                                  failure: @escaping FailureResponse) {
//
//        self.commonPostAPI(parameters: parameters, endPoint: WebServices.EndPoint.share, loader: true, success: { (json) in
//            success(json)
//        }) { (error) -> (Void) in
//            failure(error)
//        }
//    }

    
    
//    static func addProduct(parameters: JSONDictionary,
//                             success: @escaping (_ data : JSON) -> (),
//                             failure: @escaping FailureResponse) {
//
//        self.commonPostAPI(parameters: parameters, endPoint: WebServices.EndPoint.product, loader: true, success: { (json) in
//            success(json)
//        }) { (error) -> (Void) in
//            failure(error)
//        }
//    }
    
    
//    static func featureProduct(parameters: JSONDictionary,
//                           success: @escaping (_ data : JSON) -> (),
//                           failure: @escaping FailureResponse) {
//
//        self.commonPostAPI(parameters: parameters, endPoint: WebServices.EndPoint.featureProduct, loader: true, success: { (json) in
//            success(json)
//        }) { (error) -> (Void) in
//            failure(error)
//        }
//    }
    
    
//    static func editProduct(parameters: JSONDictionary,
//                                  success: @escaping (_ data : JSON) -> (),
//                                  failure: @escaping FailureResponse) {
//        self.commonPutAPI(parameters: parameters, endPoint: WebServices.EndPoint.product, loader: true, success: { (json) in
//            success(json)
//        }) { (error) -> (Void) in
//            failure(error)
//        }
//    }
    
//    static func addToCart(parameters: JSONDictionary,
//                            success: @escaping (_ data : JSON) -> (),
//                            failure: @escaping FailureResponse) {
//
//        self.commonPostAPI(parameters: parameters, endPoint: WebServices.EndPoint.cart, loader: true, success: { (json) in
//            success(json)
//        }) { (error) -> (Void) in
//            failure(error)
//        }
//    }
//
//    static func getCart(parameters: JSONDictionary,
//                          success: @escaping (_ data : JSON) -> (),
//                          failure: @escaping FailureResponse) {
//
//        self.commonGetAPI(parameters: parameters, endPoint: WebServices.EndPoint.cart, loader: true, success: { (json) in
//            success(json)
//        }) { (error) -> (Void) in
//            failure(error)
//        }
//
//    }
//
//    static func logout(parameters: JSONDictionary,
//                          success: @escaping (_ data : JSON) -> (),
//                          failure: @escaping FailureResponse) {
//
//        self.commonPostAPI(parameters: parameters, endPoint: WebServices.EndPoint.logout, loader: true, success: { (json) in
//            success(json)
//        }) { (error) -> (Void) in
//            failure(error)
//        }
//    }
//
    
//    static func getPlaces(txt:String, success: @escaping (Bool,JSONDictionaryArray) -> Void, failure: @escaping (Error) -> Void) {
//
////        let url =  "\(EndPoint.placeUrl.rawValue)/input=%5C(\(txt)&key=AIzaSyBLnYswGr0oJrDmUHU3QLCteb_WjDMgv0w"
//
//        let url =  "\(EndPoint.placeUrl.rawValue)input=%5C(\(txt)&key=AIzaSyAd1acN1DZiiIg4EqBJR4-rxZIC96Rr47s"
//
//        AppNetworking.GET(endPoint: url, parameters: [:], loader: false, success: { json in
//
//            if let dict = json.dictionaryObject{
//
//                guard let _ = dict["status"] as? String else {
//                    success(false, [])
//                    return }
//
//                guard let data = dict["predictions"] as? JSONDictionaryArray else { return }
//
//                success(true, data)
//
//            }
//
//        }, failure: {(e : Error) -> Void in
//
//            // Handle respective error for login
//            failure(e)
//        })
//    }
//
//    static func getCordinates(placeId:String, success: @escaping (Bool,Double?,Double?) -> Void, failure: @escaping (Error) -> Void) {
//
//        // let url =  "https://maps.googleapis.com/maps/api/place/details/json?placeid=\(placeId)&key=AIzaSyBLnYswGr0oJrDmUHU3QLCteb_WjDMgv0w"
//
//        let url = "https://maps.googleapis.com/maps/api/place/details/json?placeid=\(placeId)&key=AIzaSyAd1acN1DZiiIg4EqBJR4-rxZIC96Rr47s"
//
//
//        AppNetworking.GET(endPoint: url, parameters: [:], loader: false, success: { json in
//
//            printDebug("place json is...\(json)")
//
//            if let dict = json.dictionaryObject{
//                guard let status = dict["status"] as? String , status == "OK" else {
//                    success(false,nil,nil)
//                    return }
//                guard let result = dict["result"] as? JSONDictionary else {
//                    success(false,nil,nil)
//                    return }
//                guard let geometry = result["geometry"] as? JSONDictionary else {
//                    success(false,nil,nil)
//                    return }
//                guard let location = geometry["location"] as? JSONDictionary else {
//                    success(false,nil,nil)
//                    return }
//
//                guard let lat = location["lat"] as? Double else {
//                    success(false,nil,nil)
//                    return }
//                guard let lng = location["lng"] as? Double else { return }
//                success(true, lat, lng)
//            }
//        }, failure: {(e : Error) -> Void in
//            // Handle respective error for login
//            failure(e)
//        })
//    }
    
  
    

//    static func getUserProfile(parameters: JSONDictionary, success: @escaping (_ data : JSON) -> (),
//                                failure: @escaping FailureResponse) {
//
//        AppNetworking.GET(endPoint: EndPoint.userProfile.path, parameters: parameters, loader: false, success: { (json) in
//
//           // success(json[ApiKey.data])
//        }) { (error) in
//            failure(error)
//        }
//    }
//
//
//
//    static func createCusomer(parameters: JSONDictionary,
//                           success: @escaping (_ data : JSON) -> (),
//                           failure: @escaping FailureResponse) {
//
//        self.commonPostAPI(parameters: parameters, endPoint: WebServices.EndPoint.createCustomer, loader: true, success: { (json) in
//            success(json)
//        }) { (error) -> (Void) in
//            failure(error)
//        }
//    }
//
//    static func sendToken(parameters: JSONDictionary,
//                              success: @escaping (_ data : JSON) -> (),
//                              failure: @escaping FailureResponse) {
//
//        self.commonPostAPI(parameters: parameters, endPoint: WebServices.EndPoint.charge, loader: true, success: { (json) in
//            success(json)
//        }) { (error) -> (Void) in
//            failure(error)
//        }
//
//    }
//
//
//
//    static func saveCard(parameters: JSONDictionary,
//                          success: @escaping (_ data : JSON) -> (),
//                          failure: @escaping FailureResponse) {
//
//        self.commonPostAPI(parameters: parameters, endPoint: WebServices.EndPoint.addCard, loader: true, success: { (json) in
//            success(json)
//        }) { (error) -> (Void) in
//            failure(error)
//        }
//    }
    
//    static func cashOut(parameters: JSONDictionary,
//                         success: @escaping (_ data : JSON) -> (),
//                         failure: @escaping FailureResponse) {
//
//        self.commonPostAPI(parameters: parameters, endPoint: WebServices.EndPoint.cashout, loader: true, success: { (json) in
//            success(json)
//        }) { (error) -> (Void) in
//            failure(error)
//        }
//    }
//
//    static func payOut(parameters: JSONDictionary,
//                        success: @escaping (_ data : JSON) -> (),
//                        failure: @escaping FailureResponse) {
//
//        self.commonPostAPI(parameters: parameters, endPoint: WebServices.EndPoint.payouts, loader: true, success: { (json) in
//            success(json)
//        }) { (error) -> (Void) in
//            failure(error)
//        }
//    }
    
    
    
//    static func deleteCard(parameters: JSONDictionary,
//                              success: @escaping (_ data : JSON) -> (),
//                              failure: @escaping FailureResponse) {
//        self.commonPutAPI(parameters: parameters,
//                          endPoint: WebServices.EndPoint.deleteCard,
//                          loader: true,
//                          success: { (json) in
//                            success(json)
//        }) { (error) -> (Void) in
//            failure(error)
//        }
//    }
    
  
    
//    static func getUserProducts(parameters: JSONDictionary,
//                                success: @escaping (_ data : JSON) -> (),
//                                failure: @escaping FailureResponse) {
//
//     AppNetworking.GET(endPoint: EndPoint.userProduct.path, parameters: parameters, headers: [:], loader: false, success: { (json) in
//
//        success(json)
//     }) { (error) in
//        failure(error)
//        }
//    }
//
//    static func updateProfile(parameters: JSONDictionary,
//                            success: @escaping (_ data : JSON) -> (),
//                            failure: @escaping FailureResponse) {
//        self.commonPutAPI(parameters: parameters,
//                          endPoint: WebServices.EndPoint.updateProfile,
//                          loader: true,
//                          success: { (json) in
//            success(json)
//        }) { (error) -> (Void) in
//            failure(error)
//        }
//    }
//
//    static func commonPutAPI(parameters: JSONDictionary,
//                              endPoint: EndPoint,
//                              loader: Bool = true,
//                              success : @escaping SuccessResponse,
//                              failure : @escaping FailureResponse) {
//
//        AppNetworking.PUT(endPoint: endPoint.path, parameters: parameters, loader: loader, success: { (json) in
//            let code = json["code"].intValue
//            let msg = json["message"].stringValue
//            switch code {
//            case ApiCode.success: success(json)
//            default: failure(NSError(code: code, localizedDescription: msg))
//            }
//        }) { (error) in
//            failure(error)
//        }
//    }
//
//
//
////    static func deleteProduct(parameters: JSONDictionary,
////                              success: @escaping (_ data : JSON) -> (),
////                              failure: @escaping FailureResponse) {
////
////        AppNetworking.DELETE(endPoint: EndPoint.product.path, parameters: parameters, headers: [:], loader: false, success: { (json) in
////            success(json[ApiKey.data])
////        }) { (error) in
////            failure(error)
////        }
////    }
//
//
//    // MARK:- RATINGS
//
//    static func getRatings(parameters: JSONDictionary,
//                                success: @escaping (_ data : JSON) -> (),
//                                failure: @escaping FailureResponse) {
//
//        AppNetworking.GET(endPoint: EndPoint.rating.path, parameters: parameters, headers: [:], loader: false, success: { (json) in
//            success(json)
//        }) { (error) in
//            failure(error)
//        }
//    }
    
//    static func postRating(parameters: JSONDictionary,
//                           success: @escaping (_ data : JSON) -> (),
//                           failure: @escaping FailureResponse) {
//
//        AppNetworking.POST(endPoint: EndPoint.rating.path, parameters: parameters, headers: [:], loader: false, success: { (json) in
//            success(json[ApiKey.data])
//        }) { (error) in
//            failure(error)
//        }
//    }
//
//    static func postRatingReply(parameters: JSONDictionary,
//                           success: @escaping (_ data : JSON) -> (),
//                           failure: @escaping FailureResponse) {
//
//        AppNetworking.POST(endPoint: EndPoint.ratingReply.path, parameters: parameters, headers: [:], loader: false, success: { (json) in
//            success(json[ApiKey.data])
//        }) { (error) in
//            failure(error)
//        }
//    }
    
//    static func updateDeviceToken(parameters: JSONDictionary,
//                                 success: @escaping (_ data : JSON) -> (),
//                                 failure: @escaping FailureResponse) {
//
//        AppNetworking.PUT(endPoint: EndPoint.updateToken.path, parameters: parameters, headers: [:], loader: false, success: { (json) in
//            success(json[ApiKey.data])
//        }) { (error) in
//            failure(error)
//        }
//    }
//
//    static func denyRating(parameters: JSONDictionary,
//                                  success: @escaping (_ data : JSON) -> (),
//                                  failure: @escaping FailureResponse) {
//
//        AppNetworking.PUT(endPoint: EndPoint.rating.path, parameters: parameters, headers: [:], loader: false, success: { (json) in
//            success(json[ApiKey.data])
//        }) { (error) in
//            failure(error)
//        }
//    }
    
//    static func saveBankDetails(parameters: JSONDictionary,
//                                success: @escaping (_ data : JSON) -> (),
//                                failure: @escaping FailureResponse) {
//
//        self.commonPostAPI(parameters: parameters, endPoint: WebServices.EndPoint.saveBankDetails, loader: true, success: { (json) in
//            success(json)
//        }) { (error) -> (Void) in
//            failure(error)
//        }
//    }
    

//    static func verifyOtp(parameters: JSONDictionary,
//                              success: @escaping (_ data : JSON) -> (),
//                              failure: @escaping FailureResponse) {
//        self.commonPutAPI(parameters: parameters, endPoint: EndPoint.verifyOtp, loader: true, success: { (json) in
//            success(json)
//        }) { (error) -> (Void) in
//            failure(error)
//        }
//    }
    
//    static func getBankData(parameters: JSONDictionary,
//                                          success: @escaping (_ data : JSON) -> (),
//                                          failure: @escaping FailureResponse) {
//
//        self.commonGetAPI(parameters: parameters, endPoint: WebServices.EndPoint.getBankData, loader: true, success: { (json) in
//            success(json)
//        }) { (error) -> (Void) in
//            failure(error)
//        }
//
//    }
//
//
//    static func getCards(parameters: JSONDictionary,
//                         success: @escaping (_ data : JSON) -> (),
//                         failure: @escaping FailureResponse) {
//
//        self.commonGetAPI(parameters: parameters, endPoint: WebServices.EndPoint.cardDetails, loader: true, success: { (json) in
//
//            success(json)
//
//        }) { (error) -> (Void) in
//            failure(error)
//        }
//    }
    
//    static func changePassword(parameters: JSONDictionary,
//                               success: @escaping (_ data : JSON) -> (),
//                               failure: @escaping FailureResponse) {
//
//        self.commonPostAPI(parameters: parameters, endPoint: WebServices.EndPoint.changePassword, loader: true, success: { (json) in
//            success(json)
//        }) { (error) -> (Void) in
//            failure(error)
//        }
//    }
    
//    static func notificationSettings(parameters: JSONDictionary,
//                          success: @escaping (_ data : JSON) -> (),
//                          failure: @escaping FailureResponse) {
//        self.commonPutAPI(parameters: parameters, endPoint: EndPoint.notificationSettings, loader: true, success: { (json) in
//            success(json)
//        }) { (error) -> (Void) in
//            failure(error)
//        }
//    }
    
//    static func getShippingRates(parameters: JSONDictionary,
//                          success: @escaping (_ data : JSON) -> (),
//                          failure: @escaping FailureResponse) {
//        self.commonPostAPI(parameters: parameters, endPoint: EndPoint.shippingRates, loader: true, success: { (json) in
//            success(json)
//
//        }) { (error) -> (Void) in
//            failure(error)
//        }
//    }
//
//    static func viewHtmlContent(parameters: JSONDictionary,
//                            success: @escaping (_ data : JSON) -> (),
//                              failure: @escaping FailureResponse) {
//
//        self.commonGetAPI(parameters: parameters, endPoint: WebServices.EndPoint.contentView, loader: true, success: { (json) in
//
//            success(json)
//
//        }) { (error) -> (Void) in
//            failure(error)
//        }
//    }
//
//
//
//
//    static func verifyUserEmail(parameters: JSONDictionary,
//                                success: @escaping (_ data : JSON) -> (),
//                                failure: @escaping FailureResponse) {
//
//        self.commonGetAPI(parameters: parameters, endPoint: WebServices.EndPoint.verifyEmail, loader: true, success: { (json) in
//
//            success(json)
//
//        }) { (error) -> (Void) in
//            failure(error)
//        }
//    }
//
//
//
//    static func addDebitCard(parameters: JSONDictionary,
//                         success: @escaping (_ data : JSON) -> (),
//                         failure: @escaping FailureResponse) {
//
//        self.commonPostAPI(parameters: parameters, endPoint: WebServices.EndPoint.addDebitCard, loader: true, success: { (json) in
//            success(json)
//        }) { (error) -> (Void) in
//            failure(error)
//        }
//    }
    
    
//
//    static func getProductPaymentHistory(parameters: JSONDictionary,
//                                         success: @escaping (_ data : PaymentHistory) -> (),
//                                         failure: @escaping FailureResponse) {
//
//        self.commonGetAPI(parameters: parameters, endPoint: WebServices.EndPoint.productPaymentStatus, loader: false, success: { (json) in
//
//            let data = PaymentHistory(json: json[ApiKey.data])
//            success(data)
//
//        }) { (error) -> (Void) in
//            failure(error)
//        }
//    }
    
//    static func uploadIdentity(parameters: [UploadFileParameter],
//                               success: @escaping (_ data : JSON) -> (),
//                               failure: @escaping FailureResponse){
//
//
//        AppNetworking.POSTWithFiles(endPoint: WebServices.EndPoint.uploadDocuemnt.path,
//                                    files : parameters,
//                                    success: { (json) in
//
//            success(json)
//
//        }) { (error) in
//            failure(error)
//        }
//
//    }
}
