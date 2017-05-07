//
//  NSDate+Methods.swift
//  intermine-ios
//
//  Created by Nadia on 5/7/17.
//  Copyright © 2017 Nadia. All rights reserved.
//

import Foundation

extension NSDate {
    
    class func hasIntervalPassed(lastUpdated: NSDate, timeInterval: Double) -> Bool {
        let currentDate = NSDate()
        let timePassed = lastUpdated.addingTimeInterval(timeInterval)
        let dateComparisionResult: ComparisonResult = currentDate.compare(timePassed as Date)
        switch dateComparisionResult {
        case .orderedDescending:
            // current date is larger or the same as timePassed
            fallthrough
        case .orderedSame:
            return true
        default:
            // current date is smaller than timePassed
            return false
        }
    }
}
