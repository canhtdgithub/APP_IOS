//
//  AppDelegate.swift
//  VocabularyEnglish
//
//  Created by Cata on 7/13/20.
//  Copyright © 2020 Cata. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        
        let viewController = ViewController()
        let navi = UINavigationController(rootViewController: viewController)
            navi.tabBarItem.image = UIImage(named: "creat_vocabulary")
        
        let gamesController = GamesViewController()
        let navi1 = UINavigationController(rootViewController: gamesController)
            navi1.tabBarItem.image = UIImage(named: "game")
        
        let settingController = SettingViewController()
        let navi2 = UINavigationController(rootViewController: settingController)
            navi2.tabBarItem.image = UIImage(named: "setting")
        
        UITabBar.appearance().tintColor = .red
        UITabBar.appearance().barTintColor = .black

                   
        let tabbarViewController = UITabBarController()
        tabbarViewController.viewControllers = [navi, navi1, navi2]
        
        
        
//        tabbarViewController.tabBar.items?[0].title = "Vocabulary"
//        tabbarViewController.tabBar.items?[0].image = UIImage(named: "creat_vocabulary")
//
//
//        tabbarViewController.tabBar.items?[1].title = "Games"
//        tabbarViewController.tabBar.items?[1].image = UIImage(named: "game")
//
//        tabbarViewController.tabBar.items?[2].title = "Setting"
//        tabbarViewController.tabBar.items?[2].image = UIImage(named: "setting")
//
//        tabbarViewController.tabBarItem.image = UIImage(named: "creat_vocabulary")
                    
        window?.rootViewController = tabbarViewController
        window?.makeKeyAndVisible()
        
        return true
    }

}

