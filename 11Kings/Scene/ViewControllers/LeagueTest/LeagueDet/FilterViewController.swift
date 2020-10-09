//
//  FilterViewController.swift
//  11Kings
//
//  Created by uu on 06/08/20.
//  Copyright © 2020 Macbook. All rights reserved.
//

import UIKit
protocol sendFilterData {
   func sendData(entryArray:[Int],multiEntry:[Int],contestSize:[Int],winningEnrtry:[Int])
    func close()
}
class FilterViewController: UIViewController {
    
    @IBOutlet weak var entry1: UIButton!
    @IBOutlet weak var entry2: UIButton!
    @IBOutlet weak var entry3: UIButton!
    @IBOutlet weak var entry4: UIButton!
    
    @IBOutlet weak var contestS1: UIButton!
    @IBOutlet weak var contestS2: UIButton!
    @IBOutlet weak var contestS3: UIButton!
    @IBOutlet weak var contestS4: UIButton!
    @IBOutlet weak var contestS5: UIButton!
    @IBOutlet weak var contestS6: UIButton!
    @IBOutlet weak var multiEntry2: UIButton!
    @IBOutlet weak var multiEntry3: UIButton!
    @IBOutlet weak var multiEntry1: UIButton!
    @IBOutlet weak var winning4: UIButton!
    @IBOutlet weak var winning3: UIButton!
    @IBOutlet weak var winning2: UIButton!
    @IBOutlet weak var winning1: UIButton!
    var entryArray = [Int]()
    var delegate:sendFilterData?
    var multiEntryArray = [Int]()
    var contestSArray = [Int]()
    var winningArray = [Int]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        for i in 0..<entryArray.count  {
            if entryArray[i] == 1 {
                entry1.isSelected = true
            }
            if entryArray[i] == 2 {
                entry2.isSelected = true
            }
            if entryArray[i] == 3 {
                entry3.isSelected = true
            }
            if entryArray[i] == 4 {
            entry4.isSelected = true
            }
        }
        
