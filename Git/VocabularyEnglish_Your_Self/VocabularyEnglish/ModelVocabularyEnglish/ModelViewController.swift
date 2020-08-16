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

var cellcount = 0

let realm = try! Realm()
var vocabularys: Results<Vocab>?

var list = [ListVocab]()



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
    func startMicrophone(viewController: UIViewController, showText: UITextField ) {
        let voice = VoiceOverlayController()
          voice.start(on: viewController,
                      textHandler: { (text, finish, nil) in
                          if finish {
                              print("fail voice")
                          } else {
                              print(text)
                                  showText.text! = text
                          }
          }, errorHandler: {error in
              
          })
          
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



class NotificationKeyboard {
    
    var edgeContrains: NSLayoutConstraint!
    
    init(edgeContrains: NSLayoutConstraint) {
        self.edgeContrains = edgeContrains
    }
    
    func notifiShowKeyboard() {
           NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
       }
       
       @objc func keyboardWillShow(notification: NSNotification) {
           
           if let userInfo = notification.userInfo as? Dictionary<String, AnyObject> {
               let frame = userInfo[UIResponder.keyboardFrameEndUserInfoKey]
               let keyBoardRect = frame?.cgRectValue
               if let keyBoardHeight = keyBoardRect?.height {
                   self.edgeContrains.constant = keyBoardHeight
               }
           }
           
       }
       
       func notifiHideKeyboard() {
           NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
       }
       
       @objc func keyboardWillHide(notification: NSNotification) {
           self.edgeContrains.constant = 0
           
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




