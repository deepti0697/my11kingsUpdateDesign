//
//  FCAccountsCVCell.swift
//  FantasyCricket
//
//  Created by Developer on 20/05/19.
//  Copyright © 2019 Rickey_iDev. All rights reserved.
//

import UIKit

class FCAccountsCVCell: UICollectionViewCell {
    
    @IBOutlet weak var aTableView: UITableView!
    
    var isMobileVerified = false
    var isPanVerified = false
    var isPanunderReview = false
    var isBankUnderReview = false
    var isBankunderReview = false
    var isBankVerified = false
    var isEmailVerified = false
    var selectedBankImage: UIImage?
    var selectedPanImage: UIImage?
    var isPanImageAdded = false
    var isBankImageAdded = false
    var didSelectClousure: ((Int) -> Void) = { _ in }
    var cellType = AccountCellType.bankCellType {
        didSet {
            aTableView.reloadData()
        }
    }
     var itematIndex = -1 {
           didSet {
               aTableView.reloadDataInMainQueue()
           }
       }
    var uploadImageClouser: ((AccountCellType) -> Void) = { _ in }
    var submitButtonClousure: ((_ accountName: String,_ accountNumber: String,_ ifscCode: String,_ bankName: String) -> Void) = { _,_,_,_ in }
    var submitButtonForPanClousure: ((_ panName: String,_ panNumber: String,_ dob: String) -> Void) = { _,_,_ in }
    var verifyEmailMobileClousure: ((String,String) -> Void) = { _,_ in }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
        registerCell()
    }
    
    fileprivate func setupUI() {
        aTableView.estimatedRowHeight = 100
        aTableView.rowHeight = UITableView.automaticDimension
    }
    
    fileprivate func registerCell() {
        aTableView.register(UINib(nibName: VerifiedTableViewCell.identifier(), bundle: nil), forCellReuseIdentifier: VerifiedTableViewCell.identifier())
        aTableView.register(UINib(nibName: FCVerifyEmailTableViewCell.identifier(), bundle: nil), forCellReuseIdentifier: FCVerifyEmailTableViewCell.identifier())
        aTableView.register(UINib(nibName: FCBankTableViewCell.identifier(), bundle: nil), forCellReuseIdentifier: FCBankTableViewCell.identifier())
        aTableView.register(UINib(nibName: FCPanCardTableViewCell.identifier(), bundle: nil), forCellReuseIdentifier: FCPanCardTableViewCell.identifier())
        aTableView.register(UINib(nibName: FCVerifyStaticMessageTVCell.identifier(), bundle: nil), forCellReuseIdentifier: FCVerifyStaticMessageTVCell.identifier())
        aTableView.register(UINib(nibName: FCVerifyMobileTableViewCell.identifier(), bundle: nil), forCellReuseIdentifier: FCVerifyMobileTableViewCell.identifier())
    }
    
}

