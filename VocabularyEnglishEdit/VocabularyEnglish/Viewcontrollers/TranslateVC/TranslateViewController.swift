//
//  TranslateViewController.swift
//  VocabularyEnglish
//
//  Created by Cata on 9/3/20.
//  Copyright © 2020 Cata. All rights reserved.
//

import UIKit

class TranslateViewController: UIViewController {
    
    
    
    var translate = [String:String]()
    
    
    @IBOutlet weak var vocabularyLabel: UILabel!
    
    @IBOutlet weak var ipaLabel: UILabel!
    
    @IBOutlet weak var typeLabel: UILabel!
    
    @IBOutlet weak var mainMeaningLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        
        
    }
    
    func loadData() {
        vocabularyLabel.text = translate["vocabulary"]
        ipaLabel.text = translate["IPA"]
        typeLabel.text = translate["type"]
        mainMeaningLabel.text = translate["mainMeaning"]
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
