//
//  ModelQuizGames.swift
//  VocabularyEnglish
//
//  Created by Cata on 7/24/20.
//  Copyright © 2020 Cata. All rights reserved.
//

import UIKit


class ModelQuizGames {
    static let shared = ModelQuizGames()
    
    let imageWrong = ["wrong","wrong1","wrong2"]
      let imageCorrect = ["congratulation", "congratulation1", "congratulation2", "congratulation3", "congratulation4"]
      
    
    var stringAfterRandom: String?
    var stringAfterShuffled = [Character]()
    private init() {}
 
    func deleteText(show: UILabel) {
        guard var string = show.text, string.count > 0 else {
            return
        }
        string.remove(at: string.index(before: string.endIndex))
        show.text! = string
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
    
    func testQuestions(showAnswer: UILabel, imageQuestion:  UIImageView, collectionView: UICollectionView, viewPresent: UIViewController ) {
              if showAnswer.text == self.stringAfterRandom {
                  tinh()
                  imageQuestion.image = UIImage(named: "nevergiveup")
                  imageQuestion.loadGif(name: imageCorrect.randomElement()!)
                  let _ = Timer.scheduledTimer(withTimeInterval: 1.2, repeats: false) { (time) in
                      imageQuestion.image = UIImage(named: "nevergiveup")
                      showAnswer.text = ""
                      collectionView.reloadData()
                  }
                  
              } else if showAnswer.text!.isEmpty {
                  let alert = UIAlertController(title: "Thông báo", message: "Bạn chưa nhập gì cả, vui lòng làm lại", preferredStyle: .alert)
                  let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
                  showAnswer.text = ""
                  alert.addAction(cancel)
                  viewPresent.present(alert, animated: true, completion: nil)
              }
              else {
                  let alert = UIAlertController(title: "Thông báo", message: "Bạn đã sai, vui lòng làm lại", preferredStyle: .alert)
                  let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
                  showAnswer.text = ""
                  alert.addAction(cancel)
                  imageQuestion.loadGif(name: imageWrong.randomElement()!)
                  viewPresent.present(alert, animated: true, completion: nil)
              }
          }
    
    
    
    
}


