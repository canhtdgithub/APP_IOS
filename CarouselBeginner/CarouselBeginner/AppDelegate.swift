//
//  AppDelegate.swift
//  CarouselBeginner
//
//  Created by Cata on 8/30/20.
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
        window?.rootViewController = navi
        window?.makeKeyAndVisible()
        
        return true
    }

}

