//
//  PopoverViewController.swift
//  Club11
//
//  Created by Developer on 30/05/19.
//

import UIKit

class PopoverViewController: UIViewController {

    @IBOutlet private var aTableView: UITableView!
    @IBOutlet private var aPopupView: UIView!
    
    var stateSelectionClousure: ((String) -> Void) = { _ in }
    var stateDataArray = ["Andhra Pradesh","Arunachal Pradesh","Assam","Bihar","Chhattisgarh","Goa","Gujarat","Haryana","Himachal Pradesh","Jammu and Kashmir","Jharkhand","Karnataka","Kerala", "Madhya Pradesh","Maharashtra","Manipur","Meghalaya","Mizoram","Nagaland","Odisha","Punjab","Rajasthan","Sikkim","Tamil Nadu", "Telangana","Tripura","Uttar Pradesh","Uttarakhand", "West Bengal"]

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        registerCell()
    }
    
    private func registerCell() {
        aTableView.register(UINib(nibName: PopOverTableViewCell.identifier(), bundle: nil), forCellReuseIdentifier: PopOverTableViewCell.identifier())
    }
    private func setupUI() {
        aPopupView.layer.cornerRadius = 10
        aPopupView.layer.masksToBounds = true
    }
    @IBAction func closeButtonAction(_ sender: Any) {
        dismiss(animated: false, completion: nil)
    }
}

// MARK: Table View Delegate Method
extension PopoverViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stateDataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PopOverTableViewCell.identifier(), for: indexPath) as! PopOverTableViewCell
        cell.configCell(state: stateDataArray[indexPath.item])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 30
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedItem = stateDataArray[indexPath.item]
        stateSelectionClousure(selectedItem)
    }
}
