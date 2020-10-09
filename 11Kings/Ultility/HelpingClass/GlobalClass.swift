//
//  Global_Class.swift
//  Elite USA
//
//  Created by Aadmin on 25/06/18.
//  Copyright © 2018 Mac. All rights reserved.
//

import UIKit
import Alamofire
import SystemConfiguration




let APPDELEGATE = UIApplication.shared.delegate as! AppDelegate
let SCREEN_WIDTH = UIScreen.main.bounds.size.width
let SCREEN_HEIGHT = UIScreen.main.bounds.size.height

//let BASE_URL = "http://35.168.99.29/eliteusa/administrator/api/"
//let BASE_URL2 = "http://35.168.99.29/eliteusa/restaurant/"   //- Developement

//let BASE_URL = "http://elite-usa.com/administrator/api/"
//let BASE_URL2 = "http://elite-usa.com/restaurant/"     //- Production

let BASE_URL = "http://dev.rglabs.net/repos/keshav/dreamT/api/auth/"
let BASE_URL2 = "http://dev.rglabs.net/repos/keshav/dreamT/api/auth/"     //- Production SSL

var LOCAL_TIME_ZONE: Int { return TimeZone.current.secondsFromGMT() }

var DeviceToken = ""
var serviceID = ""
var CUSTOMER_ID = ""

//var COLOR_TEXT_S_BlACK = UIColor.init(colorLiteralRed: 61.0/255.0, green: 61.0/255.0, blue: 61.0/255.0, alpha: 1)

//var COLOR_THEME = UIColor.init(colorLiteralRed: 61.0/255.0, green: 61.0/255.0, blue: 61.0/255.0, alpha: 1)

let OBJ_STORYBOARD_Global = UIStoryboard(name: "Main", bundle: nil)

//////////////

enum messageType : String{
    case text = "text"
    case image = "image"
    case voice = "voice"
}


class Global_Class: NSObject {
    
    class func trimSpaceAndNewLines(_ textField : UITextField) -> String {
        return (textField.text?.trimmingCharacters(in: .whitespacesAndNewlines))!
    }
    
    class func checkBlank(_ textField : UITextField) -> Bool {
        return textField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ? true : false
        
    }
    
    
    class func setBorderColorWithBorder1(_ myView : UIView, _color : UIColor) {
        
        myView.layer.borderColor = _color.cgColor
        myView.layer.borderWidth = 0
        myView.layer.cornerRadius = 2.0
    }
    
    
    
    //MARK:- Function for MBProgressHUD
    
    // uncomment when install MBProgressHUD pod
    //    class func showHUD(_ view : UIView)
    //    {
    //        DSBezelActivityView.newActivityView(for: UIApplication.shared.delegate?.window!)
    //
    //    }
    //
    //    class func hideHud(_ view: UIView)
    //    {
    //        DSBezelActivityView.remove(animated: true)
    //    }
    
    //MARK:-  Function for user default
    
    class func setUserDefaultDICT(value: NSDictionary)
    {
        UserDefaults.standard.set(NSKeyedArchiver.archivedData(withRootObject: value), forKey: "dictUserDefult")
    }
    
    class func getUserDefaultDICT()-> NSDictionary
    {
        let dataa = UserDefaults.standard.object(forKey: "dictUserDefult") as! NSData
        let obj = NSKeyedUnarchiver.unarchiveObject(with: dataa as Data) as! NSDictionary
        //        print(obj)
        return obj
    }
    class func setUserDefault(value: String, for key: String)
    {
        let defaults =  UserDefaults.standard
        defaults.set(value, forKey: key)
    }
    
    class func getUserDefault(_ forKEY: String)-> String
    {
        let defaults = UserDefaults.standard
        return defaults.value(forKey: forKEY) as? String ?? ""
    }
    
