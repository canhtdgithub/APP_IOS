//
//  ViewController.swift
//  PassDataBetweenViewController
//
//  Created by Cata on 6/30/20.
//  Copyright © 2020 Cata. All rights reserved.
//

import UIKit


// DÙNG PROTOCOL
class ViewController: UIViewController, SavefileProtocol {
    
    
    
    @IBOutlet weak var label: UILabel?
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    @IBAction func tap() {
        let screenTwo = ScreenTwoViewController()
        screenTwo.modalPresentationStyle = .fullScreen
        screenTwo.get = self
    
        present(screenTwo, animated: true)
    }
    func save(chuoi: String) {
        self.label?.text = chuoi
    }


}
/* DÙNG CLOSURE
class ViewController: UIViewController, SavefileProtocol {
    
    
    
    @IBOutlet weak var label: UILabel?
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    @IBAction func tap() {
        let screenTwo = ScreenTwoViewController()
        screenTwo.modalPresentationStyle = .fullScreen
            
        screenTwo.saveText = { text in
            self.label?.text = text
            
        }
   
        present(screenTwo, animated: true)
    }
    func save(chuoi: String) {
        self.label?.text = chuoi
    }


}
*/

