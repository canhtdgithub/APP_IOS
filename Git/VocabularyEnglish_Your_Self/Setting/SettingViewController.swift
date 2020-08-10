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
    
    var arrayBool = [Bool]()
    @IBOutlet weak var tick: UIButton!
    
    
    @IBAction func reminder(_ sender: UIButton) {
        if self.tick.isHidden {
            
            self.tick.isHidden = false
            for _ in 0...6 {
                arrayBool.append(true)
            }
            defaults.set(false, forKey: "show")
            
        } else {
            arrayBool.removeAll()
            self.tick.isHidden = true
            defaults.set(true, forKey: "show")
        }
    }
    
    @IBAction func startTime(_ sender: Any) {
    }
    
    
    @IBOutlet weak var startLabel: UILabel!
    
    @IBAction func sunDay(_ sender: UIButton) {
        self.arrayBool[0] = false
        testShowNotification()
        
    }
    
    @IBAction func monDay(_ sender: UIButton) {
        self.arrayBool[1] = false
        testShowNotification()
    }
    
    @IBAction func tuesDay(_ sender: UIButton) {
        self.arrayBool[2] = false
        testShowNotification()
    }
    
    @IBAction func wednessDay(_ sender: UIButton) {
        self.arrayBool[3] = false
        testShowNotification()
    }
    
    @IBAction func thursDay(_ sender: UIButton) {
        self.arrayBool[4] = false
        testShowNotification()
    }
    
    @IBAction func friDay(_ sender: UIButton) {
        self.arrayBool[5] = false
        testShowNotification()
    }
    
    @IBAction func satDay(_ sender: UIButton) {
        self.arrayBool[6] = false
        testShowNotification()
    }
    
    
    
    
    @IBAction func weekDay(_ sender: UIButton) {
        switch sender.tag {
            case 1:
                sender.backgroundColor = .gray
            case 2:
                sender.backgroundColor = .gray
            case 3:
                sender.backgroundColor = .gray
            case 4:
                sender.backgroundColor = .gray
            case 5:
                sender.backgroundColor = .gray
            case 6:
                sender.backgroundColor = .gray
            case 7:
                sender.backgroundColor = .gray
        default:
            print("finish")
        }
        
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
        testShowReminder()
        
    }
    
    func testShowNotification() {
        let date = Date()
             let a = Calendar.current
             let b = a.component(.weekday, from: date)
        if arrayBool[b - 1] {
            noti()
        }
    }
    
    func testShowReminder() {
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
               content.body = "Let's go learning vocabulary. Never give up!!! "
               content.sound = UNNotificationSound.default
         
            var dateInfo = DateComponents()
            dateInfo.hour = 07
            dateInfo.minute = 00
        
            dateInfo.timeZone = .current
           
        let trig = UNCalendarNotificationTrigger(dateMatching: dateInfo, repeats: true)
        let request = UNNotificationRequest(identifier: "thu", content: content, trigger: trig)
        
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    
    }
    
    
    
}
