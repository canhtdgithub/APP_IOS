//
//  VocabularyTableViewCell.swift
//  SideMenu_Animation
//
//  Created by Cata on 7/1/20.
//  Copyright © 2020 Cata. All rights reserved.
//

import UIKit
// import  modul text string to speech
import AVFoundation

class VocabularyTableViewCell: UITableViewCell {
    
    @IBOutlet weak var vocabularyLabel: UILabel!
    
    @IBOutlet weak var layerSpeaker: UIButton!
    
    
    @IBAction func speakerButtom(_ sender: Any) {
        let speech = AVSpeechUtterance(string: vocabularyLabel.text!)
        speech.voice = AVSpeechSynthesisVoice(language: "en-US")
        speech.rate = 0.5
        
        let synthesizer = AVSpeechSynthesizer()
        synthesizer.speak(speech)
    }
    
    func showSpeaker() {
        layerSpeaker.isHidden = false
    
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
