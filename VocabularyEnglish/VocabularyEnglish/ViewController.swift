//
//  ViewController.swift
//  VocabularyEnglish
//
//  Created by Cata on 7/13/20.
//  Copyright © 2020 Cata. All rights reserved.
//

import UIKit



class ViewController: UIViewController {
    
    //MARK: - @IBOUTLET
    
    @IBOutlet weak var textVocab: UITextField!
    
    //auto layout when keyboard hide and show
    @IBOutlet weak var tableContraint: NSLayoutConstraint!
    
    
    @IBOutlet weak var layerButtom: UIButton!
    
    @IBOutlet weak var table: UITableView!
    
    //MARK: - @IBACTION
    
    
    @IBAction func insert(_ sender: Any) {
        
        ModelViewController.share.insertVocab(newVocab: textVocab, tableView: table)
    }
    
    
    @IBAction func microphone(_ sender: Any) {
        startMicrophone()
        
    }
    
    //MARK: - VIEW LIFE CYCLE
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Any code you put in here will be called when the keyboard is about to display
        notifiShowKeyboard()
        // Any code you put in here will be called when the keyboard is about to hide
        notifiHideKeyboard()
        // set title for view controller
        navigationItem.title = "News Vocabulary"
        
        // delegate TextFlied
        textVocab.delegate = self
        
        // delegate and datasource tableview
        registTable(tableView: table)
        // layer TextField
        layerTextField()
        // layer Buttom
        layerAdd()
        
        vocabularys = realm.objects(Vocab.self)
        
        
    }
    
    //MARK: - METHOD
    
    func registTable(tableView: UITableView) {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(VocabularyTableViewCell.nib(), forCellReuseIdentifier: VocabularyTableViewCell.identifier)
        
    }
    func notifiShowKeyboard() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        
        if let userInfo = notification.userInfo as? Dictionary<String, AnyObject> {
            let frame = userInfo[UIResponder.keyboardFrameEndUserInfoKey]
            let keyBoardRect = frame?.cgRectValue
            if let keyBoardHeight = keyBoardRect?.height {
                self.tableContraint.constant = keyBoardHeight
            }
        }
        
    }
    
    func notifiHideKeyboard() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        self.tableContraint.constant = 0
    }
    
    
    func layerTextField() {
        textVocab.layer.cornerRadius = 19
        textVocab.layer.borderWidth = 1
        textVocab.layer.borderColor = UIColor.black.cgColor
    }
    
    func layerAdd() {
        layerButtom.layer.cornerRadius = 19
        layerButtom.layer.borderWidth = 0.5
        layerButtom.layer.borderColor = UIColor.black.cgColor
    }
    
    // Fix function này ... Chưa sửa được
    func startMicrophone() {
        voice.start(on: self,
                    textHandler: { (text, finish, nil) in
                        if finish {
                            print("thất bại")
                        } else {
                            print(text)
                            //                            self.textVocab.text! = text
                        }
        }, errorHandler: {error in
            
        })
        
    }
    
}

//MARK: - UITABLEVIEW

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vocabularys?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: VocabularyTableViewCell.identifier, for: indexPath) as! VocabularyTableViewCell
        
        cell.config(text: vocabularys![indexPath.row].vocabulary)
       
        cell.showSpeaker()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let extend = ExetendViewController()
     
        cellcount = indexPath.row
       
        self.present(extend, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            realm.beginWrite()
            realm.delete(vocabularys![indexPath.row])
            try! realm.commitWrite()
            table.reloadData()
        }
    }
    
}

//MARK: - UITEXTFIELDDELEGATE

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.textVocab.endEditing(true)
        return true
    }
}





