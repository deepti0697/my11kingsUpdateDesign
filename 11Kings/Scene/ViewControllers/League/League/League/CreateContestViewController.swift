//
//  CreateContestViewController.swift
//  Club11
//
//  Created by Developer on 28/05/19.
//

import UIKit

class CreateContestViewController: BaseViewController {
    
    @IBOutlet weak var aSwitch: UISwitch!
    @IBOutlet weak var aContestNameTextField: UITextField!
    @IBOutlet weak var aTotalWinningTextField: UITextField!
    @IBOutlet weak var aContestSizeTextField: UITextField!
    @IBOutlet weak var aEntryFeeContainerView: UIView!
    @IBOutlet weak var aEntryFeeLabel: UILabel!
    @IBOutlet weak var aVSLabel: UILabel!
    @IBOutlet weak var aTimerContainerView: UIView!
    @IBOutlet weak var aTimeLabel: UILabel!
    
    var contestData: Any?
    var matchKey = ""
    var releaseDate: NSDate?
    var countdownTimer = Timer()
    var isMultiPleJoin = false
    var totalAmount = 0.0 {
        didSet {
            calculatePrice()
        }
    }
    var entryFee = 0.0
    var numberOfPlayrs = 0.0 {
        didSet {
            calculatePrice()
        }
    }
    var contestName = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        setCornerRadius()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addNavigationBar(navigationTitle: "Make Own Contest", titleContentMode: .center, isNavImageShow: false, isBackButtonShow: true, isWalletButtonShow: true)
        setContestData()
    }
    
    fileprivate func setCornerRadius() {
        aTimerContainerView.setCornerRadius(value: 5)
        aEntryFeeContainerView.setCornerRadius(value: 5)
    }
    
    fileprivate func setContestData() {
        if let contest = contestData as? LiveMatchResponse {
            matchKey = contest.matchkey ?? ""
            aVSLabel.text = "\(contest.team1name ?? "") vs \(contest.team2name ?? "")"
            setReleaseTime(releaseDateString: contest.time_start ?? "0")
        }
        if let contest = contestData as? MyContestReponse {
            matchKey = contest.matchkey ?? ""
            aVSLabel.text = "\(contest.team1display ?? "") vs \(contest.team2display ?? "")"
            setReleaseTime(releaseDateString: contest.start_date ?? "0")
        }
    }
    
    fileprivate func setReleaseTime(releaseDateString: String) {
        let releaseDateFormatter = DateFormatter()
        releaseDateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        releaseDate = releaseDateFormatter.date(from: releaseDateString)! as NSDate
        countdownTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
    }
    
    @objc func updateTime() {
        let currentDate = Date()
        let calendar = Calendar.current
        let diffDateComponents = calendar.dateComponents([.day, .hour, .minute, .second], from: currentDate, to: releaseDate! as Date)
        var day = diffDateComponents.day ?? 00
        var hour = diffDateComponents.hour ?? 00
        var minute = diffDateComponents.minute ?? 00
        var second = diffDateComponents.second ?? 00
        if day < 0 {
            day = 0
        }
        if hour < 0 {
            hour = 0
        }
        if minute < 0 {
            minute = 0
        }
        if second < 0 {
            second = 0
        }
        let countdown = "\(Utility.getStringFrom(seconds: day))D \(Utility.getStringFrom(seconds: hour))H \(Utility.getStringFrom(seconds: minute))M \(Utility.getStringFrom(seconds: second))S"
        aTimeLabel.text = countdown
        if day == 0 && hour == 0 && minute == 0 && second == 0 {
            countdownTimer.invalidate()
        }
    }
    
    @IBAction func switchAction(_ sender: UISwitch) {
        if sender.isOn {
            isMultiPleJoin = true
        } else {
            isMultiPleJoin = false
        }
    }
    
    @IBAction func chooseWinnerAction(_ sender: UIButton) {
        if aTotalWinningTextField.text == "" {
            Loader.showToast(message: "Enter total winning amount", onView: self.view, bottomMargin: 200)
        } else if aContestSizeTextField.text == "" {
            Loader.showToast(message: "Enter contest size", onView: self.view, bottomMargin: 200)
        } else {
            if let totalAmt = Double(aTotalWinningTextField.text ?? "0"), let teamSize = Double(aContestSizeTextField.text ?? "0") {
                if totalAmt < 20 || totalAmt > 10000 {
                    Loader.showToast(message: "Total winning is from Rs.20 to Rs.10000", onView: self.view, bottomMargin: 200)
                    return
                }
                if teamSize < 2 || teamSize > 50 {
                    Loader.showToast(message: "Total team size is from 2 to 50", onView: self.view, bottomMargin: 200)
                    return
                }
                openViewController(controller: ContestWinnerBreakupVC.self, storyBoard: .homeStoryBoard) { (vc) in
                    vc.entryFee = self.entryFee
                    vc.numberOfPlyers = self.numberOfPlayrs
                    vc.totalAmount = self.totalAmount
                    vc.isMultipleJoin = self.isMultiPleJoin
                    vc.matchKey = self.matchKey
                    vc.contestName = self.contestName
                    vc.contestData = self.contestData
                }
            } else {
                Loader.showToast(message: "Please give correct input", onView: self.view, bottomMargin: 200)
            }
        }
    }
    
    override func handleBackButtonAction() {
        self.navigationController?.popViewController(animated: true)
    }
}

extension CreateContestViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if aContestNameTextField.isFirstResponder {
            aContestNameTextField.resignFirstResponder()
            aTotalWinningTextField.becomeFirstResponder()
        } else if aTotalWinningTextField.isFirstResponder {
            aTotalWinningTextField.resignFirstResponder()
            aContestSizeTextField.becomeFirstResponder()
        } else if aContestSizeTextField.isFirstResponder {
            self.view.endEditing(true)
        }
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == aTotalWinningTextField {
            if string == "" {
                var fullText = "\(textField.text ?? "")"
                fullText = String(fullText.dropLast())
                let doubleTxt = Double(fullText)
                totalAmount = doubleTxt ?? 0.0
            } else {
                let fullText = "\(textField.text ?? "")\(string)"
                let doubleTxt = Double(fullText)
                totalAmount = doubleTxt ?? 0.0
            }
        } else if textField == aContestSizeTextField {
            if string == "" {
                var fullText = "\(textField.text ?? "")"
                fullText = String(fullText.dropLast())
                let doubleTxt = Double(fullText)
                numberOfPlayrs = doubleTxt ?? 0.0
            } else {
                let fullText = "\(textField.text ?? "")\(string)"
                let doubleTxt = Double(fullText)
                numberOfPlayrs = doubleTxt ?? 0.0
            }
        }
        return true
    }
    
    func calculatePrice() {
        print(totalAmount)
        print(numberOfPlayrs)
        contestName = aContestNameTextField.text ?? ""
        if numberOfPlayrs >= 2.0 && numberOfPlayrs <= 50.0 && totalAmount >= 20.0 && totalAmount <= 10000.0 {
            print("amt \(totalAmount)")
            print("amt \(numberOfPlayrs)")
            let contextEntreeFee = (totalAmount * 1.15) / numberOfPlayrs
            entryFee = contextEntreeFee
            aEntryFeeLabel.text = kRupeeIcon + String(format: "%.2f", contextEntreeFee)
        } else {
            entryFee = 0.0
            aEntryFeeLabel.text = kRupeeIcon + "0.0"
        }
    }
}

