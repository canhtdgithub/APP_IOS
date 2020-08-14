//
//  ModelQuizGames.swift
//  VocabularyEnglish
//
//  Created by Cata on 7/24/20.
//  Copyright © 2020 Cata. All rights reserved.
//

import UIKit
import AVFoundation

class ModelQuizGames {
    static let game = ModelQuizGames()
    private init() {}
    func speechQuestion(string : String) {
        let speech = AVSpeechUtterance(string: string)
        speech.voice = AVSpeechSynthesisVoice(language: "en-US")
        speech.rate = 0.5
        
        let syn = AVSpeechSynthesizer()
        syn.speak(speech)
    }
}


