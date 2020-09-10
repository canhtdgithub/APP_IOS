//
//  WordCommonViewController.swift
//  VocabularyEnglish
//
//  Created by Cata on 9/4/20.
//  Copyright © 2020 Cata. All rights reserved.
//

import UIKit

class WordCommonViewController: UIViewController, MyViewDelegate {
    
    func didTapButton(viewController: UIViewController) {
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
 
    @IBOutlet weak var viewHome: UIView!
    
    @IBOutlet weak var table: UITableView!
    var word = [Word3000Common]()
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
       let view1 = Bundle.main.loadNibNamed("HomeView", owner: self, options: nil)?.first as? HomeView
        view1?.dele = self
        view1!.frame = viewHome.bounds
        viewHome.addSubview(view1!)
    }

    

}

extension WordCommonViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return word.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: WordCommonTableViewCell.identifier, for: indexPath) as! WordCommonTableViewCell
        
        cell.config(value: word[indexPath.row])
        return cell
    }
    
    
}

extension WordCommonViewController {
    
    func initUI() {
        register()
        loadDataWord()
    }
    func register() {
        table.delegate = self
        table.dataSource = self
        table.register(WordCommonTableViewCell.nib(), forCellReuseIdentifier: WordCommonTableViewCell.identifier)
    }
    
    func loadDataWord() {
        let path = Bundle.main.path(forResource: "3000_vocabulary_common", ofType: "json")
        let data = try! Data(contentsOf: URL(fileURLWithPath: path!))
        
        word = try! JSONDecoder().decode([Word3000Common].self, from: data)
    }
}

struct Word3000Common: Codable {
    var vocabulary: String
    var IPA: String
    var type: String
    var meaning: String
}
