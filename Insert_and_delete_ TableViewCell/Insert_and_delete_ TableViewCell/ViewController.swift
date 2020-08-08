//
//  ViewController.swift
//  Insert_and_delete_ TableViewCell
//
//  Created by Cata on 6/25/20.
//  Copyright © 2020 Cata. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var myLable: UILabel?
    
    var show = [String]()
    
    @IBAction func add() {
        
        if textField.text!.isEmpty {
            myLable?.text = "text is empty. Please enter text"
//            let timer = Timer(timeInterval: 0.4, repeats: true) { _ in print("Done!") }
        } else {
        InsertCell()
        }
    }
    
    func InsertCell() {
        
           
        
        show.append(textField.text!)
        
        let index = IndexPath(row: show.count - 1, section: 0)
        table.beginUpdates()
        table.insertRows(at: [index], with: .automatic)
        table.endUpdates()

        textField.text = ""
        
        view.endEditing(true)
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        table.register(UINib(nibName: "MyTableViewCell", bundle: .main), forCellReuseIdentifier: "cell")
        table.delegate = self
        table.dataSource = self
        
    }


}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let title = show[indexPath.row]
        let cell = table.dequeueReusableCell(withIdentifier: "cell") as? MyTableViewCell
        cell!.title?.text = title
//        cell?.title?.layer.cornerRadius = 10
//        cell?.contentView.layer.borderWidth = 3
//        cell?.contentView.layer.borderColor = UIColor.blue.cgColor
        return cell!
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return show.count
    }
    
    // delete
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            show.remove(at: indexPath.row)
            table.beginUpdates()
            table.deleteRows(at: [indexPath], with:  .automatic )
            table.endUpdates()
        }
    }
    
}

