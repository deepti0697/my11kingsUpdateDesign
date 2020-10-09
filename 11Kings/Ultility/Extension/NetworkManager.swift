//
//  NetworkManager.swift
//  FantasyCricket
//
//  Created by Developer on 14/05/19.
//  Copyright © 2019 Developer. All rights reserved.
//

import UIKit
import Foundation
import Alamofire
import SwiftyJSON
class NetworkManager: NSObject {
    
    //MARK: Get
    class func get_Request(urlService: String, param: [String : Any]?, head: [String : String]?, completion: @escaping (_ anyObject: Any?) -> Void) {
        if Connectivity.isConnectedToInternet {
            guard let urlString = URL(string: kBASE_URL + urlService) else {
                completion(nil)
                return
            }
            let parameter = param
            let header = head
            Alamofire.request(urlString, method: .get, parameters: parameter, encoding: JSONEncoding.default, headers: header).validate().responseJSON { (response) in
                guard response.result.isSuccess else {
                    let errMsg = String(describing: response.result.error)
                    print(errMsg)
                    completion(nil)
                    return
                }
                guard let responseData = response.result.value else {
                    completion(nil)
                    return
                }
                print("""
                    ------------------------------------------------------------------------------------------
                    Url = \(urlString)
                    response.result.isSuccess = \(response.result.isSuccess)
                    errMsg = \(String(describing: response.result.error))
                    responseData = \(String(describing: response.result.value))
                    ------------------------------------------------------------------------------------------
                    """)
                completion(responseData)
            }
        } else {
            // Show Alert
        }
    }
    
    
    //MARK: Post
    class func post_Request3(urlService: String, param: [String : Any]?, head: [String : String]?, completion: @escaping (_ anyObject: Any?) -> Void) {
           if Connectivity.isConnectedToInternet {
               guard let urlString = URL(string: kBASE_URL + urlService) else {
                   completion(nil)
                   return
               }
               let parameter = param
               let header = head
               Alamofire.request(urlString, method: .post, parameters: parameter, encoding: URLEncoding.default, headers: header).responseJSON { (response) in
                   guard response.result.isSuccess else {
                       let errMsg = String(describing: response.result.error)
                       print(errMsg)
                       completion(nil)
                       return
                   }
                   guard let responseData = response.result.value else {
                       completion(nil)
                       return
                   }
                   print("""
                       ------------------------------------------------------------------------------------------
                       ******************************************************************************************
                       ------------------------------------------------------------------------------------------
                       Url = \(urlString)
                       response.result.isSuccess = \(response.result.isSuccess)
                       errMsg = \(String(describing: response.result.error))
                       responseData = \(String(describing: response.result.value))
                       ------------------------------------------------------------------------------------------
                       ******************************************************************************************
                       ------------------------------------------------------------------------------------------
                       """)
                   completion(responseData)
               }
           } else {
               Loader.showAlert(message: "No Internet Connection")
           }
       }
       
