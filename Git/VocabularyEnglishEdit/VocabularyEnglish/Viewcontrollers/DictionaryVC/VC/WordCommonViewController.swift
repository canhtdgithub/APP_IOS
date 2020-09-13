//
//  WordCommonViewController.swift
//  VocabularyEnglish
//
//  Created by Cata on 9/4/20.
//  Copyright © 2020 Cata. All rights reserved.
//

import UIKit

class WordCommonViewController: UIViewController, MyViewDelegate {
    
    var word = [Word3000Common]()
    var fillDataVocab = [Word3000Common]()
    
    @IBOutlet weak var layerDeleteButton: UIButton!
    
    @IBOutlet weak var searchTextField: UITextField!
    
    @IBOutlet weak var layerDeleteButtoon: UIButton!
    
    @IBAction func deleteButton(_ sender: Any) {
        searchTextField.text = ""
        fillDataVocab.removeAll()
        table.reloadData()
        layerDeleteButton.isHidden = true
    }
    
    @IBOutlet weak var viewHome: UIView!
    
    @IBOutlet weak var table: UITableView!
    
    //MARK: - @IBACTION
    
    @IBAction func back(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    //MARK: - LIFE CYCLE VIEW
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
        tabBarController?.tabBar.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
       
    }

}
    //MARK: - EXTENSION UITABLE VIEW

extension WordCommonViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard !fillDataVocab.isEmpty else {
            return word.count
        }
        return fillDataVocab.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: WordCommonTableViewCell.identifier, for: indexPath) as! WordCommonTableViewCell
        if fillDataVocab.isEmpty {
            cell.config(value: word[indexPath.row])
        } else {
            cell.config(value: fillDataVocab[indexPath.row])
        }
        
        return cell
    }
    
    
}
    //MARK: - EXTENSION UITEXT FIELD

extension WordCommonViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let text = searchTextField.text {
            if text.count == 1 && string == "" {
                layerDeleteButton.isHidden = true
                fillDataVocab.removeAll()
                table.reloadData()
            } else {
                 fillterText(query: text + string)
                layerDeleteButton.isHidden = false
            }
           
        }

        return true
    }
}
    //MARK: - EXTENSION WORD COMMON VIEW CONTROLLER

extension WordCommonViewController {
    
    func initUI() {
        register()
        loadDataWord()
        table.rowHeight = UITableView.automaticDimension
        // Add Home View
        let view1 = Bundle.main.loadNibNamed("HomeView", owner: self, options: nil)?.first as? HomeView
        view1?.dele = self
        view1!.frame = viewHome.bounds
        viewHome.addSubview(view1!)
    }
    func register() {
        // Text Field
        searchTextField.delegate = self
        // Table View
        table.delegate = self
        table.dataSource = self
        table.register(WordCommonTableViewCell.nib(), forCellReuseIdentifier: WordCommonTableViewCell.identifier)
    }
    
    func loadDataWord() {
        let path = Bundle.main.path(forResource: "3000_vocabulary_common", ofType: "json")
        let data = try! Data(contentsOf: URL(fileURLWithPath: path!))
        
        word = try! JSONDecoder().decode([Word3000Common].self, from: data)
    }
    
    // Protocol MyViewDelegate
    func didTapButton(viewController: UIViewController) {
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    // seach text field
    func fillterText(query: String?) {
        fillDataVocab.removeAll()
        for text in word {
            if text.vocabulary.starts(with: query!.lowercased()) {
                fillDataVocab.append(text)
            }
        }
        DispatchQueue.main.async {
            self.table.reloadData()
        }
    }
}


struct Word3000Common: Codable {
    var vocabulary: String
    var IPA: String
    var type: String
    var meaning: String
}
