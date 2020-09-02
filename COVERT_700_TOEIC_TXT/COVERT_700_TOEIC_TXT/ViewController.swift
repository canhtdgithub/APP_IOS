//
//  ViewController.swift
//  COVERT_700_TOEIC_TXT
//
//  Created by Cata on 8/29/20.
//  Copyright © 2020 Cata. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var thuLabel: UILabel!
    
    @IBAction func convert(_ sender: Any) {
        let path = Bundle.main.path(forResource: "700_TOEIC2", ofType: "txt")
        let url = URL(fileURLWithPath: path!)
        let text = try! String(contentsOf: url, encoding: .utf8)
        
        let component = text.components(separatedBy: .newlines)
        var ojectNew = [String]()
//        print(component)
        for i in 0...component.count - 1 {
            ojectNew.append(component[i].trimmingCharacters(in: .init(charactersIn: " 0 1 2 3 4 5 6 7 8 9")))
        }
//        print(ojectNew)
        var dictionArray = [NSMutableDictionary]()
        
       
        for i in 0...ojectNew.count - 1 {
            let diction = NSMutableDictionary()
            
            let vocabAndDefine = ojectNew[i].components(separatedBy: "\t")
            for i in 0...6 {
                if i == 6 {
                    diction.setValue(vocabAndDefine[i], forKey: "vocabulary")
                } else if i == 5 {
                    diction.setValue(vocabAndDefine[i], forKey: "type")
                } else if i == 4 {
                    diction.setValue(vocabAndDefine[i], forKey: "example")
                }
            }
//            let vocabAndDefine = ojectNew[i].components(separatedBy: ":").last!
//
//            let vocab = vocabAndDefine.components(separatedBy: "\t").last!
//            print(vocab)
//            diction.setValue(vocab, forKey: "vocabulary")
//
//            var defi = ojectNew[i].components(separatedBy: ":").last!.replacingOccurrences(of: vocab, with: "")
//
//            defi.remove(at: defi.index(defi.startIndex, offsetBy: 0))
//
//            for _ in 0...3 {
//                 defi.remove(at: defi.index(defi.endIndex, offsetBy: -1))
//            }
//
//            diction.setValue(defi, forKey: "description")
//
//            let exampleAndType = ojectNew[i].components(separatedBy: ":").first!
//
//            let type = exampleAndType.components(separatedBy: .whitespaces).last!
//
//            diction.setValue(type, forKey: "type")
//
//            var example = exampleAndType.replacingOccurrences(of: type, with: "")
//
//            for _ in 0...3 {
//                 example.remove(at: example.index(example.endIndex, offsetBy: -1))
//            }
//
//            diction.setValue(example, forKey: "example")
//
            dictionArray.append(diction)
//
            
        }
        let jsonData = try! JSONSerialization.data(withJSONObject: dictionArray, options: .prettyPrinted)

        let jsonString = String(data: jsonData, encoding: .utf8)!
        
        print(jsonString)
    }
    
    
    
    @IBAction func convertDictionaryCopy(_ sender: Any) {
        let path = Bundle.main.path(forResource: "dictionary_copy", ofType: "txt")
        let url = URL(fileURLWithPath: path!)
        
        let dictionary = try! String(contentsOf: url)
        
        var diccomponent = dictionary.components(separatedBy: .newlines)
        for i in 0...63797 {
//            print(i)
            if diccomponent[i].contains("???") || !diccomponent[i].contains("\\n-") {
                diccomponent.remove(at: i)
            }
        }
        print(diccomponent.count)
//        thuLabel.text = diccomponent[1294].replacingOccurrences(of: "\\n", with: "\n")
        var diction = [NSMutableDictionary]()
        
        for i in 0...diccomponent.count - 2 {
            let para = NSMutableDictionary()
            // vocabulary
            let firstComponent = diccomponent[i].components(separatedBy: "\t").first!
//            print(firstComponent)
            let dicFirstComponent = diccomponent[i].components(separatedBy: "\\n").first!
            let dicLastComponent = diccomponent[i].components(separatedBy: "\\n").last!
            
            let vocabulary = dicFirstComponent.components(separatedBy: "\t").first!
            para.setValue(vocabulary, forKey: "vocabulary")
            // ipa
            let ipaComponent = dicFirstComponent.components(separatedBy: "@").last!.components(separatedBy: .whitespaces)
            
            for i in 0...ipaComponent.count - 1 {
                if ipaComponent[i].contains("/") {
                    para.setValue(ipaComponent[i], forKey: "IPA")
                    break
                } else {
                    para.setValue("", forKey: "IPA")
                }
            }
            // type
            let typeComponent = diccomponent[i].components(separatedBy: "\\n-").first!
            let type = typeComponent.components(separatedBy: "\\n*").last!
            if type.contains("\t") {
                para.setValue("", forKey: "type")
            } else {
                para.setValue(type, forKey: "type")
            }
            // difine
            
            var defiFirst = diccomponent[i].components(separatedBy: "\\n-").first!.replacingOccurrences(of: vocabulary, with: "")
           defiFirst.removeFirst()
            var sumDefine = String()
                            if defiFirst.contains("@C") {
                    sumDefine = diccomponent[i].replacingOccurrences(of: vocabulary, with: "")
                                for _ in 0...1 {
                                    sumDefine.removeFirst()
                                }

                            }  else {
                    sumDefine = diccomponent[i].replacingOccurrences(of: diccomponent[i].components(separatedBy: "\\n-").first!, with: "")
                     for _ in 0...3 {
                                                       sumDefine.removeFirst()
                        }
                }
            
            

            print(sumDefine)
            
            
         
            diction.append(para)
        }
        let jsonData = try! JSONSerialization.data(withJSONObject: diction, options: .prettyPrinted)
        let jsonString = String(data: jsonData, encoding: .utf8)!
        DispatchQueue.main.async {
//            print(jsonString)
        }
        
    }
    
    
    
    @IBAction func search(_ sender: Any) {
        let path = Bundle.main.path(forResource: "vocab_dictionary", ofType: "txt")
        let text = try! String(contentsOf: URL(fileURLWithPath: path!))
        
        let data = text.components(separatedBy: .newlines)
        let a = SearchViewController()
        a.dataVocab = data
        self.navigationController?.pushViewController(a, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

