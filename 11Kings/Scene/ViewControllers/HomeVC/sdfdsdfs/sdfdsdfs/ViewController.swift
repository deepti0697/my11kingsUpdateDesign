//
//  ViewController.swift
//  sdfdsdfs
//
//  Created by Test on 31/05/20.
//  Copyright © 2020 Test. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

     func getFootbaalResponse() {
            
            self.showActivityIndicator(sMessage: "..Loading")
    //        cricketOutlt.setTitleColor(UIColor.black, for: .normal)
            let headers = [
                "Authorization": "bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOlwvXC9kZXYuZmFudGFzeXBvd2VyMTEuY29tXC9uZXdfYXBpXC9mcDExXC9hcGlcL2F1dGhcL2xvZ2luIiwiaWF0IjoxNTg3NTU5Nzg2LCJleHAiOjE1ODc2NDYxODYsIm5iZiI6MTU4NzU1OTc4NiwianRpIjoibGVCRm1jV1FjQ3B5TGJBaSIsInN1YiI6OTkxMTcsInBydiI6Ijg3ZTBhZjFlZjlmZDE1ODEyZmRlYzk3MTUzYTE0ZTBiMDQ3NTQ2YWEifQ.mRtYmTgwyZDJApSar19QXI1x1EAiPiww-vSr3QBrh-U",
                "Content-Type":"text/plain",
                "Accept" :"application/json"]
            
            
            if let heroObject = UserDefaults.standard.value(forKey: "loginData") as? NSData {
                
                let UserDic = NSKeyedUnarchiver.unarchiveObject(with: heroObject as Data) as! NSDictionary
                let param = ["user_id":UserDic.value(forKey: "user_id")
                             ]
                NetworkManager.post_Request2(urlService: kgetMatchList, param: param as [String : Any], head: headers) { response in
                    do {
                    if response !=  nil {
                        let json = try JSON(data: response as! Data)
                        let result = json["result"]
                        self.getFootbaalData.removeAll()
                        for arr in result.arrayValue{
                            
                            self.getFootbaalData.append(GetMatchDetails(json: arr))
                            
                        }
                    }
                    }catch {
                        Loader.showAlert(message: "InternalError")
                    }
                }
        }
        }
}

