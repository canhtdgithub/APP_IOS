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

extension UIButton {
    func tapAnimation() {
        let tap = CASpringAnimation(keyPath: "opacity")
        tap.damping = 0.5
        tap.fromValue = 1
        tap.toValue = 0.7
        tap.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        tap.autoreverses = true
        tap.repeatCount = 1
        layer.add(tap, forKey: nil)
    }
    
    func layerButtom(cornerRadius: CGFloat?, borderColor: CGColor, borderWidth: CGFloat? ) {
        layer.cornerRadius = cornerRadius ?? 0
        layer.borderColor = borderColor
        layer.borderWidth = borderWidth ?? 0
    }
    
}
extension UICollectionViewCell {
    func tapAnimation() {
        let tap = CASpringAnimation(keyPath: "opacity")
        tap.damping = 5
        tap.fromValue = 1
        tap.toValue = 0.7
        tap.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        tap.autoreverses = true
        tap.repeatCount = 1
        contentView.layer.add(tap, forKey: nil)
    }
    
    func layerCollectionViewCell(cornerRadius: CGFloat?, borderColor: CGColor, borderWidth: CGFloat? ) {
        layer.cornerRadius = cornerRadius ?? 0
        layer.borderColor = borderColor
        layer.borderWidth = borderWidth ?? 0
    }

}
