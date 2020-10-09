//
//  Sorting.swift
//  Club11
//
//  Created by Developer on 09/06/19.
//

import UIKit

class Sorting: NSObject {

    func sortingOfLeagueOfTime(arrayToSort: NSArray) -> NSArray {
        var sortedArray = NSArray()
        sortedArray = arrayToSort.sortedArray { (obj1, obj2) -> ComparisonResult in
            let time1 = (obj1 as! LiveMatchResponse).id!
            let time2 = (obj2 as! LiveMatchResponse).id!
            if time1 < time2 {
                return (ComparisonResult).orderedAscending
            } else if time1 > time2 {
                return (ComparisonResult).orderedDescending
            } else {
                return (ComparisonResult).orderedSame
            }
            } as NSArray
        return sortedArray
    }
    
    func sortingOfLeagueByEntryFee(arrayToSort: NSArray) -> NSArray {
        var sortedArray = NSArray()
        sortedArray = arrayToSort.sortedArray { (obj1, obj2) -> ComparisonResult in
            let shadeCode1 = (obj1 as! Leagues).entryfee!
            let shadeCode2 = (obj2 as! Leagues).entryfee!
            if shadeCode1 < shadeCode2 {
                return (ComparisonResult).orderedAscending
            } else if shadeCode1 > shadeCode2 {
                return (ComparisonResult).orderedDescending
            } else {
                return (ComparisonResult).orderedSame
            }
            } as NSArray
        return sortedArray
    }
    func sortingLeaguebycredit(arrayToSort: NSArray) -> NSArray {
           var sortedArray = NSArray()
           sortedArray = arrayToSort.sortedArray { (obj1, obj2) -> ComparisonResult in
            let shadeCode1 = (obj1 as! PlayerListResponses).credit!
            let shadeCode2 = (obj2 as! PlayerListResponses).credit!
//             APP_DEL.batMansArray =    APP_DEL.batMansArray.sorted(by: { ($0.credit ?? "0") < ($1.credit ?? "0") })
          
          
               if shadeCode1 < shadeCode2 {
                             return (ComparisonResult).orderedAscending
                         }
                   else {
                             return (ComparisonResult).orderedAscending
                         }
                         } as NSArray
                     return sortedArray
                 }
       
    func sortingOfLeagueByWinning(arrayToSort: NSArray) -> NSArray {
        var sortedArray = NSArray()
        sortedArray = arrayToSort.sortedArray { (obj1, obj2) -> ComparisonResult in
            let shadeCode1 = (obj1 as! Leagues).win_amount!
            let shadeCode2 = (obj2 as! Leagues).win_amount!
            if shadeCode1 < shadeCode2 {
                return (ComparisonResult).orderedAscending
            } else if shadeCode1 > shadeCode2 {
                return (ComparisonResult).orderedDescending
            } else {
                return (ComparisonResult).orderedSame
            }
            } as NSArray
        return sortedArray
    }
    
    func sortingOfLeagueByTeam(arrayToSort: NSArray) -> NSArray {
        var sortedArray = NSArray()
        sortedArray = arrayToSort.sortedArray { (obj1, obj2) -> ComparisonResult in
            let shadeCode1 = (obj1 as! Leagues).maximum_user!
            let shadeCode2 = (obj2 as! Leagues).maximum_user!
            if shadeCode1 < shadeCode2 {
                return (ComparisonResult).orderedAscending
            } else if shadeCode1 > shadeCode2 {
                return (ComparisonResult).orderedDescending
            } else {
                return (ComparisonResult).orderedSame
            }
            } as NSArray
        return sortedArray
    }
    
  
    
    func sortingOfLeagueByWinners(arrayToSort: NSArray) -> NSArray {
        var sortedArray = NSArray()
        sortedArray = arrayToSort.sortedArray { (obj1, obj2) -> ComparisonResult in
            let shadeCode1 = (obj1 as! Leagues).totalwinners!
            let shadeCode2 = (obj2 as! Leagues).totalwinners!
            if shadeCode1 < shadeCode2 {
                return (ComparisonResult).orderedAscending
            } else if shadeCode1 > shadeCode2 {
                return (ComparisonResult).orderedDescending
            } else {
                return (ComparisonResult).orderedSame
            }
            } as NSArray
        return sortedArray
    }
}

public extension Collection where Element: StringProtocol {
    func sortedNumerically(_ result: ComparisonResult) -> [Element] {
        return sorted { $0.compare($1, options: .numeric) == result }
    }
}
public extension MutableCollection where Element: StringProtocol, Self: RandomAccessCollection {
    mutating func sortNumerically(_ result: ComparisonResult) {
        sort { $0.compare($1, options: .numeric) == result
        }
    }
}
