//
//  ViewController.swift
//  EditDatabase_Realm
//
//  Created by Cata on 7/4/20.
//  Copyright © 2020 Cata. All rights reserved.
//

import UIKit
import RealmSwift

class ViewController: UIViewController {
// MARK: - DECLARE
    
    var names: Results<Name>?

    
    let realm = try! Realm()
    
    @IBOutlet weak var table: UITableView!
    
    @IBOutlet weak var enterTextField: UITextField!
    
    
    @IBAction func addButtom(_ sender: Any) {
        add()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table.delegate = self
        table.dataSource = self
        table.register(UINib(nibName: "MyTableViewCell", bundle: .main), forCellReuseIdentifier: "cell")

        names = realm.objects(Name.self)
        

    }
    // MARK: - FUNCTION
   
    
    func add() {
        let value = Name()
        if enterTextField.text!.isEmpty {
            
        } else {
        value.name = enterTextField.text!
        
        realm.beginWrite()
        realm.add(value)
        try! realm.commitWrite()
        
//        try! realm.write {
//            realm.add(value)
//        }
        table.reloadData()
        enterTextField.text = ""
        }
    }


}

// MARK: - EXTENSION
extension ViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return names?.count ?? 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = names?[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {

        realm.beginWrite()
        realm.delete(names![indexPath.row])
        try! realm.commitWrite()
        
        table.reloadData()
    }

}

// MARK: - CREAT REALM CLASS
class Name: Object {
    @objc dynamic var name = ""
}
