//
//  SearchViewController.swift
//  COVERT_700_TOEIC_TXT
//
//  Created by Cata on 9/1/20.
//  Copyright © 2020 Cata. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {

    @IBOutlet weak var table: UITableView!
    
    
    @IBOutlet weak var searchTextField: UITextField!
    
    
    var dataVocab = [String]()
    var filterDataVocab = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        regis()
        
    }
    
    func regis() {
        table.delegate = self
        table.dataSource = self
        searchTextField.delegate = self
        
        table.register(UINib(nibName: "SearchTableViewCell", bundle: .main), forCellReuseIdentifier: "cell")
    }
    
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filterDataVocab.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SearchTableViewCell
        cell.textLabel?.text = filterDataVocab[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = table.cellForRow(at: indexPath) as! SearchTableViewCell
       
        DispatchQueue.main.async {
            var index = 0
            for i in 0...self.dataVocab.count - 1  {
                if cell.textLabel?.text! == self.dataVocab[i] {
                    index = i
                }
            }
            let path = Bundle.main.path(forResource: "dictionary_copy", ofType: "txt")
                   let url = URL(fileURLWithPath: path!)
                   
                   let dictionary = try! String(contentsOf: url)
                   
                   let diccomponent = dictionary.components(separatedBy: .newlines)
            let dict = diccomponent[index].components(separatedBy: "\t").last!
            
            let a = TranslateViewController()
            a.text = dict.replacingOccurrences(of: "\\n", with: "\n").replacingOccurrences(of: "@", with: "")
         
            self.navigationController?.pushViewController(a, animated: true)
        }
        
            
    }
    
    
}

extension SearchViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        
        if let text = searchTextField.text {
            
            table.isHidden = false
            filterText(query: text + string)
            
           
        }
        
        
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        var index = 0
        for i in 0...dataVocab.count - 1  {
            if textField.text == dataVocab[i] {
                index = i
            }
        }
        let path = Bundle.main.path(forResource: "dictionary_copy", ofType: "txt")
               let url = URL(fileURLWithPath: path!)
               
               let dictionary = try! String(contentsOf: url)
               
               let diccomponent = dictionary.components(separatedBy: .newlines)
        let dict = diccomponent[index].components(separatedBy: "\t").last!
        
        let a = TranslateViewController()
        a.text = dict.replacingOccurrences(of: "\\n", with: "\n").replacingOccurrences(of: "@", with: "")
        self.navigationController?.pushViewController(a, animated: true)
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
//        print(filterDataVocab)
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        print("begin")
//        table.isHidden = false
        
        return true
    }
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        print("clear")
        return true
    }
    
}

