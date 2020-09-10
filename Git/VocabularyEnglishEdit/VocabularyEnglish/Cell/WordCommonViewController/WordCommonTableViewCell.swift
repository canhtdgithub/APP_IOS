//
//  WordCommonTableViewCell.swift
//  VocabularyEnglish
//
//  Created by Cata on 9/5/20.
//  Copyright © 2020 Cata. All rights reserved.
//

import UIKit

class WordCommonTableViewCell: UITableViewCell {

    @IBOutlet weak var favouriteLayer: UIButton!
    
    static var identifier = "wordcell"
    static func nib() -> UINib {
        return UINib(nibName: "WordCommonTableViewCell", bundle: nil)
    }
    
    @IBOutlet weak var vocabLabel: UILabel!
    
    @IBOutlet weak var ipaLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var meaningLabel: UILabel!
    
    
    
    @IBAction func speaker(_ sender: Any) {
        
        SIRSpeakerManager.sharedInstance.stop()
        SIRSpeakerManager.sharedInstance.speakUS(vocabLabel.text!)
        
    }
    var selec = false
    @IBAction func favourite(_ sender: UIButton) {
        if !selec {
            selec = true
            sender.tintColor = .red
        } else {
            sender.tintColor = .blue
        }
        
    }
    
    func config(value: Word3000Common) {
        vocabLabel.text = value.vocabulary
        ipaLabel.text = value.IPA
        typeLabel.text = value.type
        meaningLabel.text = value.meaning
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
