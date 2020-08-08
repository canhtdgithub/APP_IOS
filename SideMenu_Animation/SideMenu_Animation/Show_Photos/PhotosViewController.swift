//
//  PhotosViewController.swift
//  SideMenu_Animation
//
//  Created by Cata on 7/8/20.
//  Copyright © 2020 Cata. All rights reserved.
//

import UIKit

class PhotosViewController: UIViewController {

    
    @IBOutlet weak var insertImage: UIButton!
    @IBOutlet weak var textDescription: UITextView!
    
    @IBAction func InsertImage(_ sender: Any) {
        let insert = UIImagePickerController()
        insert.sourceType = .photoLibrary
        insert.delegate = self
        insert.allowsEditing = true
        present(insert, animated: true, completion: nil)
        
    }
    
    @IBOutlet weak var photos: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textDescription.layer.cornerRadius = 8
        textDescription.layer.borderWidth = 2
        textDescription.layer.borderColor = UIColor.black.cgColor
        
        photos.layer.cornerRadius = 4
        photos.layer.borderWidth = 2
        photos.layer.borderColor = UIColor.black.cgColor
        
      
    }

}

extension PhotosViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        print(info)
        let image = info[.editedImage] as! UIImage
        photos.image = image
        insertImage.isHidden = true
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
