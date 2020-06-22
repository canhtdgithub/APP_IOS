//
//  ViewController.swift
//  CreatUItableViewCell
//
//  Created by Cata on 6/21/20.
//  Copyright © 2020 Cata. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var table: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.table.delegate = self
        self.table.dataSource = self
        // Do any additional setup after loading the view.
    }


}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 5
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 100/5
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = String(indexPath.row + 1)
        if (indexPath.row + 1) % 5 == 0 {
            
            cell.backgroundColor = .red
        } else {
       
        cell.backgroundColor = .white
        }
        return cell
    }
    
    
}
