//
//  TimerManager.swift
//  Timer
//
//  Created by 王荣荣 on 7/5/16.
//  Copyright © 2016 王荣荣. All rights reserved.
//

import Foundation
import UIKit

class TimerManager  {
    static let sharedManager: TimerManager = {
        return TimerManager()
    }()
    
    var dateFormatter: NSDateFormatter = {
        let formatter = NSDateFormatter()
        formatter.timeStyle = .ShortStyle
        formatter.dateFormat = "HH:mm"
        return formatter
    }()
    private var EASY_MX_TIME_KEY = "easy_mx_time_key"
    private var notification: UILocalNotification!
    private init() {
        let notification = UILocalNotification()
        self.notification = notification
        notification.alertBody = "easy meditation"
        notification.applicationIconBadgeNumber =
            UIApplication.sharedApplication().applicationIconBadgeNumber + 1
    }
    
    func fireTimer(date fireDate: NSTimeInterval) {
        UIApplication.sharedApplication().cancelAllLocalNotifications()
        self.notification.fireDate = NSDate(timeIntervalSinceNow: fireDate)
        UIApplication.sharedApplication().scheduleLocalNotification(self.notification)
    }
    
    func invalideTimer() {
        UIApplication.sharedApplication().cancelLocalNotification(self.notification)
    }
    
    func saveTime(time: NSString) {
        NSUserDefaults.standardUserDefaults().setObject(time, forKey: EASY_MX_TIME_KEY)
    }
    
    func deleteTime() {
        NSUserDefaults.standardUserDefaults().removeObjectForKey(EASY_MX_TIME_KEY)
    }
    
    var cachedTime: String? {
        guard NSUserDefaults.standardUserDefaults().stringForKey(EASY_MX_TIME_KEY) != nil else {
            return nil
        }
        return NSUserDefaults.standardUserDefaults().stringForKey(EASY_MX_TIME_KEY)!
    }
    
    var isSetting: Bool {
       let time = NSUserDefaults.standardUserDefaults().objectForKey(EASY_MX_TIME_KEY)
        if time != nil {
            return true
        } else {
            return false
        }
    }
}