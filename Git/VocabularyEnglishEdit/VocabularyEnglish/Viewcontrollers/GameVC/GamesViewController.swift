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
    
    @IBAction func next(_ sender: Any) {
        ModelQuizGames.shared.testQuestions(showAnswer: showAnswer,
                                            imageQuestion: imageQuestion,
                                            collectionView: collectionView,
                                            viewPresent: self)
        
        
    }
   
    @IBAction func speakerQuestion(_ sender: UIButton) {
        sender.tapAnimation()
        SIRSpeakerManager.sharedInstance.stop()
        guard let string = ModelQuizGames.shared.stringAfterRandom else {
            return
        }
        SIRSpeakerManager.sharedInstance.speakUS(string)
        
    }
    
    //MARK: - VIEW LIFE CYCLE
      
      override func viewDidLoad() {
          super.viewDidLoad()
        ModelQuizGames.shared.settingNavigationBar(viewController: self)
        navigationItem.title = "Brain Training"
          registTable(collectionView: collectionView)
        vocabularys = realm.objects(Vocab.self)
        
        layerSpeakerQuestion.layerButtom(cornerRadius: layerSpeakerQuestion.frame.height / 2,
                                         borderColor: UIColor.gray.cgColor ,
                                         borderWidth: 2)
        viewLayer.layerViews(cornerRadius: 7,
                             borderColor: UIColor.gray.cgColor,
                             borderWidth: 1)
        layerNextQuestion.layerButtom(cornerRadius: layerNextQuestion.frame.size.height / 2,
                                      borderColor: UIColor.gray.cgColor,
                                      borderWidth: 1)
        
      }
    
    //MARK: - FUNCTION
    func registTable(collectionView: UICollectionView) {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(GamesCollectionViewCell.nib(), forCellWithReuseIdentifier: GamesCollectionViewCell.identifier)
        collectionView.delaysContentTouches = false
    }
    
  
}

    //MARK: - UICollectionViewDelegate

extension GamesViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ModelQuizGames.shared.tinh()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        ModelQuizGames.shared.editColor.append(true)
        ModelQuizGames.shared.tapCount.append(0)
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GamesCollectionViewCell.identifier, for: indexPath) as! GamesCollectionViewCell
        cell.config(value: ModelQuizGames.shared.stringAfterShuffled[indexPath.row])
        cell.layerCollectionViewCell(cornerRadius: 8, borderColor: UIColor.black.cgColor, borderWidth: 1)
        
        cell.backgroundColor = UIColor("ef5285", alpha: 1.0)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        let cell = collectionView.cellForItem(at: indexPath) as! GamesCollectionViewCell
        
        ModelQuizGames.shared.changeColorCell(showAnswer: showAnswer, indexPath: indexPath, cell: cell)
        
    }
    
    

}
