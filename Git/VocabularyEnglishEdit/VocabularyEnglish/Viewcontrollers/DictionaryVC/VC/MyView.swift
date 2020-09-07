//
//  MyView.swift
//  VocabularyEnglish
//
//  Created by Cata on 9/5/20.
//  Copyright © 2020 Cata. All rights reserved.
//

import UIKit


class MyView: UIView {

    @IBOutlet weak var layerView: UIView!
    
    @IBOutlet weak var imageVocab: UIImageView!
    
    
    @IBOutlet weak var starLayer: UIButton!
    @IBOutlet weak var vocabulary: UILabel!
    
    @IBOutlet weak var typeVocab: UILabel!
    
    @IBOutlet weak var example: UILabel!
    
    @IBAction func starButton(_ sender: UIButton) {
        
        sender.setImage(UIImage(named: "star.fill"), for: .normal)
        sender.tintColor = .yellow
    }
    
    
    @IBAction func speakUS(_ sender: UIButton) {
    
        SIRSpeakerManager.sharedInstance.stop()
        SIRSpeakerManager.sharedInstance.speakUS(vocabulary.text!)
    }
    
    @IBAction func speakUK(_ sender: UIButton) {
      
        SIRSpeakerManager.sharedInstance.stop()
        SIRSpeakerManager.sharedInstance.speakUK(vocabulary.text!)
    }
    @IBAction func checkMarkButton(_ sender: Any) {
        
        
    }
    
    
    func config(value: Word700) {
        
        let name = value.vocabulary.replacingOccurrences(of: " ", with: "_")
        let path = Bundle.main.path(forResource: name, ofType: "jpg")
        let get = try! Data(contentsOf: URL(fileURLWithPath: path!))
        imageVocab.image = UIImage(data: get)
        vocabulary.text = value.vocabulary
        typeVocab.text = value.type
        example.text = value.example
        
    }
    
}
