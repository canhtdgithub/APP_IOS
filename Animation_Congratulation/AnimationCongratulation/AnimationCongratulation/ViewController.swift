//
//  ViewController.swift
//  AnimationCongratulation
//
//  Created by Cata on 6/22/20.
//  Copyright © 2020 Cata. All rights reserved.
//
import Lottie
import UIKit

class ViewController: UIViewController {
    @IBOutlet var view1: UIView!
    @IBOutlet var view2: UIView!
    
    let anima = AnimationView()
    override func viewDidLoad() {
        super.viewDidLoad()
        showanimation()
        // Do any additional setup after loading the view.
    }
    private func showanimation() {
        anima.animation = Animation.named("winner")
        anima.frame = view1.bounds
        anima.center = self.view1.center
//        anima.contentMode = .scaleAspectFit
        anima.backgroundColor = .white
        anima.loopMode = .loop
        anima.play()
        view1.addSubview(anima)
    }

}

