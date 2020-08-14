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
import SystemConfiguration

//MARK: - PROPERTIES
// declare microphone
var urlPathImage: URL?
var cellcount = 0
let voice = VoiceOverlayController()
let realm = try! Realm()
var vocabularys: Results<Vocab>?

var list = [ListVocab]()
//let value = Vocab()
let fileManager = FileManager.default


// MARK: - CLASS

class Vocab: Object {
    @objc dynamic var vocabulary = ""
    @objc dynamic var descripVocab = ""
    
}

class ModelViewController {
    static let shared = ModelViewController()
    
    private init() {}
    func insertVocab(newVocab: UITextField, tableView: UITableView) {
        if newVocab.text!.isEmpty {
        } else {
            let value = Vocab()
            value.vocabulary = newVocab.text!.lowercased()
            value.descripVocab = ""
            realm.beginWrite()
            realm.add(value)
            try! realm.commitWrite()
            DispatchQueue.main.async {
                tableView.reloadData()
            }
            
            newVocab.text = ""
        }
    }
    
    func isConnectedToNetwork() -> Bool {

            var zeroAddress = sockaddr_in(sin_len: 0, sin_family: 0, sin_port: 0, sin_addr: in_addr(s_addr: 0), sin_zero: (0, 0, 0, 0, 0, 0, 0, 0))
        
            zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        
            zeroAddress.sin_family = sa_family_t(AF_INET)
        
            let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
        
                $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
        
                    SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
        
                }
        
            }
        
            var flags = SCNetworkReachabilityFlags()
        
            if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
        
                return false
        
            }
        
            let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        
            let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        
            return (isReachable && !needsConnection)
        
        }
    
}

class ModelExetendViewController {
    
     private init() {}
    static var shared = ModelExetendViewController()
    func testShowImage(label: UILabel, image: UIImageView) {
        let PathWithFolderName = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent("FolderName")
        
        print("Document Directory Folder Path :- ",PathWithFolderName)
        
        if !fileManager.fileExists(atPath: PathWithFolderName)
        {
            try! fileManager.createDirectory(atPath: PathWithFolderName, withIntermediateDirectories: true, attributes: nil)
        }
        
        let url = URL(string: PathWithFolderName)
        urlPathImage = url
        let imagePath = url?.appendingPathComponent("\(label.text!).png").absoluteString
        
        if fileManager.fileExists(atPath: imagePath!) {
            image.image = UIImage(contentsOfFile: imagePath!)
            
        }
        
        
    }
    
    func deletePatchImage(deleteVocab: String) {
        
        guard let imagePath = urlPathImage?.appendingPathComponent("\(deleteVocab).png").absoluteString else {
            return
        }
        guard fileManager.fileExists(atPath: imagePath) else {
            return
        }
        try? fileManager.removeItem(atPath: imagePath)
//        if fileManager.fileExists(atPath: imagePath!) {
//            try? fileManager.removeItem(atPath: imagePath!)
//        } else {
//            print("file not exist")
//        }
    
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

struct ListVocab {
    var vocab: String
    var define: String
   
}




