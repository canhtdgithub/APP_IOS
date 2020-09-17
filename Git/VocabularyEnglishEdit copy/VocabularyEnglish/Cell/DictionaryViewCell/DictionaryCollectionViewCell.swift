//
//  DictionaryCollectionViewCell.swift
//  VocabularyEnglish
//
//  Created by Cata on 9/4/20.
//  Copyright © 2020 Cata. All rights reserved.
//

import UIKit

class DictionaryCollectionViewCell: UICollectionViewCell {
    
    static var identifier = "diccollection"
    
    static func nib() -> UINib {
        return UINib(nibName: "DictionaryCollectionViewCell", bundle: nil)
    }

    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var imageWord: UIImageView!
    func config(subject: SubjectName) {
        nameLabel.text = subject.name
        imageWord.image = subject.image
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
