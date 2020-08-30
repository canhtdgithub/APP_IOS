//
//  ViewController.swift
//  READ_FILE_JSON
//
//  Created by Cata on 8/30/20.
//  Copyright © 2020 Cata. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var table: UITableView!
    
    var vocab: [VocabularyManager]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        regist()
//        getData()
        get()
    }
    
    func regist() {
        table.rowHeight = UITableView.automaticDimension
        table.register(UINib(nibName: "MyTableViewCell", bundle: .main), forCellReuseIdentifier: "cell")
        table.delegate = self
        table.dataSource = self
    }
    
    func getData() {
        let path = Bundle.main.path(forResource: "700_TOEIC", ofType: "json")
        let url = URL(fileURLWithPath: path!)
        
        let dataVocab = try! Data(contentsOf: url)
        
        let jsonResult = try! JSONSerialization.jsonObject(with: dataVocab, options: .mutableLeaves)
        guard let jsonRe = jsonResult as? [[String:String]] else {
            return
        }
        print(jsonRe)
        
    }
    
    func get() {
        let jsonURL = Bundle(for: type(of: self)).path(forResource: "700_TOEIC", ofType: "json")
        guard let jsonString = try? String(contentsOf: URL(fileURLWithPath: jsonURL!), encoding: .utf8) else {
            return
        }
        
        vocab = try! JSONDecoder().decode([VocabularyManager].self, from: Data(jsonString.utf8))
        
    }
    


}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vocab.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MyTableViewCell
        cell.config(value: vocab[indexPath.row])
        return cell
    }
    
    
}

struct VocabularyManager: Codable {
    var vocabulary: String
    var type: String
    var example: String
}

