//
//  BannerTVCell.swift
//  TeamBanao
//
//  Created by Developer on 02/02/19.
//  Copyright © 2019 Rickey_iDev. All rights reserved.
//

import UIKit

class BannerTVCell: UITableViewCell {

    @IBOutlet weak var aBannerCollectionView: UICollectionView!
    @IBOutlet weak private var aContainerView: UIView!
    
    var bannerSelection: ((String) -> Void) = { _ in }
    var bannerTimer = Timer()
    var bannerArr = [BannerResponses]() {
        didSet {
            aBannerCollectionView.reloadDataInMainQueue()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        registerCell()
        startTimer()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    fileprivate func registerCell() {
        aBannerCollectionView.register(UINib(nibName: BannerCVCell.identifier(), bundle: nil), forCellWithReuseIdentifier: BannerCVCell.identifier())
    }

    func startTimer() {
        
        bannerTimer = Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(self.scrollAutomatically), userInfo: nil, repeats: true)
    }
    
    
    @objc func scrollAutomatically(_ timer1: Timer) {
        
        if let coll  = aBannerCollectionView {
            for cell in coll.visibleCells {
                let indexPath: IndexPath? = coll.indexPath(for: cell)
                if ((indexPath?.row)!  < bannerArr.count - 1){
                    let indexPath1: IndexPath?
                    indexPath1 = IndexPath.init(row: (indexPath?.row)! + 1, section: (indexPath?.section)!)
                    coll.scrollToItem(at: indexPath1!, at: .right, animated: true)
                } else{
                    let indexPath1: IndexPath?
                    indexPath1 = IndexPath.init(row: 0, section: (indexPath?.section)!)
                    coll.scrollToItem(at: indexPath1!, at: .left, animated: true)
                }
            }
        }
    }
    
}

extension BannerTVCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return bannerArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BannerCVCell.identifier(), for: indexPath) as! BannerCVCell
        cell.configureCell(sliderData: bannerArr[indexPath.item])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.frame.width, height: self.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        if let bannerType = bannerArr[indexPath.item].type {
        bannerSelection(bannerArr[indexPath.item].link ?? "")
//        }
    }
}
