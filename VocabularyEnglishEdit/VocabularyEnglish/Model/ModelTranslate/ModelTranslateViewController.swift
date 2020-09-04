//
//  ModelTranslateViewController.swift
//  VocabularyEnglish
//
//  Created by Cata on 9/4/20.
//  Copyright © 2020 Cata. All rights reserved.
//

import UIKit

struct Titles {
    var title: String
}


class ModelTranslateViewController {
    static let shared = ModelTranslateViewController()
    var title = [Titles]()
    
    
    func loadTitles() {
        title.append(Titles(title: "Translate"))
        title.append(Titles(title: "Specialized"))
    }
    
    
}
