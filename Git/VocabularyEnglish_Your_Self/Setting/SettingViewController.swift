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
    

    @IBOutlet weak var viewPicker: UIView!
    
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBOutlet weak var tick: UIButton!
    
 
    @IBOutlet var btn: [UIButton]!
    
    
    @IBAction func reminder(_ sender: UIButton) {
        ModelSetting.shared.testReminder(tick: tick)
    }
    
    @IBAction func startTime(_ sender: Any) {
        
        viewPicker.isHidden = false
        datePicker.backgroundColor = .yellow
        
    }
    
    
    @IBOutlet weak var startLabel: UILabel!
    

    @IBAction func weekDay(_ sender: UIButton) {
       
        switch sender.tag {
            case 1:
                ModelSetting.shared.changeColorButton(sender: sender, indexButton: 1)
            case 2:
                ModelSetting.shared.changeColorButton(sender: sender, indexButton: 2)
            case 3:
                ModelSetting.shared.changeColorButton(sender: sender, indexButton: 3)
            case 4:
                ModelSetting.shared.changeColorButton(sender: sender, indexButton: 4)
            case 5:
                ModelSetting.shared.changeColorButton(sender: sender, indexButton: 5)
            case 6:
                ModelSetting.shared.changeColorButton(sender: sender, indexButton: 6)
            case 0:
                ModelSetting.shared.changeColorButton(sender: sender, indexButton: 0)
        default:
            print("finish")
        }
        
    }
    
    @IBAction func tapSetting(_ sender: UISwitch) {
        if sender.isOn == false {
            
        } else {
            
            ModelSetting.shared.notifiDetail()
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Setting"
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert,.badge, .sound], completionHandler: {(didAllow, error) in })
        
        ModelSetting.shared.testShowReminder(tick: tick)
        ModelSetting.shared.setColorButton(btn: btn)
        ModelSetting.shared.testShowTime(startLabel: startLabel)
        tapViewPicker()
        datePicker.addTarget(self, action: #selector(handl(sender:)), for: .valueChanged)
//        UserDefaults.value(forKey: "hour")
    }
    
    func tapViewPicker() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(action))
        
        viewPicker.addGestureRecognizer(tap)
    }
    
    @objc func action() {
        viewPicker.isHidden = true
    }
    
    @objc func handl(sender: UIDatePicker) {
        
               let timeFormatterHour = DateFormatter()
                timeFormatterHour.dateFormat = "hh"
                let strDateHour = timeFormatterHour.string(from: sender.date)
                     UserDefaults.standard.set(strDateHour, forKey: "hour")
      
                let timeFormatterMinute = DateFormatter()
                timeFormatterMinute.dateFormat = "mm"
                let strDateMinute = timeFormatterMinute.string(from: sender.date)
                     UserDefaults.standard.set(strDateMinute, forKey: "minute")
               
                let timeFormatterAMPM = DateFormatter()
                timeFormatterAMPM.dateFormat = "a"
                let strAMPM = timeFormatterAMPM.string(from: sender.date)
                     UserDefaults.standard.set(strAMPM, forKey: "ampm")
               
               let timeFormatter = DateFormatter()
               timeFormatter.dateStyle = .short
                let strDate = timeFormatter.string(from: sender.date)
                     UserDefaults.standard.set(strDate, forKey: "datePicker")
               
                startLabel.text = "\(strDateHour):\(strDateMinute) \(strAMPM)"
    
    }
}
