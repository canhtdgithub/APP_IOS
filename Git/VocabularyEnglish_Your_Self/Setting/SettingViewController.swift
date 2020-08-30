//
//  SettingViewController.swift
//  VocabularyEnglish
//
//  Created by Cata on 7/14/20.
//  Copyright © 2020 Cata. All rights reserved.
//

import UIKit
import MessageUI
import UserNotifications

class SettingViewController: UIViewController {


    @IBOutlet weak var table: UITableView!
        
    @IBOutlet weak var viewPicker: UIView!


    @IBOutlet weak var datePicker: UIDatePicker!

    @IBOutlet weak var tick: UIButton!


    @IBOutlet var btn: [UIButton]!


    @IBAction func reminder(_ sender: UIButton) {
        ModelSetting.shared.testReminder(tick: tick)
    }

    @IBAction func startTime(_ sender: Any) {

        viewPicker.isHidden = false
        datePicker.backgroundColor = UIColor(red: 19/255, green: 200/255, blue: 250/255, alpha: 1.0)

    }


    @IBOutlet weak var startLabel: UILabel!


    @IBOutlet weak var tapSettingSwitch: UISwitch!

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
            UserDefaults.standard.set(false, forKey: "showvocab")
        } else {
            UserDefaults.standard.set(true, forKey: "showvocab")
            ModelSetting.shared.notifiDetail()
        }

    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Setting"
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert,.badge, .sound], completionHandler: {(didAllow, error) in })
        ModelSetting.shared.testShowVocab(tapSettingSwitch: tapSettingSwitch)
        ModelSetting.shared.testShowReminder(tick: tick)
        ModelSetting.shared.setColorButton(btn: btn)
        ModelSetting.shared.testShowTime(startLabel: startLabel)
        ModelSetting.shared.addItem()
        ModelSetting.shared.settingNavigationBar(viewController: self )
        regisTable()
        tapViewPicker()
        
        datePicker.addTarget(self, action: #selector(handl(sender:)), for: .valueChanged)
        for i in 0...btn.count - 1 {
            btn[i].layerButtom(cornerRadius: 10, borderColor: UIColor.gray.cgColor, borderWidth: 1)
        }

    }
    func regisTable() {
        table.delegate = self
        table.dataSource = self
        table.register(UINib(nibName: "SettingTableViewCell", bundle: .main), forCellReuseIdentifier: "cell1")
    }
    
    func feedBack() {
         guard MFMailComposeViewController.canSendMail() else {
             return
         }
        let composer = MFMailComposeViewController()
        composer.mailComposeDelegate = self
        composer.setToRecipients(["canhgithub@gmail.com"])
        composer.setSubject("Feedback")
        composer.setMessageBody("Hi you", isHTML: false)
        self.present(composer, animated: true, completion: nil)
     }
     

    func tapViewPicker() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(action))

        viewPicker.addGestureRecognizer(tap)
    }

    @objc func action() {
        viewPicker.isHidden = true
    }

    @objc func handl(sender: UIDatePicker) {
        ModelSetting.shared.setTimePicker(sender: sender, startLabel: startLabel)

    }

}

extension SettingViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ModelSetting.shared.list.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: "cell1", for: indexPath) as! SettingTableViewCell
        
        cell.config(list: ModelSetting.shared.list[indexPath.row])

        return cell 
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            feedBack()
        } else {
          
        }
        
    }
    
    
}
extension SettingViewController: MFMailComposeViewControllerDelegate {
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
}