        for i in 0..<winningArray.count  {
            if winningArray[i] == 1 {
                winning1.isSelected = true
            }
            if winningArray[i] == 2 {
                winning2.isSelected = true
            }
            if winningArray[i] == 3 {
                winning3.isSelected = true
            }
            if winningArray[i] == 4 {
                           winning4.isSelected = true
                       }
        }
        for i in 0..<multiEntryArray.count  {
            if multiEntryArray[i] == 1 {
                                      multiEntry1.isSelected = true
                                  }
            if multiEntryArray[i] == 2 {
                multiEntry2.isSelected = true
            }
            if multiEntryArray[i] == 3 {
                multiEntry3.isSelected = true
            }
            
        }
        for i in 0..<contestSArray.count  {
            if contestSArray[i] == 1 {
             contestS1.isSelected = true
            }
            if contestSArray[i] == 2 {
             contestS2.isSelected = true
            }
            if contestSArray[i] == 3 {
             contestS3.isSelected = true
            }
            if contestSArray[i] == 4 {
             contestS4.isSelected = true
            }
            if contestSArray[i] == 5 {
             contestS5.isSelected = true
            }
            if contestSArray[i] == 6 {
             contestS6.isSelected = true
            }
        }
        
    }
    @IBAction func entry3(_ sender: UIButton) {
        if sender.isSelected {
            for i in 0..<entryArray.count  {
                if entryArray[i] == 3 {
                    entryArray.remove(at: i)
                    
                    sender.isSelected = false
                    return
                }
                else {
                    continue
                }
            }
            
        }
        else {
            entryArray.append(3)
        }
        sender.isSelected = !sender.isSelected
        
    }
    
    @IBAction func close(_ sender: Any) {
        self.delegate?.close()
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func entry1(_ sender: UIButton) {
        if sender.isSelected {
            for i in 0..<entryArray.count {
                if entryArray[i] == 1 {
                    entryArray.remove(at: i)
                    sender.isSelected = false
                    
                return
                }
                else {
                    continue
                }
            }
            
        }
        else {
            entryArray.append(1)
        }
        sender.isSelected = !sender.isSelected
    }
    
    @IBAction func entry2(_ sender: UIButton) {
        if sender.isSelected {
            for i in 0..<entryArray.count {
                if entryArray[i] == 2 {
                    entryArray.remove(at: i)
                    sender.isSelected = false
                     return
                }
                else {
                    continue
                }
            }
            
        }
        else {
            entryArray.append(2)
        }
        sender.isSelected = !sender.isSelected
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    
    
    @IBAction func entry4(_ sender: UIButton) {
        if sender.isSelected {
            for i in 0..<entryArray.count  {
                if entryArray[i] == 4 {
                    entryArray.remove(at: i)
                    sender.isSelected = false
                    return
                }
                else {
                    continue
                }
            }
            
        }
        else {
            entryArray.append(4)
        }
        sender.isSelected = !sender.isSelected
    }
    
    @IBAction func winnig4(_ sender: Any) {
        if winning4.isSelected {
            for i in 0..<winningArray.count  {
                if winningArray[i] == 4 {
                    winningArray.remove(at: i)
                    winning4.isSelected = false
                    return
                }
                else {
                    continue
                }
            }
            
        }
        else {
            winningArray.append(4)
        }
        winning4.isSelected = !winning4.isSelected
        
    }
    @IBAction func winning3(_ sender: UIButton) {
        if sender.isSelected {
            for i in 0..<winningArray.count {
                if winningArray[i] == 3 {
                    winningArray.remove(at: i)
                    sender.isSelected = false
                    return
                }
                else {
                    continue
                }
            }
            
        }
        else {
            winningArray.append(3)
        }
        sender.isSelected = !sender.isSelected
        
    }
    
    @IBAction func winnigs1(_ sender: UIButton) {
        if sender.isSelected {
            for i in 0..<winningArray.count {
                if winningArray[i] == 1 {
                    winningArray.remove(at: i)
                    sender.isSelected = false
                    return
                }
                else {
                    continue
                }
            }
            
        }
        else {
            winningArray.append(1)
        }
        sender.isSelected = !sender.isSelected
        
    }
    
    @IBAction func winning2(_ sender: UIButton) {
        if sender.isSelected {
            for i in 0..<winningArray.count {
                if winningArray[i] == 2 {
                    winningArray.remove(at: i)
                    sender.isSelected = false
                    return
                }
                else {
                    continue
                }
            }
            
        }
        else {
            winningArray.append(2)
        }
        sender.isSelected = !sender.isSelected
    }
    @IBAction func multiEntry1(_ sender: UIButton) {
        if sender.isSelected {
            for i in 0..<multiEntryArray.count {
                if multiEntryArray[i] == 1 {
                    multiEntryArray.remove(at: i)
                    sender.isSelected = false
                    return
                }
                else {
                    continue
                }
            }
            
        }
        else {
            multiEntryArray.append(1)
        }
        sender.isSelected = !sender.isSelected
    }
    
    @IBAction func multiEntry2(_ sender: Any) {
        if multiEntry2.isSelected {
            for i in 0..<multiEntryArray.count  {
                if multiEntryArray[i] == 2 {
                    multiEntryArray.remove(at: i)
                    multiEntry2.isSelected = false
                    return
                }
                else {
                    continue
                }
            }
            
        }
        else {
            multiEntryArray.append(2)
        }
        multiEntry2.isSelected = !multiEntry2.isSelected
    }
    @IBAction func muliEntry3(_ sender: UIButton) {
        if sender.isSelected {
            for i in 0..<multiEntryArray.count {
                if multiEntryArray[i] == 3 {
                    multiEntryArray.remove(at: i)
                    sender.isSelected = false
                    return
                }
                else {
                    continue
                }
            }
            
        }
        else {
            multiEntryArray.append(3)
        }
        sender.isSelected = !sender.isSelected
    }
    
    @IBAction func contestSize2(_ sender: UIButton) {
        if sender.isSelected {
            for i in 0..<contestSArray.count {
                if contestSArray[i] == 2 {
                    contestSArray.remove(at: i)
                    sender.isSelected = false
                    return
                }
                else {
                    continue
                }
            }
            
        }
        else {
            contestSArray.append(2)
        }
        sender.isSelected = !sender.isSelected
    }
    @IBAction func contestSize1(_ sender: UIButton) {
        if contestS1.isSelected {
            for i in 0..<contestSArray.count  {
                if contestSArray[i] == 1 {
                    contestSArray.remove(at: i)
                    sender.isSelected = false
                    return
                }
                else {
                    continue
                }
            }
            
        }
        else {
            contestSArray.append(1)
        }
        contestS1.isSelected = !contestS1.isSelected
        
    }
    
    @IBAction func contestSize6(_ sender: Any) {
        if contestS6.isSelected {
            for i in 0..<contestSArray.count  {
                if contestSArray[i] == 6 {
                    contestSArray.remove(at: i)
                    contestS6.isSelected = false
                    return
                }
                else {
                    continue
                }
            }
            
        }
        else {
            contestSArray.append(6)
        }
        contestS6.isSelected = !contestS6.isSelected
        
    }
    @IBAction func contestSize5(_ sender: Any) {
        if contestS5.isSelected {
            for i in 0..<contestSArray.count  {
                if contestSArray[i] == 5 {
                    contestSArray.remove(at: i)
                      contestS5.isSelected = false
                    return
                }
                else {
                    continue
                }
            }
            
        }
        else {
            contestSArray.append(5)
        }
        contestS5.isSelected = !contestS5.isSelected
        
    }
    @IBAction func contestSize4(_ sender: Any) {
        if contestS4.isSelected {
            for i in 0..<contestSArray.count  {
                if contestSArray[i] == 4 {
                    contestSArray.remove(at: i)
                     contestS4.isSelected = false
                    return
                }
                else {
                    continue
                }
            }
            
        }
        else {
            contestSArray.append(4)
        }
        contestS4.isSelected = !contestS4.isSelected
        
    }
    @IBAction func contestSize3(_ sender: Any) {
        if contestS3.isSelected {
            for i in 0..<contestSArray.count {
                if contestSArray[i] == 3 {
                    contestSArray.remove(at: i)
                     contestS3.isSelected = false
                    return
                }
                else {
                    continue
                }
            }
            
        }
        else {
            contestSArray.append(3)
        }
        contestS3.isSelected = !contestS3.isSelected
        
    }
    @IBAction func appleAllFilters(_ sender: Any) {
        print(entryArray.count,entryArray)
        print(winningArray.count,winningArray)
        print(contestSArray.count,contestSArray)
        print(multiEntryArray.count,multiEntryArray)

        self.delegate?.sendData(entryArray: entryArray, multiEntry: multiEntryArray, contestSize: contestSArray, winningEnrtry: winningArray)
        self.navigationController?.popViewController(animated: true)
        
        
    }
    
    @IBAction func clearAllFilters(_ sender: Any) {
        entryArray.removeAll()
        winningArray.removeAll()
        contestSArray.removeAll()
        multiEntryArray.removeAll()
        entry1.isSelected = false
       
        entry2.isSelected = false
        entry3.isSelected = false
        entry4.isSelected = false
        entry1.setImage(#imageLiteral(resourceName: "Untick1"), for: .normal)
        entry2.setImage(#imageLiteral(resourceName: "Untick1"), for: .normal)
        entry3.setImage(#imageLiteral(resourceName: "Untick1"), for: .normal)
        entry4.setImage(#imageLiteral(resourceName: "Untick1"), for: .normal)
        winning1.isSelected = false
        winning2.isSelected = false
        winning3.isSelected = false
        winning4.isSelected = false
        winning1.setImage(#imageLiteral(resourceName: "Untick1"), for: .normal)
        winning1.setImage(#imageLiteral(resourceName: "Untick1"), for: .normal)
        winning1.setImage(#imageLiteral(resourceName: "Untick1"), for: .normal)
        winning1.setImage(#imageLiteral(resourceName: "Untick1"), for: .normal)
        multiEntry1.isSelected = false
        multiEntry2.isSelected = false
        multiEntry3.isSelected = false
        multiEntry1.setImage(#imageLiteral(resourceName: "Untick1"), for: .normal)
        multiEntry2.setImage(#imageLiteral(resourceName: "Untick1"), for: .normal)
        multiEntry3.setImage(#imageLiteral(resourceName: "Untick1"), for: .normal)
        contestS1.isSelected = false
        contestS2.isSelected = false
        contestS3.isSelected = false
        contestS4.isSelected = false
        contestS5.isSelected = false
        contestS6.isSelected = false
        contestS1.setImage(#imageLiteral(resourceName: "Untick1"), for: .normal)
        contestS2.setImage(#imageLiteral(resourceName: "Untick1"), for: .normal)
        contestS3.setImage(#imageLiteral(resourceName: "Untick1"), for: .normal)
        contestS5.setImage(#imageLiteral(resourceName: "Untick1"), for: .normal)
        contestS4.setImage(#imageLiteral(resourceName: "Untick1"), for: .normal)
        contestS6.setImage(#imageLiteral(resourceName: "Untick1"), for: .normal)
                 self.delegate?.sendData(entryArray: entryArray, multiEntry: multiEntryArray, contestSize: contestSArray, winningEnrtry: winningArray)

        self.navigationController?.popViewController(animated: true)
        
    }
}



