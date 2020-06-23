//
//  ViewController.swift
//  Animation
//
//  Created by Cata on 6/19/20.
//  Copyright © 2020 Cata. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var newView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let frame = CGRect(x: 0, y: 0, width: 40, height: 10)
                newView = UIView(frame: frame)
                newView.backgroundColor = UIColor.blue
                newView.layer.borderWidth = 2
                newView.layer.borderColor = UIColor.red.cgColor
                self.view.addSubview(newView)
        UIView.animate(withDuration: 1.0, animations: {
            let frame2 = CGRect(x: UIScreen.main.bounds.size.width , y: 0, width: 40, height: 10)
            self.newView.frame = frame2
            self.replay()
        })
        
        // Do any additional setup after loading the view.
    }
    
        func replay() {
            let frame = CGRect(x: -40, y: 0, width: 40, height: 10)
            newView = UIView(frame: frame)
            newView.backgroundColor = UIColor.blue
            newView.layer.borderWidth = 2
            newView.layer.borderColor = UIColor.red.cgColor
            self.view.addSubview(newView)
            
                    UIView.animate(withDuration: 1.0, animations: {
                        let frame2 = CGRect(x: UIScreen.main.bounds.size.width  , y: 0, width: 40, height: 10)
                        self.newView.frame = frame2
                    }) { (v) in
                        if v {
                            self.replay()
                        }
                    }
                }
            
        

}

//override func viewDidLoad() {
//        super.viewDidLoad()
//        self.navigationItem.title = "View A"
//        textField.delegate = self
//
//        let frame = CGRect(x: (UIScreen.main.bounds.size.width - 10)/2, y: (UIScreen.main.bounds.size.height - 10)/2, width: 10, height: 10)
//        subview = UIView(frame: frame)
//        subview.backgroundColor = UIColor.blue
//        subview.layer.borderWidth = 2
//        subview.layer.borderColor = UIColor.red.cgColor
//        subview.layer.cornerRadius = 5
//        self.view.addSubview(subview)
//    }
//
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
////        UIView.animate(withDuration: 0.5) {
////            let frame = CGRect(x: (UIScreen.main.bounds.size.width - 200)/2, y: (UIScreen.main.bounds.size.height - 200)/2, width: 200, height: 200)
////            self.subview.frame = frame
////            self.subview.layer.cornerRadius = 100
////        }
//
//        self.abc()
//    }
//
//    func abc() {
//        UIView.animate(withDuration: 0.5, animations: {
//            let frame = CGRect(x: (UIScreen.main.bounds.size.width - 200)/2, y: (UIScreen.main.bounds.size.height - 200)/2, width: 200, height: 200)
//            self.subview.frame = frame
//            self.subview.layer.cornerRadius = 100
//        }) { (value) in
//            if value == true {
//                UIView.animate(withDuration: 0.5, animations: {
//                    let frame = CGRect(x: (UIScreen.main.bounds.size.width - 10)/2, y: (UIScreen.main.bounds.size.height - 10)/2, width: 10, height: 10)
//                    self.subview.frame = frame
//                    self.subview.layer.cornerRadius = 5
//                }) { (v) in
//                    if v {
//                        self.abc()
//                    }
//                }
//            }
//        }
//    }