    class func post_Request(urlService: String, param: [String : Any]?, head: [String : String]?, completion: @escaping (_ anyObject: Any?) -> Void) {
        if Connectivity.isConnectedToInternet {
            guard let urlString = URL(string: kBASE_URL+urlService) else {
                completion(nil)
                return
            }
            let parameter = param
            let header = head
            
            Alamofire.request(urlString, method: .post, parameters: parameter, encoding: URLEncoding.default, headers: header).responseJSON { (response) in
                guard response.result.isSuccess else {
                    let errMsg = String(describing: response.result.error)
                    print(errMsg)
                    completion(nil)
                    return
                }
                
                guard let responseData = response.data else {
                    completion(nil)
                    return
                }
                print("""
                    ------------------------------------------------------------------------------------------
                    ******************************************************************************************
                    ------------------------------------------------------------------------------------------
                    Url = \(urlString)
                    response.result.isSuccess = \(response.result.isSuccess)
                    errMsg = \(String(describing: response.result.error))
                    responseData = \(String(describing: response.result.value))
                    ------------------------------------------------------------------------------------------
                    ******************************************************************************************
                    ------------------------------------------------------------------------------------------
                    """)
                completion(responseData)
            }
        } else {
            Loader.showAlert(message: "No Internet Connection")
        }
    }
    class func post_Request2(urlService: String, param: [String : Any]?, head: [String : String]?, completion: @escaping (_ anyObject: Any?) -> Void) {
           if Connectivity.isConnectedToInternet {
               guard let urlString = URL(string: kBASE_URL+urlService) else {
                   completion(nil)
                   return
               }
               let parameter = param
               let header = head
               
               Alamofire.request(urlString, method: .post, parameters: parameter, encoding: JSONEncoding.default, headers: header).responseJSON { (response) in
                   guard response.result.isSuccess else {
                       let errMsg = String(describing: response.result.error)
                       print(errMsg)
                       completion(nil)
                       return
                   }
                   
                   guard let responseData = response.data else {
                       completion(nil)
                       return
                   }
                   print("""
                       ------------------------------------------------------------------------------------------
                       ******************************************************************************************
                       ------------------------------------------------------------------------------------------
                       Url = \(urlString)
                       response.result.isSuccess = \(response.result.isSuccess)
                       errMsg = \(String(describing: response.result.error))
                       responseData = \(String(describing: response.result.value))
                       ------------------------------------------------------------------------------------------
                       ******************************************************************************************
                       ------------------------------------------------------------------------------------------
                       """)
                   completion(responseData)
               }
           } else {
               Loader.showAlert(message: "No Internet Connection")
           }
       }
     
    func uplodImage() {

    }
    static func imageUpload(postDictionary: [String: Any?], strApiUrl: String, video:Data?,  image:Data?, imageKey:String, document:Data?, docKey:String, in vc:UIViewController, showHud hud: Bool?, completion: @escaping (_ responce : AnyObject?,_ message : String,_ status : Bool) -> ()) {


        let urlString = "\(kBASE_URL)\(strApiUrl)"

        let url = try! URLRequest(url: URL(string:urlString)!, method: .post, headers: nil)

    
                        Alamofire.upload(
                            multipartFormData: { multipartFormData in
                                for (key, value) in postDictionary {
                                    if value is String
                                    {
                                        multipartFormData.append((value as AnyObject).data(using: String.Encoding.utf8.rawValue)!, withName: key)
                                    }else if value is [String]
                                    {

                                        for (_ ,value) in (value as! [String]).enumerated() {
                                            print("key value", key)

                                            multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key)
                                        }


                                    }


                                }

                                let date = Date()
                                let formatter = DateFormatter()
                                formatter.dateFormat = "ddyyyy_hhmmss"
                                let fileName = "profilePic".appending(formatter.string(from: date))

                                if image != nil {
                                    multipartFormData.append(image!, withName: imageKey, fileName: "\(fileName)_.png", mimeType: "image/png")
                                }

                                if document != nil {
                                    multipartFormData.append(image!, withName: docKey, fileName: "\(fileName)_.png", mimeType: "image/png")
                                }

                                if video != nil{
                                    multipartFormData.append(video!, withName: imageKey, fileName: "\(fileName)_.mp4", mimeType: "video/mp4")
                                }


                        }, with: url,
                           encodingCompletion: { encodingResult in

                            switch encodingResult {
                            case .success(let upload, _, _):
                                upload.responseJSON { response in
                                    print(response)

                                    if response.result.value != nil{

                                        let JSON = response.result.value! as AnyObject

                                        let responce = JSON as! NSDictionary

                                        completion(responce, "", true)
                                    }

                                }
                            case .failure( _):

                                completion(nil, "Error", false)
                                //self.presentAlertWithTitle(title:"", message: "Error", vc: vc)
                                break

                            }
                        }
                        )


    }
    
}
import Foundation
import Alamofire

class Connectivity {
    class var isConnectedToInternet: Bool {
        return NetworkReachabilityManager()!.isReachable
    }
}
