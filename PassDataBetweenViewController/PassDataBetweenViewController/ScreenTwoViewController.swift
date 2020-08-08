//
//  ScreenTwoViewController.swift
//  PassDataBetweenViewController
//
//  Created by Cata on 6/30/20.
//  Copyright © 2020 Cata. All rights reserved.
//

import UIKit

// DÙNG PROTOCOL
protocol SavefileProtocol {
    func save(chuoi: String)
}

class ScreenTwoViewController: UIViewController {
    
    var get: SavefileProtocol!
    

    @IBOutlet weak var textField: UITextField!
     
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .green
        textField.becomeFirstResponder()
        
        
    }

    @IBAction func Save() {
        get.save(chuoi: textField.text!)
        
        dismiss(animated: true, completion: nil)
    }
   
}
/*  😜 DÙNG CLOSURE 😜
class ScreenTwoViewController: UIViewController {
    

    @IBOutlet weak var textField: UITextField!
    
    var saveText: ((String?) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .green
        textField.becomeFirstResponder()
        
        
    }

    @IBAction func Save() {
        saveText?(textField.text)
        
        dismiss(animated: true, completion: nil)
    }
   
}
*/
