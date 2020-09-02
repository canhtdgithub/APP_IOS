//
//  TranslateViewController.swift
//  COVERT_700_TOEIC_TXT
//
//  Created by Cata on 9/1/20.
//  Copyright © 2020 Cata. All rights reserved.
//

import UIKit

class TranslateViewController: UIViewController {
    var text: String!
    @IBOutlet weak var translateLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        translateLabel.text = text
        // Do any additional setup after loading the view.
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
