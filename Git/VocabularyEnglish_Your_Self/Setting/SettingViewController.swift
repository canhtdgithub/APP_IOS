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
    var arrayBool = [true, true, true, true, true, true, true]
    @IBOutlet weak var tick: UIButton!
    
 
    @IBOutlet var btn: [UIButton]!
    
    
    @IBAction func reminder(_ sender: UIButton) {
        if self.tick.isHidden {
            
            self.tick.isHidden = false
            defaults.set(arrayBool, forKey: "arrayBool")
            
            defaults.set(false, forKey: "show")
            
        } else {
            arrayBool = [true,true,true,true,true,true,true ]
            self.tick.isHidden = true
            defaults.set(true, forKey: "show")
        }
    }
    
    @IBAction func startTime(_ sender: Any) {
    }
    
    
    @IBOutlet weak var startLabel: UILabel!
    

    @IBAction func weekDay(_ sender: UIButton) {
       
        switch sender.tag {
            case 1:
                changeColorButton(sender: sender, indexButton: 1)
            case 2:
                changeColorButton(sender: sender, indexButton: 2)
            case 3:
                changeColorButton(sender: sender, indexButton: 3)
            case 4:
                changeColorButton(sender: sender, indexButton: 4)
            case 5:
                changeColorButton(sender: sender, indexButton: 5)
            case 6:
                changeColorButton(sender: sender, indexButton: 6)
            case 0:
                changeColorButton(sender: sender, indexButton: 0)
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

        guard let arr = defaults.value(forKey: "arrayBool") as? Array<Bool> else {
            return
        }
        for i in 0...6 {
            if arr[i] == false {
                btn[i].backgroundColor = .gray
            }
        }
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
    
    func testShowReminder() {
        guard let show = defaults.value(forKey: "show") as? Bool else {
            return
        }
        if show {
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
