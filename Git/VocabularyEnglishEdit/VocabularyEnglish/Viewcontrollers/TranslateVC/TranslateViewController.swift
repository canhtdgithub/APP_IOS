//
//  TranslateViewController.swift
//  VocabularyEnglish
//
//  Created by Cata on 9/3/20.
//  Copyright © 2020 Cata. All rights reserved.
//

import UIKit

class TranslateViewController: UIViewController {
    
    let transModel = ModelTranslateViewController.shared
    
    var translate = [String:String]()
    
    @IBOutlet weak var collection: UICollectionView!
    
    @IBOutlet weak var vocabularyLabel: UILabel!
    
    @IBOutlet weak var ipaLabel: UILabel!
    
    @IBOutlet weak var typeLabel: UILabel!
    
    @IBOutlet weak var mainMeaningLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        initUI()
        
    }
    
    func loadData() {
        vocabularyLabel.text = translate["vocabulary"]
        ipaLabel.text = translate["IPA"]
        typeLabel.text = translate["type"]
        mainMeaningLabel.text = translate["mainMeaning"]
    }

}

extension TranslateViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let collec = collection.dequeueReusableCell(withReuseIdentifier: TranslateCollectionViewCell.identifier, for: indexPath) as! TranslateCollectionViewCell
        collec.titleLabel.text = transModel.title[indexPath.row].title
        return collec
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = UIScreen.main.bounds.size.width / 2
        let height = collectionView.bounds.size.height
        return CGSize(width: width, height: height)
    }
    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        <#code#>
//    }
    
    
}

extension TranslateViewController {
    func initUI() {
        
        regist()
        transModel.loadTitles()
    }
    
    func regist() {
        collection.delegate = self
        collection.dataSource = self
        collection.register(TranslateCollectionViewCell.nib(), forCellWithReuseIdentifier: TranslateCollectionViewCell.identifier)
    }
    
    
}