    class func removeUserDefaults(_ forKEY : String)
    {
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: forKEY)
    }
    
    class func isKeyPresentInUserDefaults(key: String) -> Bool {
        return UserDefaults.standard.object(forKey: key) != nil
    }
    
    
    
    //MARK:- Functions For String
    
    class func trimSpace(text textForTrim : String) -> String
    {
        let trimText = textForTrim.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        return trimText
    }
    
    //MARK:- Functions for alert
    
    class func showAlert(alertTitle : String, alertMsg : String, view: UIViewController) {
        
        let alert = UIAlertController(title: alertTitle, message: alertMsg, preferredStyle: UIAlertController.Style.alert)
        
        let actionOK : UIAlertAction = UIAlertAction(title: "OK", style: .default) { (alt) in
            print("This is ok action");
        }
        alert.addAction(actionOK)
        
        view.present(alert, animated: true, completion: nil)
        
    }
    
    class func showAlertOKAction(_ alertTitle : String, _ alertMsg : String, _ okTitle : String, _ view: UIViewController, successClosure: @escaping (String?) -> () ) {
        
        let alert = UIAlertController(title: alertTitle, message: alertMsg, preferredStyle: UIAlertController.Style.alert)
        
        let actionOK : UIAlertAction = UIAlertAction(title: okTitle, style: .default) { (alt) in
            print("This is ok action");
            successClosure("OK")
        }
        alert.addAction(actionOK)
        
        view.present(alert, animated: true, completion: nil)
        
    }
    
    class func showAlertOKCancelAction(_ alertTitle : String, _ alertMsg : String, _ view: UIViewController, successClosure: @escaping (String?) -> (), cancelClosure: @escaping (String?) -> () ) {
        
        let alert = UIAlertController(title: alertTitle, message: alertMsg, preferredStyle: UIAlertController.Style.alert)
        
        let actionOK : UIAlertAction = UIAlertAction(title: "OK", style: .default) { (alt) in
            successClosure("OK")
        }
        let actionCancel : UIAlertAction = UIAlertAction(title: "Cancel", style: .default) { (alt) in
            cancelClosure("Cancel")
        }
        alert.addAction(actionOK)
        alert.addAction(actionCancel)
        
        view.present(alert, animated: true, completion: nil)
    }
    
    
    class func showActionSheet(_ alertTitle : String, _ alertMsg : String, _ view: UIViewController, camera: @escaping (String?) -> (), ImageGallery: @escaping (String?) -> (), cancel: @escaping (String?) -> () ) {
        
        let alert = UIAlertController(title: alertTitle, message: alertMsg, preferredStyle: UIAlertController.Style.actionSheet)
        alert.view.tintColor = UIColor.black
        let actionCamera : UIAlertAction = UIAlertAction(title: "Camera", style: .default) { (alt) in
            //            print("This is ok action");
            camera("OK")
        }
        
        let actionImageGallery : UIAlertAction = UIAlertAction(title: "Image Gallery", style: .default) { (alt) in
            //            print("This is ok action");
            ImageGallery("ImageGallery")
        }
        let actionCancel : UIAlertAction = UIAlertAction(title: "Cancel", style: .cancel) { (alt) in
            //            print("This is cancel action");
            cancel("Cancel")
        }
        alert.addAction(actionCamera)
        alert.addAction(actionImageGallery)
        alert.addAction(actionCancel)
        view.present(alert, animated: true, completion: nil)
    }
    
    
    //MARK:- Functions for Image
    
    class func resizeImage(image: UIImage, newWidth: CGFloat) -> UIImage? {
        
        let scale = newWidth / image.size.width
        let newHeight = image.size.height * scale
        UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
        image.draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newHeight))
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
    
    // convert base 64
    class func imageToStrinig(_ image : UIImage) ->String {
        let chosenImage = image
        //   chosenImage = self.resizeImage(image: image, newWidth: 600.0)!  // uncomment if u want resize image
        
        var imageData2 = Data()
        imageData2 = chosenImage.jpegData(compressionQuality: 0.05)!
        
        let img2 = UIImage(data: imageData2)
        
        var pictureData  = NSData()
        pictureData = img2!.pngData()! as NSData
        
        let imgdata2 = pictureData.base64EncodedData(options: NSData.Base64EncodingOptions(rawValue: 0))
        
        return String(data: imgdata2, encoding: .utf8)!
    }
    
    class func stringToImage(_ string : String) -> UIImage {
        
        if let decodedData = Data(base64Encoded: string, options: .ignoreUnknownCharacters) {
            let image = UIImage(data: decodedData)
            return image!
        }
        else{
            return (UIImage.init(named: "pictures"))!
        }
    }
    
    //MARK:- Save Image To Directory
    
    class func saveImageDocumentDirectory(_image : UIImage, _name: String) -> String {
        let fileManager = FileManager.default
        let paths = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent( _name + ".png")
        // let image = UIImage(named: "as")
        print(paths)
        let imageData = _image.jpegData(compressionQuality: 0.5)
        fileManager.createFile(atPath: paths as String, contents: imageData, attributes: nil)
        
        return paths
    }
    
    class func getDirectoryPath() -> String {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
    
    class func getImage(_path : String) -> UIImage {
        let fileManager = FileManager.default
        let imagePAth = _path
        if fileManager.fileExists(atPath: imagePAth){
            let imgg = UIImage(contentsOfFile: imagePAth)
            return imgg!
        }else{
            print("No Image")
            return UIImage()
        }
    }
    
    
    //MARK:- Functions For Date
    
    class func timeStampToDate(_timestamp : String, _dateFormat : String) -> String{
        
        var date = Date(timeIntervalSince1970: TimeInterval(_timestamp)!)
        date += TimeInterval(LOCAL_TIME_ZONE as NSNumber)
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT") //Set timezone that you want
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = _dateFormat //Specify your format that you want
        let strDate = dateFormatter.string(from: date)
        return strDate
    }
    
    //MARK:- Functions For Validation
    
    class func isValidEmail(testStr:String) -> Bool {
        // print("validate calendar: \(testStr)")
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
        
    }
    
    class func isVaildPass(testStr: String) -> Bool {
        
        let passRegEx = "^.*(?=.{8,})(?=.*[a-zA-Z])[a-zA-Z0-9]+$"
        let passTest = NSPredicate(format:"SELF MATCHES %@", passRegEx)
        return passTest.evaluate(with: testStr)
    }
    
    
    class func validateUrl (_ urlString: String) -> Bool {
        let urlRegEx = "((?:http|https)://)?(?:www\\.)?[\\w\\d\\-_]+\\.\\w{2,3}(\\.\\w{2})?(/(?<=/)(?:[\\w\\d\\-./_]+)?)?"
        return NSPredicate(format: "SELF MATCHES %@", urlRegEx).evaluate(with: urlString)
    }
    
    // convert base 64
    class func imageToString(_ image : UIImage) ->String {
        var chosenImage = image
        chosenImage = self.resizeImage(image: image, newWidth: 600.0)!
        var imageData2 = Data()
        imageData2 = chosenImage.jpegData(compressionQuality: 0.05)!
        
        let img2 = UIImage(data: imageData2)
        
        var pictureData  = NSData()
        pictureData = img2!.pngData()! as NSData
        
        let imgdata2 = pictureData.base64EncodedData(options: NSData.Base64EncodingOptions(rawValue: 0))
        
        return String(data: imgdata2, encoding: .utf8)!
    }
    
    class func strintoImage(_ string : String) -> UIImage {
        
        if let decodedData = Data(base64Encoded: string, options: .ignoreUnknownCharacters) {
            let image = UIImage(data: decodedData)
            return image!
        }
        else{
            return (UIImage.init(named: "pictures"))!
        }
    }
    
    //// uncomment when install AFNetworking pod
    
   
    
    class func multipartData(_ strURL: String, parameter Params: NSDictionary, DataUrl : URL, messageType : String, withInput_name: String, fileName: String, successWithStatus1Closure: @escaping (AnyObject?) -> (), successWithStatus0Closure: @escaping (AnyObject?) -> (), failurClosure: @escaping (String?)-> ())
    {
        
        let Param: [String: Any] = Params.mutableCopy() as! [String : Any]
        print(messageType)
        print("Params:-", Params);
        
        let complite_url = BASE_URL+strURL
        print(complite_url)
        
        if Reachability.isConnectedToNetwork(){
            
            //            var jwt_token = ""
            //            if GlobalClass.isKeyPresentInUserDefaults(key: "jwt_token") {
            //                jwt_token = GlobalClass.getUserDefault("jwt_token")
            //            }
            //
            //            let header = ["Content-Type" : "multipart/form-data",
            //
            //                          "api_access_key"  : API_ACCESS_KEY,
            //                          "jwt_token" : jwt_token
            //            ]
            
            
            Alamofire.upload(multipartFormData: { (multipartFormData) in
                
                //                for (key, value) in Param {
                //                    multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key)
                //                }
                print("videoUrl = \(DataUrl)")
                
                let fileManager = FileManager.default
                let imagePAth = DataUrl
                if fileManager.fileExists(atPath: imagePAth.absoluteString){
                    //let imgg = UIImage(contentsOfFile: imagePAth)
                    print("dfd")
                    
                }else{
                    print("No Image")
                    
                }
                
                if DataUrl.absoluteString != "" {
                    
                    //                    multipartFormData.append(DataUrl, withName: withInput_name, fileName: "\(fileName).png", mimeType: "image/png")
                    
                    if messageType == "image" {
                        multipartFormData.append(DataUrl, withName: withInput_name, fileName: "\(fileName).png", mimeType: "image/png")
                    } else if messageType == "voice" {
                        multipartFormData.append(DataUrl, withName: withInput_name, fileName: "\(fileName).mp3", mimeType: "audio/mpeg")
                    }
                    
                }
                
                for (key, value) in Param {
                    multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
                }
                
            }, usingThreshold: UInt64.init(), to: complite_url, method: .post, headers: nil) { (result) in
                switch result{
                case .success(let upload,_,_):
                 upload.responseJSON { response in
                        let dictResponse = response.result.value as? NSDictionary
                        
                        print("Response",response)
                        
                        
                        
                        if dictResponse is Dictionary<AnyHashable,Any> {
                            print("Yes, it's a Dictionary")
                        }
                        else{
                            print("No, it's a not a Dictionary")
                            failurClosure("Active internet connection required")
                            return
                        }
                        let isSuccess = dictResponse!["responsecode"] as? String
                        
                        if isSuccess == "200"
                        {
                            successWithStatus1Closure(dictResponse)
                        }else{
                            successWithStatus0Closure(dictResponse)
                        }
                        
                    }
                case .failure(let error):
                    print("error.localizedDescription = \(error.localizedDescription)")
                    if (error.localizedDescription == "The request timed out."){
                        failurClosure("The request timed out.");
                        return
                    }
                    else if (error.localizedDescription == "Could not connect to the server."){
                        failurClosure("Could not connect to the server.");
                        return
                    }
                    else if (error.localizedDescription == "The network connection was lost."){
                        failurClosure("The network connection was lost.");
                        return
                    }
                    else if (error.localizedDescription == "The URL provided is not a file URL.") {
                        failurClosure("The URL provided is not a file URL.")
                    }
                    else {
                        failurClosure("Active internet connection required")
                    }
                }
            }
            
        }else {
            
            //self.hideHud()
            print("Active internet connection required");
            failurClosure("Active internet connection required")
            return
        }
        
    }
    
    class func API_PostData(_ strURL: String, parameter Params: NSDictionary, successWithStatus1Closure: @escaping (AnyObject?) -> (), successWithStatus0Closure: @escaping (AnyObject?) -> (), failurClosure: @escaping (String?)-> ())
    {
        
        let Param: [String: Any] = Params.mutableCopy() as! [String : Any]
        
        print("URL:-", strURL)
        print("para:-", Param);
        print("Params:-", Params);
        
        let complite_url = BASE_URL+strURL
        print(complite_url)
        //  tokenId
        
        if Reachability.isConnectedToNetwork(){
            
          
            
            let header = ["Content-Type" : "application/x-www-form-urlencoded",
                          "Accept" : "application/json",
                          
            ]
            Alamofire.request(complite_url, method: .post, parameters: Param ,encoding: JSONEncoding.default, headers: header).responseJSON {
                response in
                
                print("response == ",response)
                if(response.result.error != nil)
                {
                    let error = response.result.error
                    if (error?.localizedDescription == "The request timed out."){
                        failurClosure("The request timed out.");
                        return
                    }
                    if (error?.localizedDescription == "Could not connect to the server."){
                        failurClosure("Could not connect to the server.");
                        return
                    }
                    if (error?.localizedDescription == "The network connection was lost."){
                        failurClosure("The network connection was lost.");
                        return
                    }
                    
                    failurClosure("noInternet")
                }
                let dictResponse = response.result.value as? NSDictionary
                
                print("dictResponse",dictResponse as Any)
                
                if dictResponse is Dictionary<AnyHashable,Any> {
                    print("Yes, it's a Dictionary")
                }
                else{
                    print("No, it's a not a Dictionary")
                    failurClosure("Server Error")
                    return
                }
                let isSuccess = dictResponse!["responsecode"] as? String
                
                if isSuccess == "200"
                {
                    successWithStatus1Closure(dictResponse)
                }else{
                    successWithStatus0Closure(dictResponse)
                }
            }
        }else {
            
            print("Active internet connection required");
            failurClosure("Active internet connection required")
            return
        }
        
    }
    
    
    class func API_PostDataCustomer(_ strURL: String, parameter Params: NSDictionary, successWithStatus1Closure: @escaping (AnyObject?) -> (), successWithStatus0Closure: @escaping (AnyObject?) -> (), failurClosure: @escaping (String?)-> ())
    {
        
        let Param: [String: Any] = Params.mutableCopy() as! [String : Any]
        
        print("URL:-", strURL)
        print("para:-", Param);
        print("Params:-", Params);
        
        let complite_url = BASE_URL2+strURL
        print(complite_url)
        //  tokenId
        
        if Reachability.isConnectedToNetwork(){
            
            var token = ""
            if Global_Class.isKeyPresentInUserDefaults(key: "tokenId") {
                token = Global_Class.getUserDefault("tokenId")
            }
            let header = ["Content-Type" : "application/json",
                          "Accept" : "application/json",
                          "token"  : token
            ]
            Alamofire.request(complite_url, method: .post, parameters: Param ,encoding: JSONEncoding.default, headers: header).responseJSON {
                response in
                
                print("response == ",response)
                if(response.result.error != nil)
                {
                    let error = response.result.error
                    if (error?.localizedDescription == "The request timed out."){
                        failurClosure("The request timed out.");
                        return
                    }
                    if (error?.localizedDescription == "Could not connect to the server."){
                        failurClosure("Could not connect to the server.");
                        return
                    }
                    if (error?.localizedDescription == "The network connection was lost."){
                        failurClosure("The network connection was lost.");
                        return
                    }
                    failurClosure("noInternet")
                }
                let dictResponse = response.result.value as? NSDictionary
                
                print("dictResponse",dictResponse as Any)
                
                if dictResponse is Dictionary<AnyHashable,Any> {
                    print("Yes, it's a Dictionary")
                }
                else{
                    print("No, it's a not a Dictionary")
                    failurClosure("Server Error")
                    return
                }
                let isSuccess = dictResponse!["responsecode"] as? String
                
                if isSuccess == "200"
                {
                    successWithStatus1Closure(dictResponse)
                }else{
                    successWithStatus0Closure(dictResponse)
                }
            }
        }else {
            
            print("Active internet connection required");
            failurClosure("Active internet connection required")
            return
        }
        
    }
    
    class func API_PutData(_ strURL: String, parameter Params: NSDictionary, successWithStatus1Closure: @escaping (AnyObject?) -> (), successWithStatus0Closure: @escaping (AnyObject?) -> (), failurClosure: @escaping (String?)-> ())
    {
        
        let Param: [String: Any] = Params.mutableCopy() as! [String : Any]
        
        print("URL:-", strURL)
        print("para:-", Param);
        print("Params:-", Params);
        
        let complite_url = BASE_URL+strURL
        print(complite_url)
        
        if Reachability.isConnectedToNetwork(){
            var token = ""
            if Global_Class.isKeyPresentInUserDefaults(key: "tokenId") {
                token = Global_Class.getUserDefault("tokenId")
            }
            let header = ["Content-Type" : "application/json",
                          "Accept" : "application/json",
                          "token"  : token
            ]
            Alamofire.request(complite_url, method: .put, parameters: Param ,encoding: JSONEncoding.default, headers: header).responseJSON {
                response in
                if(response.result.error != nil)
                {
                    let error = response.result.error
                    if (error?.localizedDescription == "The request timed out."){
                        failurClosure("The request timed out.");
                        return
                    }
                    if (error?.localizedDescription == "Could not connect to the server."){
                        failurClosure("Could not connect to the server.");
                        return
                    }
                    if (error?.localizedDescription == "The network connection was lost."){
                        failurClosure("The network connection was lost.");
                        return
                    }
                }
                let dictResponse = response.result.value as? NSDictionary
                
                print("Response",response)
                
                print("Response",response)
                
                if dictResponse is Dictionary<AnyHashable,Any> {
                    print("Yes, it's a Dictionary")
                }
                else{
                    print("No, it's a not a Dictionary")
                    failurClosure("Active internet connection required")
                    return
                }
                
                let isSuccess = dictResponse!["responsecode"] as? String
                
                if isSuccess == "200"
                {
                    successWithStatus1Closure(dictResponse)
                }else{
                    successWithStatus0Closure(dictResponse)
                }
                
            }
        }else {
            print("Active internet connection required");
            failurClosure("Active internet connection required")
            return
        }
        
    }
    
    
    class func API_GetParam(_ strURL: String, parameter Params: NSDictionary, successWithStatus1Closure: @escaping (AnyObject?) -> (), successWithStatus0Closure: @escaping (AnyObject?) -> (), failurClosure: @escaping (String?)-> ())
    {
        
        let Param: [String: Any] = Params.mutableCopy() as! [String : Any]
        
        print("URL:-", strURL)
        print("para:-", Param);
        print("Params:-", Params);
        
        let complite_url = BASE_URL+strURL
        print(complite_url)
        
        if Reachability.isConnectedToNetwork(){
            
            var token = ""
            if Global_Class.isKeyPresentInUserDefaults(key: "tokenId") {
                token = Global_Class.getUserDefault("tokenId")
            }
            let header = ["Content-Type" : "application/json",
                          "Accept" : "application/json",
                          "token"  : token
            ]
            
            Alamofire.request(complite_url, method: .get, parameters: Param ,encoding: JSONEncoding.default, headers: header).responseJSON {
                response in
                if(response.result.error != nil)
                {
                    let error = response.result.error
                    if (error?.localizedDescription == "The request timed out."){
                        failurClosure("The request timed out.");
                        return
                    }
                    if (error?.localizedDescription == "Could not connect to the server."){
                        failurClosure("Could not connect to the server.");
                        return
                    }
                    if (error?.localizedDescription == "The network connection was lost."){
                        failurClosure("The network connection was lost.");
                        return
                    }
                }
                let dictResponse = response.result.value as? NSDictionary
                
                print("Response",response)
                
                print("Response",response)
                
                if dictResponse is Dictionary<AnyHashable,Any> {
                    print("Yes, it's a Dictionary")
                }
                else{
                    print("No, it's a not a Dictionary")
                    failurClosure("Active internet connection required")
                    return
                }
                
                let isSuccess = dictResponse!["responsecode"] as? String
                
                if isSuccess == "200"
                {
                    successWithStatus1Closure(dictResponse)
                }else{
                    successWithStatus0Closure(dictResponse)
                }
                
            }
        }else {
            print("Active internet connection required");
            failurClosure("Active internet connection required")
            return
        }
        
    }
    
    
    class func API_GetData(_ strURL: String, successWithStatus1Closure: @escaping (AnyObject?) -> (), successWithStatus0Closure: @escaping (AnyObject?) -> (), failurClosure: @escaping (String?)-> ())
    {
        
        print("URL:-", strURL)
        
        let complite_url = BASE_URL+strURL
        print(complite_url)
        
        if Reachability.isConnectedToNetwork(){
            
            var token = ""
            if Global_Class.isKeyPresentInUserDefaults(key: "tokenId") {
                token = Global_Class.getUserDefault("tokenId")
            }
            let header = ["Content-Type" : "application/json",
                          "Accept" : "application/json",
                          "token"  : token
            ]
            
            Alamofire.request(complite_url, method: .get, parameters: nil ,encoding: JSONEncoding.default, headers: header).responseJSON {
                response in
                if(response.result.error != nil)
                {
                    let error = response.result.error
                    if (error?.localizedDescription == "The request timed out."){
                        failurClosure("The request timed out.");
                        return
                    }
                    if (error?.localizedDescription == "Could not connect to the server."){
                        failurClosure("Could not connect to the server.");
                        return
                    }
                    if (error?.localizedDescription == "The network connection was lost."){
                        failurClosure("The network connection was lost.");
                        return
                    }
                }
                let dictResponse = response.result.value as? NSDictionary
                
                print("Response",response)
                
                if dictResponse is Dictionary<AnyHashable,Any> {
                    print("Yes, it's a Dictionary")
                }
                else{
                    print("No, it's a not a Dictionary")
                    failurClosure("Active internet connection required")
                    return
                }
                let isSuccess = dictResponse!["responsecode"] as? String
                
                if isSuccess == "200"
                {
                    successWithStatus1Closure(dictResponse)
                }else{
                    successWithStatus0Closure(dictResponse)
                }
                
            }
        }else {
            print("Active internet connection required");
            failurClosure("Active internet connection required")
            return
        }
    }
    
    //MARK:- Function For Json
    
    
    
    class func ArrayToJson(dictionary : NSArray) -> String {
        
        let jsonData = try? JSONSerialization.data(withJSONObject: dictionary, options: [])
        let jsonString = String(data: jsonData!, encoding: .utf8)
        print(jsonString!)
        return jsonString!
        
    }
    
    class func dictToJson(dictionary : NSDictionary) -> String {
        
        let jsonData = try? JSONSerialization.data(withJSONObject: dictionary, options: [])
        let jsonString = String(data: jsonData!, encoding: .utf8)
        print(jsonString!)
        return jsonString!
        
    }
    
    class func jsonToDic(jsonString : String) -> NSDictionary {
        
        let jsonData2 = jsonString.data(using: .utf8)
        let dictionary2 = try? JSONSerialization.jsonObject(with: jsonData2!, options: .mutableLeaves)
        print(dictionary2!)
        
        return dictionary2! as! NSDictionary
        
    }
    
    
    class func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    // Return IP address of WiFi interface (en0) as a String, or `nil`
    class func getWiFiAddress() -> String? {
        var address : String?
        
        // Get list of all interfaces on the local machine:
        var ifaddr : UnsafeMutablePointer<ifaddrs>?
        guard getifaddrs(&ifaddr) == 0 else { return nil }
        guard let firstAddr = ifaddr else { return nil }
        
        // For each interface ...
        for ifptr in sequence(first: firstAddr, next: { $0.pointee.ifa_next }) {
            let interface = ifptr.pointee
            
            // Check for IPv4 or IPv6 interface:
            let addrFamily = interface.ifa_addr.pointee.sa_family
            if addrFamily == UInt8(AF_INET) || addrFamily == UInt8(AF_INET6) {
                
                // Check interface name:
                let name = String(cString: interface.ifa_name)
                if  name == "en0" {
                    
                    // Convert interface address to a human readable string:
                    var hostname = [CChar](repeating: 0, count: Int(NI_MAXHOST))
                    getnameinfo(interface.ifa_addr, socklen_t(interface.ifa_addr.pointee.sa_len),
                                &hostname, socklen_t(hostname.count),
                                nil, socklen_t(0), NI_NUMERICHOST)
                    address = String(cString: hostname)
                }
            }
        }
        freeifaddrs(ifaddr)
        
        return address
    }
    
    
    class func getIPAddress() -> String? {
        var address: String?
        var ifaddr: UnsafeMutablePointer<ifaddrs>? = nil
        if getifaddrs(&ifaddr) == 0 {
            var ptr = ifaddr
            while ptr != nil {
                defer { ptr = ptr?.pointee.ifa_next }
                
                let interface = ptr?.pointee
                let addrFamily = interface?.ifa_addr.pointee.sa_family
                if addrFamily == UInt8(AF_INET) || addrFamily == UInt8(AF_INET6) {
                    
                    if let name: String = String(cString: (interface?.ifa_name)!), name == "en0" {
                        var hostname = [CChar](repeating: 0, count: Int(NI_MAXHOST))
                        getnameinfo(interface?.ifa_addr, socklen_t((interface?.ifa_addr.pointee.sa_len)!), &hostname, socklen_t(hostname.count), nil, socklen_t(0), NI_NUMERICHOST)
                        address = String(cString: hostname)
                    }
                }
            }
            freeifaddrs(ifaddr)
        }
        return address
    }
    
    
    class func sortDataWithDate(arrayData : NSArray) -> NSArray {
        //  var chat: [ChatMessage]!
        
        let returnArray = NSMutableArray()
        var subArray = NSMutableArray()
        let arrayDate = NSMutableArray()
        
        for i in 0 ..< arrayData.count {
            
            let msgDate = ((arrayData[i] as! NSDictionary).object(forKey: "created_date") as! String) //GlobalClass.timeStampToDate(_timestamp: ((arrayData[i] as! NSDictionary).object(forKey: "date") as! String), _dateFormat: "dd/MM/yyyy")
            
            // print("dddt \(msgDate)")
            
            //    print("date array \(arrayDate)  $$  msgDate \(msgDate)")
            if arrayDate.contains(msgDate) {
                
                subArray.add(arrayData[i])
                
            }
            else{
                arrayDate.add(msgDate)
                if arrayDate.count > 1 {
                    returnArray.add(subArray)
                }
                
                subArray = NSMutableArray()
                subArray.add(arrayData[i])
            }
        }
        
        if subArray != nil {
            returnArray.add(subArray)
        }
        
        print(returnArray)
        return returnArray
    }
}


