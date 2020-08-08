//
//  ViewController.swift
//  SideMenu_Animation
//
//  Created by Cata on 7/1/20.
//  Copyright © 2020 Cata. All rights reserved.
//

import UIKit
import SideMenu

class ViewController: UIViewController {

    var menu: SideMenuNavigationController?
    override func viewDidLoad() {
        super.viewDidLoad()
        menu = SideMenuNavigationController(rootViewController: MenuList())
        menu?.leftSide = true
        menu?.setNavigationBarHidden(true, animated: true)
    }

    @IBAction func tap(_ sender: Any) {
        present(menu!, animated: true, completion: nil)
    }
    
}

class MenuList: UITableViewController {
    
    var list = ["first","second","third","four","five","six"]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    override func viewWillAppear(_ animated: Bool) {
        animation()
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = list[indexPath.row]
        cell.backgroundColor = .black
        tableView.backgroundColor = .black
        cell.textLabel?.textColor = .white
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let voca = VocabularyViewController()
        self.navigationController?.pushViewController(voca, animated: true)
    }
    // MARK: - ANIMATION
    
    func animation() {
        tableView.reloadData()
        let cells = tableView.visibleCells
        let height = tableView.bounds.size.height
        for cell in cells {
            cell.transform = CGAffineTransform(translationX: 0, y: height)
        }
        var delayCount = 0
        for cell in cells {
            UIView.animate(withDuration: 2, delay: Double(delayCount) * 0.05, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseOut, animations: {
                cell.transform = CGAffineTransform.identity
            }, completion: nil)
            delayCount += 1
        }
    }
}