extension FCAccountsCVCell: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if cellType == .mobileCellType {
            return 2
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if cellType == .mobileCellType {
            if indexPath.row == 0 {
                if isEmailVerified {
                    let cell = tableView.dequeueReusableCell(withIdentifier: VerifiedTableViewCell.identifier(), for: indexPath) as! VerifiedTableViewCell
                    cell.configureCell(cellType: .mobileCellType, isEmail: true)
                    return cell
                } else {
                    let cell = tableView.dequeueReusableCell(withIdentifier: FCVerifyEmailTableViewCell.identifier(), for: indexPath) as! FCVerifyEmailTableViewCell
                    cell.verifyEmailActionClousure = { [weak self] email,type in
                        if let strongSelf = self {
                            strongSelf.verifyEmailMobileClousure(email,type)
                        }
                    }
                    return cell
                }
            } else {
//                if isEmailVerified {
                    if isMobileVerified {
                        let cell = tableView.dequeueReusableCell(withIdentifier: VerifiedTableViewCell.identifier(), for: indexPath) as! VerifiedTableViewCell
                        cell.configureCell(cellType: .mobileCellType, isEmail: false)
                        return cell
                    } else {
                        let cell = tableView.dequeueReusableCell(withIdentifier: FCVerifyMobileTableViewCell.identifier(), for: indexPath) as! FCVerifyMobileTableViewCell
                        cell.verifyMobileActionClousure = { [weak self] number,type in
                            if let strongSelf = self {
                                strongSelf.verifyEmailMobileClousure(number, type)
                            }
                        }
                        return cell
                    }
//                } else {
//                    let cell = tableView.dequeueReusableCell(withIdentifier: FCVerifyStaticMessageTVCell.identifier(), for: indexPath) as! FCVerifyStaticMessageTVCell
//
//                    return cell
//                }
            }
        } else if cellType == .pancardCellType {
            if isPanVerified {
                let cell = tableView.dequeueReusableCell(withIdentifier: VerifiedTableViewCell.identifier(), for: indexPath) as! VerifiedTableViewCell
                cell.configureCell(cellType: .pancardCellType, isEmail: false)
                return cell
            }
            else if isPanunderReview {
                let cell = tableView.dequeueReusableCell(withIdentifier: VerifiedTableViewCell.identifier(), for: indexPath) as! VerifiedTableViewCell
               cell.ispandUnderReview = true
                cell.configureCell(cellType: .pancardCellType, isEmail: false)
                return cell
            }
            else {
                let cell = tableView.dequeueReusableCell(withIdentifier: FCPanCardTableViewCell.identifier(), for: indexPath) as! FCPanCardTableViewCell
                cell.aPanDobTextField.text = APP_DEL.panDob
                    cell.aPanNumberTextField.text = APP_DEL.panNumber
                cell.aPanNameTextField.text = APP_DEL.panName
                cell.uploadImageClouser = {[weak self] cellType in
                    if let strongSelf = self {
                        strongSelf.uploadImageClouser(cellType)
                    }
                }
                if let image = selectedPanImage {
                    cell.aImageView.image = image
                }
                cell.submitButtonActionClousure = { [weak self] panName,panNo,dob in
                    if let strongSelf = self {
                        strongSelf.submitButtonForPanClousure(panName,panNo,dob)
                    }
                }
                cell.imageUploadMsg(isUpload: isPanImageAdded)
                return cell
            }
        } else {
            if isBankVerified {
                let cell = tableView.dequeueReusableCell(withIdentifier: VerifiedTableViewCell.identifier(), for: indexPath) as! VerifiedTableViewCell
                
                cell.configureCell(cellType: .bankCellType, isEmail: false)
                return cell
            } else if isBankUnderReview {
                let cell = tableView.dequeueReusableCell(withIdentifier: VerifiedTableViewCell.identifier(), for: indexPath) as! VerifiedTableViewCell
                               cell.configureCell(cellType: .bankCellType, isEmail: false)
                cell.isbankUnderreivew = true
                return cell
            }
            else {
                let cell = tableView.dequeueReusableCell(withIdentifier: FCBankTableViewCell.identifier(), for: indexPath) as! FCBankTableViewCell
               
                cell.aAcountNameTextField.text = APP_DEL.accountName
                cell.aAcountIFSCTextField.text = APP_DEL.ifscAccount
                cell.aAcountBankField.text = APP_DEL.amountBank
                cell.aAcountNumberTextField.text = APP_DEL.acocuntNumber
                
                
                cell.uploadImageClouser = {[weak self] cellType in
                    if let strongSelf = self {
                        strongSelf.uploadImageClouser(cellType)
                    }
                }
                cell.submitButtonActionClousure = { [weak self] accountName,accountNo,ifscCode,bankName in
                    if let strongSelf = self {
                        strongSelf.submitButtonClousure(accountName, accountNo, ifscCode, bankName)
                    }
                }
                if let image = selectedBankImage {
                    cell.aImageView.image = image
                }
                cell.imageUploadMsg(isUpload: isBankImageAdded)
                return cell
            }
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        didSelectClousure(indexPath.row)
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch itematIndex {
        case 0:
            return UITableView.automaticDimension
//        case 1:
//            return 500
        default:
             return UITableView.automaticDimension
        }
       
    }
}