public class Reachability {
    
    class func isConnectedToNetwork() -> Bool {
        
//        var zeroAddress = sockaddr_in(sin_len: 0, sin_family: 0, sin_port: 0, sin_addr: in_addr(s_addr: 0), sin_zero: (0, 0, 0, 0, 0, 0, 0, 0))
//        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
//        zeroAddress.sin_family = sa_family_t(AF_INET)
//
//        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
//            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
//                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
//            }
//        }
//
//        var flags: SCNetworkReachabilityFlags = SCNetworkReachabilityFlags(rawValue: 0)
//        if SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) == false {
//            return false
//        }
//
//        /* Only Working for WIFI
//         let isReachable = flags == .reachable
//         let needsConnection = flags == .connectionRequired
//
//         return isReachable && !needsConnection
//         */
//
//        // Working for Cellular and WIFI
//        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
//        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
//        let ret = (isReachable && !needsConnection)
//
//        return ret
        
         return NetworkReachabilityManager()!.isReachable
        
    }
}

func createBody(boundary: String,
                dataaa: Data,
                mimeType: String,
                filename: String) -> Data {
    let body = NSMutableData()
    
    let boundaryPrefix = "--\(boundary)\r\n"
    
    body.appendString(boundaryPrefix)
    body.appendString("Content-Disposition: form-data; name=\"files\"; filename=\"\(filename)\"\r\n")
    body.appendString("Content-Type: \(mimeType)\r\n\r\n")
    body.append(dataaa)
    body.appendString("\r\n")
    body.appendString("--".appending(boundary.appending("--")))
    
    return body as Data
}

