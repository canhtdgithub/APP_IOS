//
//  ViewController.swift
//  DragCollectionView
//
//  Created by Cata on 6/30/20.
//  Copyright © 2020 Cata. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    // MARK: - DECLARE

    
    @IBOutlet weak var collection: UICollectionView!
    
    var anh = ["anh1","anh2","anh3","anh4","anh5","anh6","anh1","anh2","anh3","anh4","anh5","anh6","anh1","anh2","anh3","anh4","anh5","anh6"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collection.dataSource = self
        collection.delegate = self
        collection.register(UINib(nibName: "MyCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: "cell")
        let gesture = UILongPressGestureRecognizer(target: self, action: #selector(handle(_:)))
        collection.addGestureRecognizer(gesture)
        collection.allowsMultipleSelection = true
    }
    
//    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//        collection.frame = view.bounds
//    }
    // MARK: - HANDLE GESTURE
    
    @objc func handle(_ gesture: UILongPressGestureRecognizer) {
        guard let collectionView = collection else {
            return
        }
        switch gesture.state {
            
        case .began:
            guard let target = collectionView.indexPathForItem(at: gesture.location(in: collectionView)) else {
                return
            }
            collectionView.beginInteractiveMovementForItem(at: target)
        case .changed:
            collectionView.updateInteractiveMovementTargetPosition(gesture.location(in: collectionView))
        case .ended:
            collectionView.endInteractiveMovement()
        default:
            collectionView.cancelInteractiveMovement()
        }
        
        
    }


}
//MARK: - EXTENTION

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return anh.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collection.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! MyCollectionViewCell
        
        cell.myImage.image = UIImage(named: anh[indexPath.row])
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let h = 150
        let w = (collectionView.frame.size.width - 3*10) / 2
        
        return CGSize(width: CGFloat(w), height: CGFloat(h))
    }
    func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let item = anh.remove(at: sourceIndexPath.row)
        anh.insert(item, at: destinationIndexPath.row )
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
//        collectionView.cellForItem(at: indexPath)?.backgroundColor = .black
    }
}

