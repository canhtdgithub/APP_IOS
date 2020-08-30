//
//  ViewController.swift
//  CarouselBeginner
//
//  Created by Cata on 8/30/20.
//  Copyright © 2020 Cata. All rights reserved.
//

import UIKit
import iCarousel

class ViewController: UIViewController {
    
    @IBOutlet weak var viewImage: iCarousel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewImage.type = .cylinder
        viewImage.dataSource = self
        viewImage.delegate = self
    }


}

extension ViewController: iCarouselDataSource, iCarouselDelegate {
    func numberOfItems(in carousel: iCarousel) -> Int {
        return 700
    }
    
    func carousel(_ carousel: iCarousel, viewForItemAt index: Int, reusing view: UIView?) -> UIView {
        let view = MyView()
        view.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
//        let path = Bundle.main.path(forResource: "contribute", ofType: "jpg")
//        let getImage = try! Data(contentsOf: URL(fileURLWithPath: path!))
//
//
//        let view1 = UIImageView(image: UIImage(data: getImage))
//
//        view.addSubview(view1)
        
        return view
    }
  
    
    
    
}
