//
//  ApiNetworking.swift
//  Kandora
//
//  Created by sanjay kumar on 31/03/20.
//  Copyright © 2020 RGInfotech. All rights reserved.
//

import Foundation
import  Alamofire
import SwiftyJSON
import MBProgressHUD

typealias JSONDictionary = [String : Any]
typealias JSONDictionaryArray = [JSONDictionary]
typealias SuccessResponse = (_ json : JSON) -> ()
typealias FailureResponse = (NSError) -> (Void)
typealias ResponseMessage = (_ message : String) -> ()
//typealias UserTokenControllerSuccess = (_ usertoken : UserToken) -> ()
//ty//pealias UserProfileControllerSuccess = (_ user : UserProfile) -> ()
typealias DownloadData = (_ data : Data) -> ()
typealias UploadFileParameter = (fileName: String, key: String, data: Data, mimeType: String)

extension Notification.Name {
    static let NotConnectedToInternet = Notification.Name("NotConnectedToInternet")
}

var previousRequest : DataRequest?

enum AppNetworking {
    
    static let username = "admin"
    static let password = "12345"

    static var isConnectedToInternet: Bool {
        return NetworkReachabilityManager()!.isReachable
    }
    
    
    static func POST(endPoint : String,
                     parameters : JSONDictionary = [:],
                     headers : HTTPHeaders = [:],
                     loader : Bool = true,
                     success : @escaping (JSON) -> Void,
                     failure : @escaping (NSError) -> Void) {
        
        
        request(URLString: endPoint, httpMethod: .post, parameters: parameters, headers: headers, loader: loader, success: success, failure: failure)
    }
    
    static func POSTWithFiles(endPoint : String,
                              parameters : [String : Any] = [:],
                              files : [UploadFileParameter] = [],
                              headers : HTTPHeaders = [:],
                              loader : Bool = true,
                              success : @escaping (JSON) -> Void,
                              failure : @escaping (NSError) -> Void) {
        
        //upload(URLString: endPoint, httpMethod: .post, parameters: parameters, files: files, headers: headers, loader: loader, success: success, failure: failure)
    }
    
    static func GET(endPoint : String,
                    parameters : JSONDictionary = [:],
                    headers : HTTPHeaders = [:],
                    loader : Bool = true,
                    success : @escaping (JSON) -> Void,
                    failure : @escaping (NSError) -> Void) {
        
        request(URLString: endPoint, httpMethod: .get, parameters: parameters, encoding: JSONEncoding.default, headers: headers, loader: loader, success: success, failure: failure)
    }
    