func createAudioBody(parameters: [String: String],
                     boundary: String,
                     dataaa: Data,
                     mimeType: String,
                     filename: String) -> Data {
    let body = NSMutableData()
    
    let boundaryPrefix = "--\(boundary)\r\n"
    
    for (key, value) in parameters {
        body.appendString(boundaryPrefix)
        body.appendString("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
        body.appendString("\(value)\r\n")
        
    }
    
    body.appendString(boundaryPrefix)
    body.appendString("Content-Disposition: form-data; name=\"files\"; filename=\"\(filename)\"\r\n")
    body.appendString("Content-Type: \(mimeType)\r\n\r\n")
    body.append(dataaa)
    body.appendString("\r\n")
    body.appendString("--".appending(boundary.appending("--")))
    
    return body as Data
}


extension NSMutableData {
    func appendString(_ string: String) {
        let data = string.data(using: String.Encoding.utf8, allowLossyConversion: false)
        append(data!)
    }
}


// extension for find Height and Width of string
extension String {
    
    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        
        return boundingBox.height
        
    }
    
    func width(withConstraintedHeight height: CGFloat, font: UIFont) -> CGFloat {
        
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        
        return boundingBox.width
        
    }
}

extension Date {
    var ticks: UInt64 {
        return UInt64((self.timeIntervalSince1970 + 62_135_596_800) * 10_000_000)
    }
}

