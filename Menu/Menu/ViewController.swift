//
//  ViewController.swift
//  Menu
//
//  Created by Cata on 6/30/20.
//  Copyright © 2020 Cata. All rights reserved.
//

// DÙNG THƯ VIỆN ĐỂ IMPORT SIDEMENU

//import UIKit
//import SideMenu
//
//class ViewController: UIViewController {
//
//    var menu: SideMenuNavigationController?
//
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        menu = SideMenuNavigationController(rootViewController: MenuListController())
//        menu?.leftSide = true
//        menu?.setNavigationBarHidden(true, animated: true)
//        SideMenuManager.default.leftMenuNavigationController = menu
//        SideMenuManager.default.addPanGestureToPresent(toView: self.view)
//    }
//
//    @IBAction func tap() {
//        present(menu!, animated: true, completion: nil)
//    }
//
//
//}
//
//class MenuListController: UITableViewController {
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        self.view.backgroundColor = .black
//    }
//    var items = ["First","Second","Third","Four"]
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        items.count
//    }
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = UITableViewCell()
//        cell.backgroundColor = .black
//        cell.textLabel?.textColor = .white
//        cell.textLabel?.text = items[indexPath.row]
//        return cell
//    }
//}


// DÙNG ANIMATION

import UIKit

class ViewController: UIViewController {
    
    
    
    @IBOutlet weak var trailing: NSLayoutConstraint!
    
    @IBOutlet weak var leading: NSLayoutConstraint!
    
    var click = false
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func tap() {
        if click == false {
            leading.constant = 150
            trailing.constant = -150
            click = true
        } else {
            leading.constant = 0
            trailing.constant = 0
            click = false
        }
    }
}
