//
//  ViewController.swift
//  SlideTabBarDemo
//
//  Created by Cata on 9/13/20.
//  Copyright © 2020 Cata. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class ViewController: ButtonBarPagerTabStripViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configureButtonBar()
//        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        
        let mot = MotViewController()
        
        let hai = HaiViewController()
        return [mot, hai]
    }
     override func didReceiveMemoryWarning() {
           super.didReceiveMemoryWarning()
       }
       
       // MARK: - Configuration
       func configureButtonBar() {
           settings.style.buttonBarBackgroundColor = .white
           settings.style.buttonBarItemBackgroundColor = .white

           settings.style.buttonBarItemFont = UIFont(name: "Helvetica", size: 16.0)!
           settings.style.buttonBarItemTitleColor = .gray
           
           settings.style.buttonBarMinimumLineSpacing = 0
           settings.style.buttonBarItemsShouldFillAvailableWidth = true
           settings.style.buttonBarLeftContentInset = 0
           settings.style.buttonBarRightContentInset = 0

           settings.style.selectedBarHeight = 3.0
           settings.style.selectedBarBackgroundColor = .orange
           
           // Changing item text color on swipe
           changeCurrentIndexProgressive = { [weak self] (oldCell: ButtonBarViewCell?, newCell: ButtonBarViewCell?, progressPercentage: CGFloat, changeCurrentIndex: Bool, animated: Bool) -> Void in
               guard changeCurrentIndex == true else { return }
               oldCell?.label.textColor = .gray
               newCell?.label.textColor = .orange
           }
       }


}