extension Date {
    init?(jsonDate: String) {
        let prefix = "/Date("
        let suffix = ")/"
        let scanner = Scanner(string: jsonDate)
        
        // Check prefix:
        guard scanner.scanString(prefix, into: nil)  else { return nil }
        
        // Read milliseconds part:
        var milliseconds : Int64 = 0
        guard scanner.scanInt64(&milliseconds) else { return nil }
        // Milliseconds to seconds:
        var timeStamp = TimeInterval(milliseconds)/1000.0
        
        // Read optional timezone part:
        var timeZoneOffset : Int = 0
        if scanner.scanInt(&timeZoneOffset) {
            let hours = timeZoneOffset / 100
            let minutes = timeZoneOffset % 100
            // Adjust timestamp according to timezone:
            timeStamp += TimeInterval(3600 * hours + 60 * minutes)
        }
        
        // Check suffix:
        guard scanner.scanString(suffix, into: nil) else { return nil }
        
        // Success! Create NSDate and return.
        self.init(timeIntervalSince1970: timeStamp)
    }
}

extension String {
    func removingWhitespaces() -> String {
        return components(separatedBy: .whitespaces).joined()
    }
}



extension UIImage {
    func fixOrientation() -> UIImage {
        if self.imageOrientation == UIImage.Orientation.up {
            return self
        }
        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
        self.draw(in: CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height))
        if let normalizedImage: UIImage = UIGraphicsGetImageFromCurrentImageContext() {
            UIGraphicsEndImageContext()
            return normalizedImage
        } else {
            return self
        }
    }
}

