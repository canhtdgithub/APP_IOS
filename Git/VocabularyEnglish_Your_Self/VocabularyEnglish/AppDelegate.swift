//
//  AppDelegate.swift
//  VocabularyEnglish
//
//  Created by Cata on 7/13/20.
//  Copyright © 2020 Cata. All rights reserved.
//

import UIKit
import Firebase
import SystemConfiguration
import IQKeyboardManagerSwift

@available(iOS 11.0, *)

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        testShowNoti()
        IQKeyboardManager.shared.enable = true
        window = UIWindow(frame: UIScreen.main.bounds)
        
        if FirebaseAuth.Auth.auth().currentUser == nil {
            login()
        } else {
            didLogin()
        }
        
        if isConnectedToNetwork() {
            print("you are connected")
        } else {
            print("you are not connected")
        }
  
        window?.makeKeyAndVisible()
        
        
        return true
    }
    
    func login() {
        let viewController = LoginViewController()
        let navi  = UINavigationController(rootViewController: viewController)
        window?.rootViewController = navi
    }
    
    func didLogin() {
        let viewController = ViewController()
        let navi = UINavigationController(rootViewController: viewController)
            navi.tabBarItem.image = UIImage(named: "creat_vocabulary")
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navi.navigationBar.largeTitleTextAttributes = textAttributes
            navi.navigationBar.prefersLargeTitles = true
       
        let gamesController = GamesViewController()
        let navi1 = UINavigationController(rootViewController: gamesController)
            navi1.tabBarItem.image = UIImage(named: "game")

        let searchController = SearchViewController()
        let navi3 = UINavigationController(rootViewController: searchController)
            navi3.tabBarItem.image = UIImage(named: "search")
        
        let settingController = SettingViewController()
        let navi2 = UINavigationController(rootViewController: settingController)
            navi2.tabBarItem.image = UIImage(named: "setting")

        UITabBar.appearance().tintColor = .red
        UITabBar.appearance().barTintColor = .black


        let tabbarViewController = UITabBarController()
        tabbarViewController.viewControllers = [navi, navi1, navi3, navi2]

        window?.rootViewController = tabbarViewController

    }
    
    func isConnectedToNetwork() -> Bool {

         var zeroAddress = sockaddr_in(sin_len: 0, sin_family: 0, sin_port: 0, sin_addr: in_addr(s_addr: 0), sin_zero: (0, 0, 0, 0, 0, 0, 0, 0))
     
         zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
     
         zeroAddress.sin_family = sa_family_t(AF_INET)
     
         let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
     
             $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
     
                 SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
     
             }
     
         }
     
         var flags = SCNetworkReachabilityFlags()
     
         if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
     
             return false
     
         }
     
         let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
     
         let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
     
         return (isReachable && !needsConnection)
     
     }
    
    func noti() {
        let content = UNMutableNotificationContent()
               content.title = "Learn a new vocabulary!!!!"
               content.body = "Let's go learning vocabulary. Never give up!!! "
               content.sound = UNNotificationSound.default
         
            var dateInfo = DateComponents()
        
            dateInfo.hour = testShowHour()
            dateInfo.minute = testShowMinute()
            
            dateInfo.timeZone = .current
           
        let trig = UNCalendarNotificationTrigger(dateMatching: dateInfo, repeats: true)
        let request = UNNotificationRequest(identifier: "thu", content: content, trigger: trig)
        
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    
    }
    
    func testShowNoti() {
        guard let show = UserDefaults.standard.value(forKey: "show") as? Bool, let arr = UserDefaults.standard.value(forKey: "arrayBool") as? Array<Bool> else {
            return
        }
        print(show)
        print(arr)
        
        if show == false {
            let date = Date()
                 let a = Calendar.current
                 let b = a.component(.weekday, from: date)
            if arr[b - 1] {
                noti()
            }
        }
        
    }
    func testShowHour() -> Int {
        guard let hour = UserDefaults.standard.value(forKey: "hour") as? String,
            let ampm = UserDefaults.standard.value(forKey: "ampm") as? String else {
            return 07
        }
        if ampm == "AM" {
            return Int(hour)!
        }
        
        return 12 + Int(hour)!
    }
    
    func testShowMinute() -> Int {
        guard let minute = UserDefaults.standard.value(forKey: "minute") as? String else {
            return 00
        }
        return Int(minute)!
    }

}

