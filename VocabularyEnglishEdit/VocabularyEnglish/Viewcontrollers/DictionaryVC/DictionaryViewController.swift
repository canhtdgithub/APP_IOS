//
//  DictionaryViewController.swift
//  VocabularyEnglish
//
//  Created by Cata on 9/3/20.
//  Copyright © 2020 Cata. All rights reserved.
//

import UIKit

class DictionaryViewController: UIViewController {

    @IBOutlet weak var table: UITableView!
    
    
    @IBOutlet weak var searchTextField: UITextField!
    
    
    var dataVocab = [String]()
    var filterDataVocab = [String]()
    var diction = [DictionaryCommon]()
    var diction1 = [[String:String]]()
    var vocablary: DictionaryCommon!
    var vocabulary1 = [String:String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        regis()
        loadDataVocab()
        loadDiction()
    }
    
    func regis() {
        table.delegate = self
        table.dataSource = self
        searchTextField.delegate = self
        
        table.register(UINib(nibName: "DictionaryTableViewCell", bundle: .main), forCellReuseIdentifier: "dictioncell")
    }
    
    func loadDataVocab() {
        let path = Bundle.main.path(forResource: "vocab_dictionary", ofType: "txt")
        let text = try! String(contentsOf: URL(fileURLWithPath: path!))
        
        let data = text.components(separatedBy: .newlines)
        dataVocab = data
    }
    func loadDiction() {
        let path = Bundle.main.path(forResource: "dictionary", ofType: "json")
        
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path!))
            diction1 = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves) as! [[String:String]]
            
//            diction = try JSONDecoder().decode([DictionaryCommon].self, from: data)
        } catch {
            print("error")
        }
        
        
    }
    
    
    func passData(cell: UITableViewCell) {
        var index = 0
        for i in 0...self.dataVocab.count - 1  {
            if cell.textLabel?.text! == self.dataVocab[i] {
                index = i
            }
        }
        
        vocabulary1 = diction1[index]
//        vocablary = diction[index]
    }
    
    
    
}

extension DictionaryViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filterDataVocab.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: "dictioncell", for: indexPath) as! DictionaryTableViewCell
        cell.textLabel?.text = filterDataVocab[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = table.cellForRow(at: indexPath) as! DictionaryTableViewCell
            
        cell.selectionStyle = .none
            passData(cell: cell)
            
            let transVC = TranslateViewController()
            transVC.translate = vocabulary1
            self.navigationController?.pushViewController(transVC, animated: true)
        
        
            
    }
    
    
}

extension DictionaryViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

        if let text = searchTextField.text {
            
            table.isHidden = false
            filterText(query: text + string)
           
        }
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        let trans = TranslateViewController()
        trans.translate = vocabulary1
        self.navigationController?.pushViewController(trans, animated: true)
        textField.resignFirstResponder()
        return true
    }
    
    func filterText (query: String?) {
        filterDataVocab.removeAll()
       
        for text in dataVocab {
            if text.starts(with: query!.lowercased()) {
                filterDataVocab.append(text)
                
            }
        }
        table.reloadData()

    }
    
   
    
}

struct DictionaryCommon: Codable {
    var vocabulary: String
    var ipa: String
    var type: String
    var faculty: String
    var mainMeaning: String
}

