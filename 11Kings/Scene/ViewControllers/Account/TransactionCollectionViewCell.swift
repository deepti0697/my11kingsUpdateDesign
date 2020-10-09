//
//  TransactionCollectionViewCell.swift
//  DreamTeam
//
//  Created by Test on 01/06/20.
//  Copyright © 2020 Macbook. All rights reserved.
//

import Foundation
import UIKit
class TransactionCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var trasactionTableView: UITableView!
    
      var refreshControl = UIRefreshControl()
    var transactionDataModel = [myTransaction](){
         didSet {
                   trasactionTableView.reloadDataInMainQueue()
               }
    }
    override func awakeFromNib() {
           super.awakeFromNib()
        trasactionTableView.dataSource = self
        trasactionTableView.delegate = self
           registerCell()
        addPullToRefresh()
       }
    
    func registerCell() {
      trasactionTableView.register(UINib(nibName: "TransactionTableViewCell", bundle: nil), forCellReuseIdentifier: "TransactionTableViewCell")
    }
    func addPullToRefresh() {
                  refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
                  refreshControl.addTarget(self, action: #selector(refreshData(sender:)), for: .valueChanged)
                  trasactionTableView.refreshControl = refreshControl
              }
              
              @objc func refreshData(sender:AnyObject) {
                
       //          getMyContest()
       //           setNoDataLabel()
                trasactionTableView.reloadDataInMainQueue()
                  self.refreshControl.endRefreshing()
              }
}
extension TransactionCollectionViewCell: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return transactionDataModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let cell = tableView.dequeueReusableCell(withIdentifier: "TransactionTableViewCell") as! TransactionTableViewCell
        cell.cellConfigure(response: transactionDataModel[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
          
         
               return  100
          
           
       }
}
