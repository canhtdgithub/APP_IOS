//
//  ModelViewController.swift
//  VocabularyEnglish
//
//  Created by Cata on 7/23/20.
//  Copyright © 2020 Cata. All rights reserved.
//

import Foundation
import RealmSwift
import InstantSearchVoiceOverlay
import AVFoundation

//MARK: - PROPERTIES
// declare microphone
var cellcount = 0
let voice = VoiceOverlayController()
let realm = try! Realm()
var vocabularys: Results<Vocab>?
//let value = Vocab()
let fileManager = FileManager.default


// MARK: - CLASS

class Vocab: Object {
    @objc dynamic var vocabulary = ""
    @objc dynamic var descripVocab = ""
    
}

class ModelViewController {
    static let share = ModelViewController()
    
    private init() {}
    func insertVocab(newVocab: UITextField, tableView: UITableView) {
        if newVocab.text!.isEmpty {
        } else {
            let value = Vocab()
            value.vocabulary = newVocab.text!
            value.descripVocab = ""
            realm.beginWrite()
            realm.add(value)
            try! realm.commitWrite()
            tableView.reloadData()
            newVocab.text = ""
        }
    }
    
}

class ModelExetendViewController {
    
     private init() {}
    static var insert = ModelExetendViewController()
    func testShowImage(label: UILabel, image: UIImageView, buttom: UIButton) {
        let PathWithFolderName = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent("FolderName")
        
        print("Document Directory Folder Path :- ",PathWithFolderName)
        
        if !fileManager.fileExists(atPath: PathWithFolderName)
        {
            try! fileManager.createDirectory(atPath: PathWithFolderName, withIntermediateDirectories: true, attributes: nil)
        }
        
        let url = URL(string: PathWithFolderName)
        let imagePath = url?.appendingPathComponent("\(label.text!).png").absoluteString
        
        
        
        if fileManager.fileExists(atPath: imagePath!) {
            image.image = UIImage(contentsOfFile: imagePath!)
            buttom.isHidden = true
        }
        
        
    }
}


class SIRSpeakerManager: NSObject {
    
    static let sharedInstance = SIRSpeakerManager()
    
    let synth = AVSpeechSynthesizer()
    
    override init() {
        super.init()
        synth.delegate = self
    }
    
    func speak(_ announcement: String) {
        prepareAudioSession()
        let utterance = AVSpeechUtterance(string: announcement.lowercased())
        utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
        synth.speak(utterance)
    }
    
    private func prepareAudioSession() {
        do {
            try AVAudioSession.sharedInstance().setCategory(.ambient, options: .mixWithOthers)
        } catch {
            print(error)
        }
        
        do {
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            print(error)
        }
    }
    
    func stop() {
        if synth.isSpeaking {
            synth.stopSpeaking(at: .immediate)
        }
    }
}

extension SIRSpeakerManager: AVSpeechSynthesizerDelegate {
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didStart utterance: AVSpeechUtterance) {
        print("Speaker class started")
    }
    
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
        print("Speaker class finished")
    }
}







