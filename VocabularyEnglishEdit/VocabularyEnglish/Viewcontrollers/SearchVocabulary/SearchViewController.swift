//
//  SearchViewController.swift
//  VocabularyEnglish
//
//  Created by Cata on 8/4/20.
//  Copyright © 2020 Cata. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {

    
    @IBOutlet weak var layerSearch: UIButton!
    
    @IBOutlet weak var dictionaryWeb: UIWebView!
    
    @IBOutlet weak var viewContent: UIView!
    
    @IBOutlet weak var selecteSegment: UISegmentedControl!
    var url: URL?
    
    @IBOutlet weak var searchTextField: UITextField!
    
    @IBAction func search(_ sender: Any) {
        searchTextField.resignFirstResponder()
        notifiHideKeyboard()
        
        switch selecteSegment.selectedSegmentIndex {
        case 0:
            url = URL(string: "https://dictionary.cambridge.org/dictionary/english/\(searchTextField.text!)")
                break
        case 1:
             url = URL(string: "https://www.ldoceonline.com/dictionary/\(searchTextField.text!)")
                break

        case 2:
             url = URL(string: "https://www.oxfordlearnersdictionaries.com/definition/english/\(searchTextField.text!)")

                break
        default:
            print("none")
        }

            dictionaryWeb.loadRequest(URLRequest(url: url ?? URL(string: "google.com")!))

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        searchTextField.text = ""
        dictionaryWeb.stopLoading()
    }
    
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.isNavigationBarHidden = true
        
        searchTextField.delegate = self
        
        viewContent.layerViews(cornerRadius: 5, borderColor: UIColor.gray.cgColor, borderWidth: 1)
        
        layerSearch.layerButtom(cornerRadius: layerSearch.frame.size.height / 2, borderColor: UIColor.gray.cgColor, borderWidth: 1)
        
    }
    
    
     func notifiHideKeyboard() {
          NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
      }
      
      @objc func keyboardWillHide(notification: NSNotification) {
        
          
      }


}

extension SearchViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.searchTextField.endEditing(true)
        return true
    }
}
