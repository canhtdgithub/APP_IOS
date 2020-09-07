//
//  SearchViewController.swift
//  VocabularyEnglish
//
//  Created by Cata on 8/4/20.
//  Copyright © 2020 Cata. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {

    let modelSearchVC = ModelSearchViewController.shared
    
    @IBOutlet weak var layerSearch: UIButton!
    
    @IBOutlet weak var dictionaryWeb: UIWebView!
    
    @IBOutlet weak var viewContent: UIView!
    
    @IBOutlet weak var selecteSegment: UISegmentedControl!
 
    @IBOutlet weak var alertLabel: UILabel!
    
    @IBOutlet weak var searchTextField: UITextField!
    
    @IBAction func search(_ sender: Any) {
        modelSearchVC.search(searchTextField: searchTextField,
                             alertLabel: alertLabel,
                             selecteSegment: selecteSegment,
                             dictionaryWeb: dictionaryWeb)

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
        
        viewContent.layerViews(cornerRadius: 5,
                               borderColor: UIColor.gray.cgColor,
                               borderWidth: 1)
        
        layerSearch.layerButtom(cornerRadius: layerSearch.frame.size.height / 2,
                                borderColor: UIColor.gray.cgColor,
                                borderWidth: 1)
        
    }
    
    
     

}

extension SearchViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.searchTextField.endEditing(true)
        return true
    }
}
