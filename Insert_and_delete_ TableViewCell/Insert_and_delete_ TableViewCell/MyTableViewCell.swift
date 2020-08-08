//
//  MyTableViewCell.swift
//  Insert_and_delete_ TableViewCell
//
//  Created by Cata on 6/25/20.
//  Copyright © 2020 Cata. All rights reserved.
//

import UIKit

class MyTableViewCell: UITableViewCell {

    @IBOutlet weak var title: UILabel?
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
