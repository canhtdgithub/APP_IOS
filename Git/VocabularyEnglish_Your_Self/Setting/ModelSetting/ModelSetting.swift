//
//  ModelSetting.swift
//  VocabularyEnglish
//
//  Created by Cata on 8/15/20.
//  Copyright © 2020 Cata. All rights reserved.
//

import Foundation
import UIKit

class ModelSetting {
    static let shared = ModelSetting()
    let defaults = UserDefaults.standard
    var arrayBool = [true, true, true, true, true, true, true]
    
    func testReminder(tick: UIButton) {
        if tick.isHidden {
            
            tick.isHidden = false
            defaults.set(arrayBool, forKey: "arrayBool")
            
            defaults.set(false, forKey: "show")
            
        } else {
            arrayBool = [true,true,true,true,true,true,true ]
            tick.isHidden = true
            defaults.set(true, forKey: "show")
        }
    }
    
    func testShowReminder(tick: UIButton) {
        guard let show = defaults.value(forKey: "show") as? Bool else {
            return
        }
        if show {
            tick.isHidden = true

        } else {
            tick.isHidden = false
        }
    }
    
    func testShowTime(startLabel: UILabel) {
        guard let time = defaults.value(forKey: "datePicker") as? String else {
            return
        }
        startLabel.text = time
    }
    
    func changeColorButton(sender: UIButton, indexButton: Int) {
        guard var arr = defaults.value(forKey: "arrayBool") as? Array<Bool> else {
            return
        }
        if sender.tag == indexButton && arr[indexButton] {
            arr[indexButton] = false
            defaults.set(arr, forKey: "arrayBool")
            print(defaults.set(arr, forKey: "arrayBool"))
            sender.backgroundColor = .gray
        } else {
            arr[indexButton] = true
            defaults.set(arr, forKey: "arrayBool")
            sender.backgroundColor = .red
        }
    }
    
    func setColorButton(btn: [UIButton]) {
        guard let arr = defaults.value(forKey: "arrayBool") as? Array<Bool> else {
            return
        }
        for i in 0...6 {
            if arr[i] == false {
                btn[i].backgroundColor = .gray
            }
        }
    }
    
   

    
    func notifiDetail() {
        
        let title = vocabularys![Int.random(in: 0...(vocabularys!.count - 1))].vocabulary
        
        let content = UNMutableNotificationContent()
        content.title = "Learn a new vocabulary!!!!"
        content.subtitle = "👉👉👉 \(title) 👈👈👈"
        content.body = "You have 30 seconds. Never give up!!! "
        content.sound = UNNotificationSound.default
        content.badge = 1
        
        guard let url =  Bundle.main.url(forResource: "vocabulary", withExtension: "png") else {
            return
        }
        
        let attech = try! UNNotificationAttachment(identifier: "", url: url, options: .none)
        content.attachments = [attech]
        
        let triger = UNTimeIntervalNotificationTrigger(timeInterval: 30*60, repeats: true)
        let request = UNNotificationRequest(identifier: "vocabulary", content: content, trigger: triger)
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }
    
}
