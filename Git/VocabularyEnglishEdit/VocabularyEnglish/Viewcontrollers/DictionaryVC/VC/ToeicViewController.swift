//
//  ToeicViewController.swift
//  VocabularyEnglish
//
//  Created by Cata on 9/4/20.
//  Copyright © 2020 Cata. All rights reserved.
//

import UIKit
import iCarousel


class ToeicViewController: UIViewController {
   
    var vocab = [Word700]()
    var favourite = [Bool]()
    
    @IBOutlet weak var myIcarousel: iCarousel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        myIcarousel.type = .cylinder
//        myIcarousel.autoscroll = -0.1
        myIcarousel.delegate = self
        myIcarousel.dataSource = self
        getData()
        
    }
    
    func getData() {
        let path = Bundle.main.path(forResource: "700_TOEIC", ofType: "json")
        let get = try! Data(contentsOf: URL(fileURLWithPath: path!))
        
        vocab = try! JSONDecoder().decode([Word700].self, from: get)
        myIcarousel.reloadData()
    }
    


}




extension ToeicViewController: iCarouselDelegate, iCarouselDataSource {
    func numberOfItems(in carousel: iCarousel) -> Int {
        return vocab.count
        
    }
    
    
    
    func carousel(_ carousel: iCarousel, viewForItemAt index: Int, reusing view: UIView?) -> UIView {
        
       
        let a = Bundle.main.loadNibNamed("MyView", owner: self, options: nil)?.first as? MyView
        a?.backgroundColor = .clear
        a?.starLayer.setImage(UIImage(named: "starfill"), for: .normal)
        a?.layerView.layer.cornerRadius = 20
        a?.layerView.layer.borderWidth = 1
        a?.layerView.layer.borderColor = UIColor.black.cgColor
        a?.config(value: vocab[index])
        return a!
    }
    func carousel(_ carousel: iCarousel, didSelectItemAt index: Int) {

        
       
    }
    
    
    
}

struct Word700: Codable {
    var vocabulary: String
    var type: String
    var example: String
}
