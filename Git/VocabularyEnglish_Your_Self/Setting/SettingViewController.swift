//
//  SettingViewController.swift
//  VocabularyEnglish
//
//  Created by Cata on 7/14/20.
//  Copyright © 2020 Cata. All rights reserved.
//

import UIKit
import UserNotifications

class SettingViewController: UIViewController {
    
    let defaults = UserDefaults.standard
    
    @IBOutlet weak var tick: UIButton!
    
    
    @IBAction func reminder(_ sender: UIButton) {
        if self.tick.isHidden {
            
            self.tick.isHidden = false
            defaults.set(false, forKey: "show")
        } else {
            
            self.tick.isHidden = true
            defaults.set(true, forKey: "show")
        }
    }
    
    @IBAction func startTime(_ sender: Any) {
    }
    
    
    @IBOutlet weak var startLabel: UILabel!
    
    @IBAction func endTime(_ sender: Any) {
    }
    
    
    @IBOutlet weak var endLabel: UILabel!
    
    @IBAction func weekDay() {
        
    }
    
    
    @IBAction func tapSetting(_ sender: UISwitch) {
        if sender.isOn == false {
            
        } else {
            
            notifiDetail()
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Setting"
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert,.badge, .sound], completionHandler: {(didAllow, error) in })
        test()
        
        noti()
        
    }
    
    func test() {
        let a = defaults.bool(forKey: "show")
        if a {
            self.tick.isHidden = true
            
        } else {
            self.tick.isHidden = false
        }
    }
    
    func notifiDetail() {
        
        let title = vocabularys![Int.random(in: 0...(vocabularys!.count - 1))].vocabulary
        
        let content = UNMutableNotificationContent()
        content.title = "Learn a new vocabulary!!!!"
        content.subtitle = "👉👉👉 \(title) 👈👈👈"
        content.body = "You have 30 seconds. Never give up!!! "
        content.sound = UNNotificationSound.default
        
        guard let url =  Bundle.main.url(forResource: "vocabulary", withExtension: "png") else {
            return
        }
        
        let attech = try! UNNotificationAttachment(identifier: "", url: url, options: .none)
        content.attachments = [attech]
        
        let triger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        let request = UNNotificationRequest(identifier: "vocabulary", content: content, trigger: triger)
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }
    func noti() {
        let content = UNMutableNotificationContent()
               content.title = "Learn a new vocabulary!!!!"
               content.body = "You have 30 seconds. Never give up!!! "
               content.sound = UNNotificationSound.default
        let weekdayset = [1,2,3,4,5,7]
        for i in weekdayset {
            var dateInfo = DateComponents()
            dateInfo.hour = 11
            dateInfo.minute = 18
            dateInfo.weekday = i
            dateInfo.timeZone = .current
            print(i)
        let trig = UNCalendarNotificationTrigger(dateMatching: dateInfo, repeats: true)
        let request = UNNotificationRequest(identifier: "thu", content: content, trigger: trig)
        
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }
    }
    
    
    
}
