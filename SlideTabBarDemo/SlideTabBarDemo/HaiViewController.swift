//
//  HaiViewController.swift
//  SlideTabBarDemo
//
//  Created by Cata on 9/13/20.
//  Copyright © 2020 Cata. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class HaiViewController: UIViewController, IndicatorInfoProvider {

    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "two")
    }
    override func viewDidLoad() {
        super.viewDidLoad()

      
    }



}
