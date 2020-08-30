//
//  ViewController.swift
//  COVERT_700_TOEIC_TXT
//
//  Created by Cata on 8/29/20.
//  Copyright © 2020 Cata. All rights reserved.
//

import UIKit

class ViewController: UIViewController {


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
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

