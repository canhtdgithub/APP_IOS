//
//  ViewController.swift
//  VocabularyEnglish
//
//  Created by Cata on 7/13/20.
//  Copyright © 2020 Cata. All rights reserved.
//

import UIKit
import Firebase





class ViewController: UIViewController {
    
    //MARK: - @IBOUTLET
    
    @IBOutlet weak var viewLayer: UIView!
    
    @IBOutlet weak var textVocab: UITextField!
    
    //auto layout when keyboard hide and show
    @IBOutlet weak var tableContraint: NSLayoutConstraint!
    
    
    @IBOutlet weak var layerButtom: UIButton!
    
    @IBOutlet weak var table: UITableView!
    
    //MARK: - @IBACTION
    
    
    @IBAction func insert(_ sender: Any) {
        guard let myEmail = UserDefaults.standard.value(forKey: "email") as? String else {
            return
        }
        DatabaseManager.shared.addVocab(email: myEmail, text: textVocab.text!)
        ModelViewController.shared.insertVocab(newVocab: textVocab, tableView: table)

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
        // layer View
        layerView()
       
        // layer Buttom
//        layerAdd()
        
        let origImage = UIImage(named: "plus")
        let tintedImage = origImage?.withRenderingMode(.alwaysTemplate)
        layerButtom.setImage(tintedImage, for: .normal)
        layerButtom.tintColor = .orange
        
        
        vocabularys = realm.objects(Vocab.self)
       
        
        
        listen()
        
        
    }
    //MARK: - FIREBASE
    func listen() {
        guard let email = UserDefaults.standard.value(forKey: "email") as? String else {
            return
        }
        
        DatabaseManager.shared.insertListVocab(for: email, completion: { result in
            switch result {
            case .success(let listvocab):
                
                list = listvocab
                
                DispatchQueue.main.async {
                    self.table.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        })
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
    
    func layerView() {
        viewLayer.layer.cornerRadius = 19
        viewLayer.layer.borderWidth = 1
        viewLayer.layer.borderColor = UIColor.black.cgColor
    }
    
    func layerAdd() {
        layerButtom.layer.cornerRadius = 19
        layerButtom.layer.borderWidth = 0.5
        layerButtom.layer.borderColor = UIColor.black.cgColor
        
    }
    
    func startMicrophone() {
        voice.start(on: self,
                    textHandler: { (text, finish, nil) in
                        if finish {
                            print("thất bại")
                        } else {
                            print(text)
                                self.textVocab.text! = text
                        }
        }, errorHandler: {error in
            
        })
        
    }
}


//MARK: - UITABLEVIEW

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if ModelViewController.shared.isConnectedToNetwork() {
            return list.count
        }
        return vocabularys?.count ?? 0
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: VocabularyTableViewCell.identifier, for: indexPath) as! VocabularyTableViewCell
        if ModelViewController.shared.isConnectedToNetwork() {
            cell.config(text: list[indexPath.row].vocab)
        } else {
            cell.config(text: vocabularys![indexPath.row].vocabulary)
        }
        
       
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
                print(indexPath.row)
            
            ModelExetendViewController.shared.deletePatchImage(deleteVocab: vocabularys![indexPath.row].vocabulary)

            realm.beginWrite()
            realm.delete(vocabularys![indexPath.row])
            try! realm.commitWrite()
            DispatchQueue.main.async {
                self.table.reloadData()
            }
            
            let index = indexPath.row
            DatabaseManager.shared.deleteVocabulary(indexvocab: index) { (success) in
//                if success {
//                    self.table.reloadData()
//                    print("detlete success")
//                }
            }
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





