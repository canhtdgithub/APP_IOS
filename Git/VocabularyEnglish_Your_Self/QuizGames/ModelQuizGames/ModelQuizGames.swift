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
//    var editColor = [Bool]()
//    var tapCount = [Int]()
   
    
    
    let imageWrong = ["wrong","wrong1","wrong2"]
      let imageCorrect = ["congratulation", "congratulation1", "congratulation2", "congratulation3", "congratulation4"]
      
    
    var stringAfterRandom: String?
    var stringAfterShuffled = [Character]()
    private init() {}
    
    
 
    func deleteText(showAnswer: UILabel ) {
        guard var string = showAnswer.text, string.count > 0 else {
            return
        }
        string.remove(at: string.index(before: string.endIndex))
        
        showAnswer.text! = string
       
    }
    
    func addCharacter(showAnswer: UILabel,indexPath: IndexPath) {
        showAnswer.text?.append(stringAfterShuffled[indexPath.row])
    }
    
//
//    func changeCharacter(indexPath: IndexPath ,showCharacter: UILabel, showAnswer: UILabel ) {
//        if editColor[indexPath.row] {
//                   showCharacter.isHidden = true
//                   showAnswer.text?.append(stringAfterShuffled[indexPath.row])
//                   editColor[indexPath.row] = false
//
//        }
//
//
//    }
//
//    func changeColorCell(showAnswer: UILabel, indexPath: IndexPath, cell: UICollectionViewCell) {
//        if editColor[indexPath.row] {
//                   cell.backgroundColor = .gray
//                    showAnswer.text?.append(stringAfterShuffled[indexPath.row])
//                   editColor[indexPath.row] = false
//               } else {
//                   cell.backgroundColor = UIColor(red: 252/255, green: 41/255, blue: 144/255, alpha: 1.0)
//                   editColor[indexPath.row] = true
//               }
//    }
//
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
//                    self.editColor.removeAll()
                      collectionView.reloadData()
                  }
                  
              } else if showAnswer.text!.isEmpty {
                  let alert = UIAlertController(title: "Alert", message: "You have not entered anything, please re-enter", preferredStyle: .alert)
                  let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
                  showAnswer.text = ""
                  alert.addAction(cancel)
                  viewPresent.present(alert, animated: true, completion: nil)
              }
              else {
                  let alert = UIAlertController(title: "Alert", message: "You wrong, please work again", preferredStyle: .alert)
                  let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
                  showAnswer.text = ""
                  alert.addAction(cancel)
                  imageQuestion.loadGif(name: imageWrong.randomElement()!)
                  viewPresent.present(alert, animated: true, completion: nil)
              }
          }
    
    
    
    
}


