//
//  TimePickerViewController.swift
//  ReminderTimer
//
//  Created by 王荣荣 on 7/5/16.
//  Copyright © 2016 王荣荣. All rights reserved.
//

import UIKit

protocol TimePickerViewControllerDelegate {
    func doneClick(currentDate date: NSDate)
}

class TimePickerViewController: UIViewController {
    private let pickerHeight:CGFloat = 260
    private let animationDuration = 0.25
    @IBOutlet weak var separator: UIView!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var topView: UIView!
    private var currentDate: NSDate = NSDate()
    var delegate: TimePickerViewControllerDelegate!
    
    private var cover: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.datePicker.locale = NSLocale(localeIdentifier: "da_DK")
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        let separatorX: CGFloat = self.separator.frame.origin.x
        let separatorH: CGFloat = 0.5
        let separetorW = self.separator.frame.size.width
        let separatorY = self.separator.frame.origin.y - separatorH
        self.separator.frame = CGRectMake(separatorX, separatorY, separetorW, separatorH)
    }
    
    
    @IBAction func pickDate(sender: UIDatePicker) {
        self.currentDate = self.datePicker.date
        
    }
    @IBAction func cancelClick(sender: AnyObject) {
        hide()
    }
    
    @IBAction func doneClick(sender: AnyObject) {
        self.delegate.doneClick(currentDate: self.currentDate)
    }
    
    func showAtView(view: UIView) {
        if self.cover == nil {
            self.cover = UIView(frame: view.bounds)
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.hide))
            tapGesture.delegate = self
            self.cover.addGestureRecognizer(tapGesture)
            self.cover.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0)
        }
        
        if !view.subviews.contains(self.cover) {
            view.addSubview(self.cover)
            let selfX:CGFloat = 0
            let selfW = view.frame.size.width
            let selfH = self.pickerHeight
            let selfY = view.frame.size.height
            self.view.frame = CGRectMake(selfX, selfY, selfW, selfH)
            self.cover.addSubview(self.view)
        }
       
        UIView.animateWithDuration(self.animationDuration) {
            self.view.transform.ty = -self.pickerHeight
            self.cover.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.3)
        }
    }

    func hide() {
        guard self.cover != nil else { return }
        UIView.animateWithDuration(self.animationDuration, animations: {
            self.cover.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0)
            self.view.transform.ty = 0
            }) { (_) in
              self.cover.removeFromSuperview()
        }
    }
}

extension TimePickerViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldReceiveTouch touch: UITouch) -> Bool {
        if touch.locationInView(gestureRecognizer.view).y > CGRectGetMinY(self.view.frame) {
            return false
        }
        return true
    }
}