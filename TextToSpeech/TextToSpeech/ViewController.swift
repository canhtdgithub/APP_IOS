//
//  ViewController.swift
//  TextToSpeech
//
//  Created by Cata on 6/29/20.
//  Copyright © 2020 Cata. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let string = "Hello, World!"
        let utterance = AVSpeechUtterance(string: string)
        utterance.voice = AVSpeechSynthesisVoice(language: "en-US")

        let synth = AVSpeechSynthesizer()
        synth.speak(utterance)
    }


}