extension UIApplication {
    var statusBarView: UIView? {
        if responds(to: Selector(("statusBar"))) {
            return value(forKey: "statusBar") as? UIView
        }
        return nil
    }
}

public extension UITableView {
    func indexPathForView(_ view: UIView) -> IndexPath? {
        let center = view.center
        let viewCenter = self.convert(center, from: view.superview)
        let indexPath = self.indexPathForRow(at: viewCenter)
        return indexPath
    }
}


extension UIImage {
    func createSelectionIndicator(color: UIColor, size: CGSize, lineWidth: CGFloat) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        color.setFill()
        UIRectFill(CGRect(x: 0, y: size.height - lineWidth, width: size.width, height: lineWidth))
        // UIRectFill(CGRect(0, size.height - lineWidth, size.width, lineWidth))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
}

extension UIScreen {
    
    static var isPhoneX: Bool {
        if UIDevice().userInterfaceIdiom == .phone {
            switch UIScreen.main.nativeBounds.height {
            case 2436:
                return true
            case 2688:
                return true
            case 1792:
                return true
            default:
                return false
            }
        }
        else {
            return false
        }
    }
}

extension UITableView {
    
    //Variable-height UITableView tableHeaderView with autolayout
    func layoutTableHeaderView() {
        
        guard let headerView = self.tableHeaderView else {
            return
            
        }
        headerView.translatesAutoresizingMaskIntoConstraints = false
        
        let headerWidth = headerView.bounds.size.width;
        let temporaryWidthConstraints = NSLayoutConstraint.constraints(withVisualFormat: "[headerView(width)]", options: NSLayoutConstraint.FormatOptions(rawValue: UInt(0)), metrics: ["width": headerWidth], views: ["headerView": headerView])
        
        headerView.addConstraints(temporaryWidthConstraints)
        
        headerView.setNeedsLayout()
        headerView.layoutIfNeeded()
        
        let headerSize = headerView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
        let height = headerSize.height
        var frame = headerView.frame
        
        print("height=\(height)")
        
        frame.size.height = height
        headerView.frame = frame
        
        self.tableHeaderView = headerView
        
        headerView.removeConstraints(temporaryWidthConstraints)
        headerView.translatesAutoresizingMaskIntoConstraints = true
        self.reloadData()
        
    }
    
