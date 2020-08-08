//
//  AppDelegate.swift
//  VocabularyEnglish
//
//  Created by Cata on 7/13/20.
//  Copyright © 2020 Cata. All rights reserved.
//

import UIKit
import Firebase

@available(iOS 11.0, *)

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        if FirebaseAuth.Auth.auth().currentUser == nil {
            login()
        } else {
            didLogin()
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

}

