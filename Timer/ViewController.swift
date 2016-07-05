//
//  ViewController.swift
//  Timer
//
//  Created by 王荣荣 on 7/5/16.
//  Copyright © 2016 王荣荣. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var timeSwitch: UISwitch!
    
    private var timePickerVC: TimePickerViewController!

    override func viewDidLoad() {
        super.viewDidLoad()
       
        self.timePickerVC = TimePickerViewController(nibName: "TimePickerViewController", bundle: nil)
        self.timePickerVC.delegate = self
        if TimerManager.sharedManager.isSetting {
            self.timeSwitch.on = true
            self.timeLabel.text = "每日：\(TimerManager.sharedManager.cachedTime!)"
        } else {
            self.timeSwitch.on = false
        }
    }
   
    @IBAction func switchValueChange(sender: UISwitch) {
        if self.timeSwitch.on {
            timePickerVC.showAtView(self.view)
        } else {
            timePickerVC.hide()
            TimerManager.sharedManager.invalideTimer()
        }
    }
}

extension ViewController: TimePickerViewControllerDelegate {
    func doneClick(currentDate date: NSDate) {
        let time = TimerManager.sharedManager.dateFormatter.stringFromDate(date)
        TimerManager.sharedManager.saveTime(time)
        self.timeLabel.text = "每日：\(time)"
        TimerManager.sharedManager.fireTimer(date: NSDate.intervalFromNow(date))
        self.timePickerVC.hide()
    }
}