    //Variable-height UITableView Footer with autolayout
    func layoutTableFooterView() {
        
        guard let footerView = self.tableFooterView else {
            return
            
        }
        footerView.translatesAutoresizingMaskIntoConstraints = false
        
        let footerWidth = footerView.bounds.size.width;
        let temporaryWidthConstraints = NSLayoutConstraint.constraints(withVisualFormat: "[footerView(width)]", options: NSLayoutConstraint.FormatOptions(rawValue: UInt(0)), metrics: ["width": footerWidth], views: ["footerView": footerView])
        
        footerView.addConstraints(temporaryWidthConstraints)
        
        footerView.setNeedsLayout()
        footerView.layoutIfNeeded()
        
        let footerSize = footerView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
        let height = footerSize.height
        var frame = footerView.frame
        
        print("height=\(height)")
        
        frame.size.height = height
        footerView.frame = frame
        
        self.tableFooterView = footerView
        
        footerView.removeConstraints(temporaryWidthConstraints)
        footerView.translatesAutoresizingMaskIntoConstraints = true
        self.reloadData()
        
    }
}


class Order : NSObject {
    
//    class func getColor(status: String) -> UIColor{
////        switch status {
////        case "Paymentpending":
////            return UIColor(white: "cf0606", alpha: 1) //UIColor(hex: "f1c232", alpha: 1)
////        case "Paymentreceived":
////            return UIColor(white: "cf6006", alpha: 1)
////        case "Shipped":
////            return UIColor(white: "06cf0f", alpha: 1)
////        case "Delivered":
////            return UIColor(white: "06cf0f", alpha: 1)
////        case "Closed":
////            return UIColor(hex: "cf0606", alpha: 1)
////        case "Cancelled", "Canceled" :
////            return UIColor(hex: "cf0606", alpha: 1)
////        case "Processing", "processing":
////            return UIColor(hex: "cf6006", alpha: 1)
////        default:
//     return UIColor.black
////        }
//    }
//    
    
