//
//  UpdateTeamNameViewController.swift
//  Club11
//
//  Created by Developer on 09/06/19.
//

import UIKit
import  SwiftyJSON
protocol hitBannerData{
    func check(check:Bool)
}
class UpdateTeamNameViewController: BaseClass {

    @IBOutlet weak var aTeamNameTextField: UITextField!
   
    @IBOutlet weak var aSubmitButton: UIButton!
    var deleegate : hitBannerData?
    @IBOutlet weak var state: UITextField!
    @IBOutlet weak var referCode: UITextField!
    var teamNameClouser: ((String) -> Void) = { _ in }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        setupUI()
    }

    func setupUI() {
//        aTeamNameLabel.isHidden = true
        referCode.setLeftPaddingPoints(10.0)
        state.setLeftPaddingPoints(10.0)
        aTeamNameTextField.setLeftPaddingPoints(10.0)
        self.aSubmitButton.setCornerRadiusButton(value: 5)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
      
    }

    fileprivate func updateTeamName() {
        showActivityIndicator(sMessage: "Loading...")
        let headers = [
            "content-type": "application/json",
            "Authorization":"bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOlwvXC9kZXYucmdsYWJzLm5ldFwvcmVwb3NcL2tlc2hhdlwvbHVja3kxMVwvYXBpXC9hdXRoXC9sb2dpbiIsImlhdCI6MTU2NDIyMTE0NiwiZXhwIjoxNTY0MjI0NzQ2LCJuYmYiOjE1NjQyMjExNDYsImp0aSI6IkFKYm5tdVpkb0VaVko3U2IiLCJzdWIiOjQ3LCJwcnYiOiI4N2UwYWYxZWY5ZmQxNTgxMmZkZWM5NzE1M2ExNGUwYjA0NzU0NmFhIn0.KSMUhnvzM2OmfgvhY_rOrt-cut2yW1IksR0PAZ3rgcY",
            "cache-control": "no-cache"
        ]
        let parameters = ["user_id": UserDefaults.standard.object(forKey: kUserId) ?? -1,"teamname": aTeamNameTextField.text ?? "","state": state.text ?? "", "user_refer_code": referCode.text ?? ""]
        NetworkManager.post_Request2(urlService: kUpdateTeamName, param: parameters, head: headers) { (response) in
            self.hideActivityIndicator()
            do {
                if response != nil {
                    let json = try JSON(data: response as! Data)
                    print(json)
                    let jsonMessage = json["message"].stringValue
                    let jsonStatus = json["status"].intValue
                    if jsonStatus == 1 {
//                         self.teamNameClouser(self.aTeamNameTextField.text ?? "")
                        Loader.showToast(message: jsonMessage, onView: self.view, bottomMargin: 200, color: .red)
                                                            self.dismissVC()
                    }
                    else {
                        Loader.showToast(message: jsonMessage, onView: self.view, bottomMargin: 200, color: .red)
                       
                    }
//                    let responseData = try JSONSerialization.data(withJSONObject: response!, options: [])
//                    let responseModel = try JSONDecoder().decode([UpdateTeamResponse].self, from: responseData)
//                    if responseModel.count > 0 {
//                        if let responseCode = responseModel[0].code {
//                            if responseCode == 0 {
//                                if let status = responseModel[0].status {
//                                    Loader.showToast(message: status, onView: self.view, bottomMargin: 200)
//                                }
//                            } else {
//                                if let status = responseModel[0].status {
//                                    self.teamNameClouser(self.aTeamNameTextField.text ?? "")
//                                    Loader.showToast(message: status, onView: self.view, bottomMargin: 200)
                                    
//                                }
//                            }
//                        }
//                    }
                }
            } catch {
                Loader.showAlert(message: "Status code 500: server internal error")
            }
        }
    }
    @IBAction func aStateTextField(_ sender: Any) {
    }
    
    @IBAction func openState(_ sender: UIButton) {
   self.view.endEditing(true)
          presentPopOverController(sender: sender)

    }
    fileprivate func dismissVC() {
//        self.dismiss(animated: true, completion: nil)
        self.deleegate?.check(check: true)
        self.navigationController?.popViewController(animated: true)
    }

    
    fileprivate func presentPopOverController(sender: UIButton) {
           let storyBoard = UIStoryboard(name: "More", bundle: nil)
           let vc = storyBoard.instantiateViewController(withIdentifier: "PopoverViewController") as! PopoverViewController
           vc.preferredContentSize = CGSize(width: self.view.frame.width - 100, height: self.view.frame.height - 200)
           vc.modalPresentationStyle = .popover
           if let pres = vc.presentationController {
               pres.delegate = self
           }
           self.present(vc, animated: true)
           vc.stateSelectionClousure = { [weak self] state in
            self?.state.text = state
               DispatchQueue.main.async {
                   vc.dismiss(animated: false, completion: nil)
               }
           }
           if let pop = vc.popoverPresentationController {
               pop.sourceView = (sender as UIView)
               pop.sourceRect = (sender as UIView).bounds
           }
       }
    @IBAction func aCloseButtonAction(_ sender: Any) {
//        dismissVC()
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func aSubmitButtonAction(_ sender: Any) {
        if let teamName = aTeamNameTextField.text, teamName != ""  {
          
            if state.text != "" {
                  updateTeamName()
            }
            else {
                 Loader.showToast(message: "Please select your state", onView: self.view, bottomMargin: 200, color: .red)
            }
        } else {
            Loader.showToast(message: "Please enter team name", onView: self.view, bottomMargin: 200, color: .red)
        }
    }

    override func handleBackButtonAction() {
        self.navigationController?.popViewController(animated: true)
    }
}

// MARK: TextField Delegate Method
extension UpdateTeamNameViewController: UITextFieldDelegate {

    func setupUIForTextfield(resultString: String = "") {
        if aTeamNameTextField.text != "" || resultString != "" {
            
        } else {
           
        }
    }

    

    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField {
        case aTeamNameTextField:
            
            setupUIForTextfield()
        default:
            break
        }
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        setupUIForTextfield()
        self.view.endEditing(true)
        return true
    }
}

extension UpdateTeamNameViewController: UIPopoverPresentationControllerDelegate {
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
}
