//
//  MyTableViewCell.swift
//  READ_FILE_JSON
//
//  Created by Cata on 8/30/20.
//  Copyright © 2020 Cata. All rights reserved.
//

import UIKit

class MyTableViewCell: UITableViewCell {

    @IBOutlet weak var imageVocab: UIImageView!
    
    @IBOutlet weak var vocab: UILabel!
    
    @IBOutlet weak var typeAndDefine: UILabel!
    
    
    @IBOutlet weak var example: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
   
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func config(value: VocabularyManager) {
        let name = value.vocabulary.replacingOccurrences(of: " ", with: "_")
        
        let path = Bundle.main.path(forResource: name, ofType: "jpg")
        
        let url = URL(fileURLWithPath: path!)
        let getImage = try! Data(contentsOf: url)
        
        imageVocab.image = UIImage(data: getImage)
        vocab.text = value.vocabulary
        typeAndDefine.text = value.type
        example.text = value.example
    }
    
}
