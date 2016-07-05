//
//  NSDate+Utility.swift
//  Timer
//
//  Created by 王荣荣 on 7/5/16.
//  Copyright © 2016 王荣荣. All rights reserved.
//

import UIKit

extension NSDate {
    static func intervalFromNow(date: NSDate) -> NSTimeInterval{
        let interval = date.timeIntervalSinceNow
        if  interval > 0 {
            return interval
        } else {
            return interval + 60 * 60 * 24
        }
    }
}
