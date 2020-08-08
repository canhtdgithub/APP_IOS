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
    
}