    static func PUT(endPoint : String,
                    parameters : JSONDictionary = [:],
                    headers : HTTPHeaders = [:],
                    loader : Bool = true,
                    success : @escaping (JSON) -> Void,
                    failure : @escaping (NSError) -> Void) {

        request(URLString: endPoint, httpMethod: .post, parameters: parameters, headers: headers, loader: loader, success: success, failure: failure)
    }
    
    
static func imageUpload(postDictionary: [String: Any?], strApiUrl: String, video:Data?,  image:Data?, imageKey:String, document:Data?, docKey:String, in vc:UIViewController, showHud hud: Bool?, completion: @escaping (_ responce : AnyObject?,_ message : String,_ status : Bool) -> ()) {


        let urlString = "\(baseUrl)\(strApiUrl)"

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
    
    
//
//    static func PATCH(endPoint : String,
//                      parameters : JSONDictionary = [:],
//                      encoding: URLEncoding = URLEncoding.httpBody,
//                      headers : HTTPHeaders = [:],
//                      loader : Bool = true,
//                      success : @escaping SuccessResponse,
//                      failure : @escaping FailureResponse) {
//
//        request(URLString: endPoint, httpMethod: .patch, parameters: parameters, encoding: encoding, headers: headers, loader: loader, success: success, failure: failure)
//    }
//
//    static func DELETE(endPoint : String,
//                       parameters : JSONDictionary = [:],
//                       headers : HTTPHeaders = [:],
//                       loader : Bool = true,
//                       success : @escaping (JSON) -> Void,
//                       failure : @escaping (NSError) -> Void) {
//
//        request(URLString: endPoint, httpMethod: .delete, parameters: parameters, headers: headers, loader: loader, success: success, failure: failure)
//    }
//
//    static func DOWNLOAD(endPoint : String,
//                         parameters : JSONDictionary = [:],
//                         headers : HTTPHeaders = [:],
//                         mediaType : String,
//                         loader : Bool = true,
//                         success : @escaping (Bool) -> Void,
//                         failure : @escaping (NSError) -> Void) {
//
//        download(URLString: endPoint, httpMethod: .get, parameters: parameters, headers: headers, mediaType: mediaType, loader: loader, success: success, failure: failure)
//    }
//
//    private static func download(URLString : String,
//                                 httpMethod : HTTPMethod,
//                                 parameters : JSONDictionary = [:],
//                                 encoding: URLEncoding = URLEncoding.default,
//                                 headers : HTTPHeaders = [:],
//                                 mediaType : String,
//                                 loader : Bool = true,
//                                 success : @escaping (Bool) -> Void,
//                                 failure : @escaping (NSError) -> Void) {
//
//
//        var fileURL = URL(string: "")
//
//        let destination: DownloadRequest.DownloadFileDestination = { _, _  in
//
//            let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
//
//            fileURL = documentsURL.appendingPathComponent(mediaType.replace(string: "/", withString: "."))
//            return (fileURL!, [.removePreviousFile, .createIntermediateDirectories])
//
//        }
//
//        if loader { CommonFunctions.showActivityLoader() }
//
//        Alamofire.download(URLString, method: httpMethod, parameters: parameters, encoding: encoding, headers: headers, to: destination).response { (response) in
//
//            if loader { CommonFunctions.hideActivityLoader() }
//
//            if response.error != nil {
//                printDebug("===================== FAILURE =======================")
//                let e = response.error!
//                printDebug(e.localizedDescription)
//
//                if (e as NSError).code == NSURLErrorNotConnectedToInternet {
//                    NotificationCenter.default.post(name: .NotConnectedToInternet, object: nil)
//                }
//                failure(e as NSError)
//
//            } else {
//                printDebug("===================== RESPONSE =======================")
//                guard response.error == nil else { return }
//
//                switch mediaType {
//
//                case "video/mp4":  CustomPhotoAlbum.shared.saveVideo(videoFileUrl: fileURL!)
//
//                case "application/pdf":
//                    break
//                    //insantiate webViewVC
//                    //webView.loadRequest(URLRequest(url: fileURL!))
//
//                default: CustomPhotoAlbum.shared.saveImage(imageFileUrl: fileURL!)
//
//                }
//                success(true)
//            }
//        }
//    }
    
    private static func request(URLString : String,
                                httpMethod : HTTPMethod,
                                parameters : JSONDictionary = [:],
                                encoding: JSONEncoding = JSONEncoding.default,
                                headers : HTTPHeaders = [:],
                                loader : Bool = true,
                                success : @escaping (JSON) -> Void,
                                failure : @escaping (NSError) -> Void) {
        
//        if loader { CommonFunctions.showActivityLoader() }
        
        makeRequest(URLString: URLString, httpMethod: httpMethod, parameters: parameters, encoding: encoding, headers:headers
, loader: loader, success: { (json) in
//            let code = json[ApiKey.code].intValue
//            if code == ApiCode.tokenExpired || code == ApiCode.userDeleted {
//
////                WebServices.refreshToken(success: { (json) in
////                    if loader { CommonFunctions.hideActivityLoader() }
////                     makeRequest(URLString: URLString, httpMethod: httpMethod, parameters: parameters, encoding: encoding, headers: headers, loader: loader, success: success, failure: failure
////
////                }, failure: { (error) -> (Void) in
////                    failure(error)
////                })
//
//                failure(NSError(code: code, localizedDescription: "Token expired"))
//               // AppNavigator.shared.actionsOnLogout()
//
//            }else{
//                if loader { CommonFunctions.hideActivityLoader() }
                success(json)
//            }
        },
                    failure: failure)
    }
    
    private static func makeRequest(URLString : String,
                                httpMethod : HTTPMethod,
                                parameters : JSONDictionary = [:],
                                encoding:JSONEncoding = JSONEncoding.default,
                                headers : HTTPHeaders = [:],
                                loader : Bool = true,
                                success : @escaping (JSON) -> Void,
                                failure : @escaping (NSError) -> Void) {
       
        var updatedHeaders : HTTPHeaders = headers
        
        if headers.isEmpty{
            
            
            
            //            updatedHeaders[ApiKey.username] = "taghawk"
            //            updatedHeaders[ApiKey.password] = "taghawk@123"
            updatedHeaders["Content-Type"] = "application/json"
            updatedHeaders["Accept"] =  "application/json"
            
            
//            let auth = "taghawk:taghawk@123".base64Encoded
            
//            let token = UserProfile.main.accessToken.isEmpty ? "Basic \(auth)" : "Bearer \(UserProfile.main.accessToken)"
//
//            updatedHeaders [ApiKey.authorization] = token
//
//            updatedHeaders[ApiKey.accessToken] = UserProfile.main.accessToken
//
//            printDebug("updatedHeaders....\(updatedHeaders)")
        }
        
        
        
        let request = Alamofire.request(URLString, method: httpMethod, parameters: parameters, encoding: encoding, headers: updatedHeaders)


        previousRequest = request
//        request.responseJSON { response in
        request.responseJSON { (response:DataResponse<Any>) in

         //   if loader { CommonFunctions.hideActivityLoader() }

//            printDebug("===================== METHOD =========================")
//            printDebug(httpMethod)
//            printDebug("===================== ENCODING =======================")
//            printDebug(encoding)
//            printDebug("===================== URL STRING =====================")
//            printDebug(URLString)
//            printDebug("===================== HEADERS ========================")
//            printDebug(headers)
//            printDebug("===================== PARAMETERS =====================")
               print(parameters.description)

            switch(response.result) {
                       case .success(let value):
//                           printDebug("===================== RESPONSE =======================")
//                           printDebug(JSON(value))

                        let json = JSON(value)
                           
                           success(json)
                                        
                



            case .failure(let e):
//                printDebug("===================== FAILURE =======================")
//                printDebug(e.localizedDescription)
               // if loader { CommonFunctions.hideActivityLoader() }
                if (e as NSError).code == NSURLErrorNotConnectedToInternet {
                    NotificationCenter.default.post(name: .NotConnectedToInternet, object: nil)
                    
//                    Hud.shared.show_ErrorHud(LocalizedString.getTitleFor(title: .pleaseCheckInternetConnection))
//                    CommonFunctions.showToastMessage(LocalizedString.getTitleFor(title: .pleaseCheckInternetConnection))

                    failure(e as NSError)

                } else {
                    failure(e as NSError)
                   // Hud.shared.show_ErrorHud(e.localizedDescription)
                }
            }
        }
    }
    
//    private static func upload(URLString : String,
//                               httpMethod : HTTPMethod,
//                               parameters : JSONDictionary = [:],
//                               files : [UploadFileParameter] = [],
//                               headers : HTTPHeaders = [:],
//                               loader : Bool = true,
//                               success : @escaping (JSON) -> Void,
//                               failure : @escaping (NSError) -> Void) {
//
//        var updatedHeaders : HTTPHeaders = headers
//
//        if headers.isEmpty{
//
//
//
//            //            updatedHeaders[ApiKey.username] = "taghawk"
//            //            updatedHeaders[ApiKey.password] = "taghawk@123"
//            updatedHeaders[ApiKey.apiKey] = "1234"
//            updatedHeaders[ApiKey.platform] =  "2"
//
//            let auth = "taghawk:taghawk@123".base64Encoded
//
//            let token = UserProfile.main.accessToken.isEmpty ? "Basic \(auth)" : "Bearer \(UserProfile.main.accessToken)"
//
//            updatedHeaders [ApiKey.authorization] = token
//
//            updatedHeaders[ApiKey.accessToken] = UserProfile.main.accessToken
//
//            printDebug("updatedHeaders....\(updatedHeaders)")
//        }
//
//        guard let url = try? URLRequest(url: URLString, method: httpMethod, headers: updatedHeaders) else { return }
//
//        if loader { CommonFunctions.showActivityLoader() }
//
//        Alamofire.upload(multipartFormData: { (multipartFormData) in
//
//            files.forEach({ (fileParamObject) in
//
//                multipartFormData.append(fileParamObject.data, withName: fileParamObject.key, fileName: fileParamObject.fileName, mimeType: fileParamObject.mimeType)
//            })
//
//            parameters.forEach({ (paramObject) in
//
//                if let data = (paramObject.value as AnyObject).data(using : String.Encoding.utf8.rawValue) {
//                    multipartFormData.append(data, withName: paramObject.key)
//                }
//            })
//
//        }, with: url, encodingCompletion: { encodingResult in
//
//            switch encodingResult{
//            case .success(request: let upload, streamingFromDisk: _, streamFileURL: _):
//                upload.responseJSON(completionHandler: { (response:DataResponse<Any>) in
//
//                    if loader { CommonFunctions.hideActivityLoader() }
//
//                    printDebug("===================== METHOD =========================")
//                    printDebug(httpMethod)
//                    printDebug("===================== URL STRING =====================")
//                    printDebug(URLString)
//                    printDebug("===================== HEADERS ========================")
//                    printDebug(headers)
//                    printDebug("===================== PARAMETERS =====================")
//                    printDebug(parameters)
//
//                    switch response.result{
//                    case .success(let value):
//                        printDebug("===================== RESPONSE =======================")
//                        printDebug(JSON(value))
//
//                        success(JSON(value))
//                    case .failure(let e):
//                        printDebug("===================== FAILURE =======================")
//                        printDebug(e.localizedDescription)
//
//                        if (e as NSError).code == NSURLErrorNotConnectedToInternet {
//                            NotificationCenter.default.post(name: .NotConnectedToInternet, object: nil)
//                        }
//                        failure(e as NSError)
//                    }
//                })
//
//            case .failure(let e):
//
//                if loader { CommonFunctions.hideActivityLoader() }
//
//                if (e as NSError).code == NSURLErrorNotConnectedToInternet {
//                    NotificationCenter.default.post(name: .NotConnectedToInternet, object: nil)
//                }
//                failure(e as NSError)
//            }
//        })
//    }
}

