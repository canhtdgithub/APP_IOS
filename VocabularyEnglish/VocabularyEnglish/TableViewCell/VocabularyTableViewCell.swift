//
//  VocabularyTableViewCell.swift
//  VocabularyEnglish
//
//  Created by Cata on 7/14/20.
//  Copyright © 2020 Cata. All rights reserved.
//

import UIKit


class VocabularyTableViewCell: UITableViewCell {
    
    static var identifier = "cell"
    
    static func nib() -> UINib {
        return UINib(nibName: "VocabularyTableViewCell", bundle: .main)
    }
    
    @IBOutlet weak var showVocabulary: UILabel!
    
    @IBOutlet weak var layerSpeaker: UIButton!
    
    func config(text: String) {
        self.showVocabulary.text = text
        
    }
    
    @IBAction func speaker(_ sender: Any) {
        SIRSpeakerManager.sharedInstance.stop()
        SIRSpeakerManager.sharedInstance.speak(showVocabulary.text!)
    }
    
  
    func showSpeaker() {
        layerSpeaker.isHidden = false
    }
    
}
