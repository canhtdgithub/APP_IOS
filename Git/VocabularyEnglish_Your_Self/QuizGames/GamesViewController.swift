//
//  GamesViewController.swift
//  VocabularyEnglish
//
//  Created by Cata on 7/13/20.
//  Copyright © 2020 Cata. All rights reserved.
//

import UIKit


class GamesViewController: UIViewController {
    
    //MARK: - @IBOUTLET
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var imageQuestion: UIImageView!
    
    @IBOutlet weak var showAnswer: UILabel!
    
    @IBOutlet weak var layerSpeakerQuestion: UIButton!
    
    @IBOutlet weak var viewLayer: UIView!
    
    
    @IBOutlet weak var layerNextQuestion: UIButton!
    
    //MARK: - @IBACTION
    
    @IBAction func deleteButton(_ sender: UIButton) {
        sender.tapAnimation()
        deleteText()
    }
    
    @IBAction func next(_ sender: Any) {
        
        testQuestions()
        
    }
   
    @IBAction func speakerQuestion(_ sender: UIButton) {
        sender.tapAnimation()
        SIRSpeakerManager.sharedInstance.stop()
        guard let string = stringAfterRandom else {
            return
        }
        SIRSpeakerManager.sharedInstance.speak(string)
        
    }
    
    //MARK: - VIEW LIFE CYCLE
      
      override func viewDidLoad() {
          super.viewDidLoad()
          navigationItem.title = "Brain Trainig"
          registTable(collectionView: collectionView)
        layerSpeakerQuestion.layerButtom(cornerRadius: layerSpeakerQuestion.frame.height / 2, borderColor: UIColor.black.cgColor , borderWidth: 2)
        vocabularys = realm.objects(Vocab.self)
        
        viewLayer.layer.borderWidth = 1
        viewLayer.layer.borderColor = UIColor.gray.cgColor
        viewLayer.layer.cornerRadius = 7
        
        layerNextQuestion.layerButtom(cornerRadius: layerNextQuestion.frame.size.height / 2, borderColor: UIColor.gray.cgColor, borderWidth: 1)
        
      }
      
    //MARK: - PROPERTIES
    
    let imageWrong = ["wrong","wrong1","wrong2"]
    let imageCorrect = ["congratulation", "congratulation1", "congratulation2", "congratulation3", "congratulation4"]
    var stringAfterRandom: String?
    var stringAfterShuffled = [Character]()
    
    
    //MARK: - FUNCTION
    func registTable(collectionView: UICollectionView) {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(GamesCollectionViewCell.nib(), forCellWithReuseIdentifier: GamesCollectionViewCell.identifier)
        
    }
    
    func deleteText() {
        guard var string = showAnswer.text, string.count > 0 else {
            return
        }
        string.remove(at: string.index(before: string.endIndex))
        showAnswer.text! = string
    }
    
    func tinh() -> Int {
           if vocabularys!.count == 0 {
               return 0
           } else {
               self.stringAfterRandom = vocabularys![Int.random(in: 0...(vocabularys!.count - 1))].vocabulary
               self.stringAfterShuffled = stringAfterRandom!.shuffled()
               return stringAfterShuffled.count
           }
       }
    
    func testQuestions() {
        if showAnswer.text == self.stringAfterRandom {
            tinh()
            imageQuestion.image = UIImage(named: "nevergiveup")
            self.imageQuestion.loadGif(name: self.imageCorrect.randomElement()!)
            let _ = Timer.scheduledTimer(withTimeInterval: 1.2, repeats: false) { (time) in
                self.imageQuestion.image = UIImage(named: "nevergiveup")
                self.showAnswer.text = ""
                self.collectionView.reloadData()
            }
            
        } else if showAnswer.text!.isEmpty {
            let alert = UIAlertController(title: "Thông báo", message: "Bạn chưa nhập gì cả, vui lòng làm lại", preferredStyle: .alert)
            let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            showAnswer.text = ""
            alert.addAction(cancel)
            self.present(alert, animated: true, completion: nil)
        }
        else {
            let alert = UIAlertController(title: "Thông báo", message: "Bạn đã sai, vui lòng làm lại", preferredStyle: .alert)
            let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            showAnswer.text = ""
            alert.addAction(cancel)
            
            imageQuestion.loadGif(name: self.imageWrong.randomElement()!)
            self.present(alert, animated: true, completion: nil)
        }
    }

  
}

    //MARK: - UICollectionViewDelegate

extension GamesViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tinh()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GamesCollectionViewCell.identifier, for: indexPath) as! GamesCollectionViewCell
        cell.config(value: stringAfterShuffled[indexPath.row])
        cell.layerCollectionViewCell(cornerRadius: 8, borderColor: UIColor.black.cgColor, borderWidth: 1)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        self.showAnswer.text?.append(stringAfterShuffled[indexPath.row])
    }
    

}