    class func getString(status: String) -> String{
        switch status {
        case "Paymentpending":
            return "Payment Pending"
        case "Paymentreceived":
            return "Payment Received"
        case "Shipped":
            return "Shipped"
        case "Delivered":
            return "Delivered"
        case "Closed":
            return "Closed"
        case "Cancelled", "Canceled":
            return "Cancelled"
        case "Processing", "processing":
            return "Processing"
        default:
            return status
        }
    }

        
        
}

extension UITextField{
    @IBInspectable var doneAccessory: Bool{
        get{
            return self.doneAccessory
        }
        set (hasDone) {
            if hasDone{
                addDoneButtonOnKeyboard()
            }
        }
    }
    
    func addDoneButtonOnKeyboard()
    {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        doneToolbar.barStyle = .default
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.doneButtonAction))
        done.tintColor = UIColor.black
        let items = [flexSpace, done]
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        
        self.inputAccessoryView = doneToolbar
    }
    
    @objc func doneButtonAction()
    {
        self.resignFirstResponder()
    }
}


//class AmountField: UITextField {
//
//
//private var isFirstDecimal : Bool = true
//override func willMove(toSuperview newSuperview: UIView?) {
//
//    addTarget(self, action: #selector(editingChanged), for: .editingChanged)
//    keyboardType = .decimalPad
//    textAlignment = .left
//    placeholder = "0.0"
//    editingChanged()
//}
//override func deleteBackward() {
//    var currentText = self.text ?? ""
//    currentText = String(currentText.dropLast())
//    self.text = currentText
//    editingChanged(self)
//}
//@objc func editingChanged(_ textField: UITextField? = nil) {
//    var doubleStr = textField?.text ?? "00"
//
//
//    let decimalCount = doubleStr.components(separatedBy: ".")
//    if decimalCount.count > 2 {
//        var currentText = self.text ?? ""
//        currentText = String(currentText.dropLast())
//        self.text = currentText
//        return
//    }
//
//    if doubleStr.contains(".") && isFirstDecimal == true {
//        self.text = doubleStr
//        isFirstDecimal = false
//        return
//    }
//    else if !(doubleStr.contains(".")) {
//        isFirstDecimal = true
//    }
//
//    let doubleStrTemp = doubleStr.replacingOccurrences(of: ",", with: "")
//
//    if doubleStrTemp != "" {
//        if let n = Decimal(string: doubleStrTemp )?.significantFractionalDecimalDigits {
//            if n > 2 {
//                var currentText = self.text ?? ""
//                currentText = String(currentText.dropLast())
//                self.text = currentText
//                return
//            }
//        }
//    }
//    doubleStr = doubleStr.replacingOccurrences(of: ",", with: "")
//
//    let doube = Double(doubleStr)
//    let numberFormatter = NumberFormatter()
//    numberFormatter.numberStyle = NumberFormatter.Style.decimal
//    if doube != nil {
//        let formattedNumber = numberFormatter.string(from: NSNumber(value:doube!))
//        self.text = formattedNumber
//    }
//}}
//
//extension Decimal {
//    var significantFractionalDecimalDigits: Int {
//        return max(-exponent, 0)
//    }}

