//
//  AccountViewController.swift
//  Club11
//
//  Created by Developer on 26/05/19.
//

import UIKit

class AccountViewController: BaseClass {

    @IBOutlet weak var aContainerView: UIView!
    @IBOutlet weak var aTotalBalance: UILabel!
    @IBOutlet weak var aWinningAmountLabel: UILabel!
    @IBOutlet weak var aUnutilizedAmountLabel: UILabel!
    @IBOutlet weak var aReferralBonusAmountLabel: UILabel!
    @IBOutlet weak var aclub11PerksAmountLabel: UILabel!
    @IBOutlet weak var aAddCashButotn: UIButton!
    @IBOutlet weak var aRedeemButotn: UIButton!
    @IBOutlet weak var aTransactionButotn: UIButton!
    @IBOutlet weak var aWithdrawButotn: UIButton!

    var isFromMore = false
    var myBalanceDataArray = [MyBalanceModel]() {
        didSet {
            setAccountData()
        }
    }
    private var unutilizedAmount = ""
    private var winningsAmount = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addNavigationBar(navigationTitle: "Account", titleContentMode: .center, isNavImageShow: false, isBackButtonShow: isFromMore, isWalletButtonShow: false, isBinButtonShow: false)
        fetchAccountData()
    }
    func setupUI() {
        aContainerView.setCornerRadius(value: 10)
        aAddCashButotn.setCornerRadiusButton(value: 5)
        aRedeemButotn.setCornerRadiusButton(value: 5)
        aWithdrawButotn.setCornerRadiusButton(value: 5)
        aTransactionButotn.setCornerRadiusButton(value: 5)

    }
    func setAccountData() {
        guard myBalanceDataArray.count > 0  else {
            return
        }
        let data = myBalanceDataArray[0]
        unutilizedAmount = "\(data.balance ?? 0.0)"
        winningsAmount = "\(data.winning ?? 0.0)"
        aUnutilizedAmountLabel.text = "\(kRupeeIcon ) \(data.balance ?? 0.0)"
        aWinningAmountLabel.text = "\(kRupeeIcon ) \(data.winning ?? 0.0)"
        aReferralBonusAmountLabel.text = "\(kRupeeIcon ) \(data.bonus ?? 0)"
//        aclub11PerksAmountLabel.text = "\(data.perks ?? 0.0)"
        aTotalBalance.text = "\(kRupeeIcon) \(data.totalamount ?? 0.0)"
    }

    func fetchAccountData() {
//        showActivityIndicator(sMessage: "Loading...")
//        let headers = [
//            "content-type": "application/x-www-form-urlencoded",
//            "cache-control": "no-cache"
//        ]
//        let parameters = ["user_id": UserDefaults.standard.object(forKey: kUserId) ?? -1]
//        NetworkManager.post_Request(urlService: kMyBalance, param: parameters, head: headers) { (response) in
//            self.hideActivityIndicator()
//            do {
//                if response != nil {
//                    let responseData = try JSONSerialization.data(withJSONObject: response!, options: [])
//                    let responseModel = try JSONDecoder().decode(MyBalanceModel.self, from: responseData)
//                    if responseModel.count > 0 {
//                        self.myBalanceDataArray = responseModel
//                    } else {
//                        Loader.showAlert(message: "Unable to get Account Data")
//                    }
//                }
//            } catch {
//                Loader.showAlert(message: "Status code 500: server internal error")
//            }
//        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "accountToAddCashSegue" {
//            if let vc = segue.destination as? AddMoneyViewController {
//
//            }
//        } else if segue.identifier == "accountToWithdrawCashSegue" {
////            if let vc = segue.destination as? WithdrawViewController {
////                vc.winningsAmount = self.winningsAmount
//            }
        }
    }
    
    @IBAction func transactionHistoryButtonAction(_ sender: UIButton) {
//        performSegue(withIdentifier: "accountToTransactionHistorySegue", sender: nil)
    }
    
    @IBAction func withdrawButtonAction(_ sender: UIButton) {
//        performSegue(withIdentifier: "accountToWithdrawCashSegue", sender: nil)
    }
    
    @IBAction func RedeemButtonAction(_ sender: UIButton) {
//        openViewController(controller: Club11PerkViewController.self, storyBoard: .moreStoryBoard, handler: { _ in
//        })
    }
    
    @IBAction func addCashButtonAction(_ sender: UIButton) {
        performSegue(withIdentifier: "accountToAddCashSegue", sender: nil)
    }
    
    override func handleBackButtonAction() {
        self.navigationController?.popViewController(animated: true)
    }
}
