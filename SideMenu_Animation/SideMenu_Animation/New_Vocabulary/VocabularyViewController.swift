//
//  VocabularyViewController.swift
//  SideMenu_Animation
//
//  Created by Cata on 7/1/20.
//  Copyright © 2020 Cata. All rights reserved.
//

import UIKit


class VocabularyViewController: ViewController {
 // MARK: - DECLARE
    
    //    let userDefault = UserDefaults.standard
    
    
    @IBAction func editButtom(_ sender: Any) {
        if table.isEditing {
            table.isEditing = false
            
        } else {
            table.isEditing = true
        }
    }
    
    
    @IBOutlet weak var table: UITableView!
    
    @IBOutlet weak var newVocab: UITextField!
    
    
    @IBOutlet weak var creatLayout: UIButton!
    
    var vocabulary = [String]()
    
    
    @IBAction func creat() {
        
        
        inserVocabulary()
        
    }
    
    func layer() {
        // Buttom
        creatLayout.layer.cornerRadius = 10
        creatLayout.layer.borderWidth = 2
        creatLayout.layer.borderColor = UIColor.black.cgColor
        // TextField
        newVocab.layer.cornerRadius = 10
        newVocab.layer.borderWidth = 2
        newVocab.layer.borderColor = UIColor.gray.cgColor
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        table.register(UINib(nibName: "VocabularyTableViewCell", bundle: .main), forCellReuseIdentifier: "vocab")
        table.delegate = self
        table.dataSource = self
        layer()
        if let x = UserDefaults.standard.object(forKey: "SAVEFILE") as? [String] {
            print(x)
            vocabulary = x
            table.reloadData()
        }
        newVocab.becomeFirstResponder()
       
    }
    
   // MARK: - FUNC INSERT VOCABULARY
    
    func inserVocabulary() {
        let value = newVocab.text
        if newVocab.text!.isEmpty {
            
        } else {
        vocabulary.append(value!)
            UserDefaults.standard.set(vocabulary, forKey: "SAVEFILE")
        let index = IndexPath(item: vocabulary.count - 1, section: 0)
            
        table.beginUpdates()
        table.insertRows(at: [index], with: .automatic)
        table.endUpdates()
            
        table.reloadData()
        newVocab.text = ""
        }
    }

}


// MARK: - EXTENSION

extension VocabularyViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vocabulary.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = table.dequeueReusableCell(withIdentifier: "vocab", for: indexPath) as! VocabularyTableViewCell
        cell.vocabularyLabel?.text = vocabulary[indexPath.row]
        cell.showSpeaker()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let change = vocabulary[sourceIndexPath.item]
        vocabulary.remove(at: sourceIndexPath.item)
        
        vocabulary.insert(change, at: destinationIndexPath.item)
        table.reloadData()
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        vocabulary.remove(at: indexPath.row)
//        UserDefaults.standard.removeObject(forKey: "SAVEFILE")
//
        table.beginUpdates()
        table.deleteRows(at: [indexPath], with: .automatic)
        table.endUpdates()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let showphoto = PhotosViewController()
        self.present(showphoto, animated: true, completion: nil)
    }
    
    
    
}
