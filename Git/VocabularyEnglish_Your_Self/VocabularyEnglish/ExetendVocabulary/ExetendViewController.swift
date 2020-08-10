//
//  ExetendViewController.swift
//  VocabularyEnglish
//
//  Created by Cata on 7/14/20.
//  Copyright © 2020 Cata. All rights reserved.
//

import UIKit


class ExetendViewController: UIViewController {
        
    //MARK: - @IBOUTLET
    
    @IBOutlet weak var textViewContraint: NSLayoutConstraint!
    
    @IBOutlet weak var vocabLabel: UILabel!
    
    @IBOutlet weak var showImages: UIImageView!
    
    @IBOutlet weak var descripTextView: UITextView!
    
    //MARK: - @IBACTION

    
    //MARK: - TOUCH
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        DatabaseManager.shared.insertDefine(text: descripTextView.text, index: cellcount) { (success) in
            if success {
                print("success insert")
            }
        }
        
        if descripTextView.text.isEmpty {
            realm.beginWrite()
            vocabularys![cellcount].descripVocab = ""
            try! realm.commitWrite()
        } else {
            realm.beginWrite()
            vocabularys![cellcount].descripVocab = descripTextView.text!
            try! realm.commitWrite()
            
        }
        
        self.descripTextView.resignFirstResponder()
    }
    
    //MARK: - VIEW LIFE CYCLE
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Any code you put in here will be called when the keyboard is about to display
        notifiShowKeyboard()
        // Any code you put in here will be called when the keyboard is about to hide
        notifiHideKeyboard()
        
        
        layerImage()
        layerDesciption()
        if ModelViewController.shared.isConnectedToNetwork() {
            vocabLabel.text = list[cellcount].vocab
            descripTextView.text! = list[cellcount].define
        }
        vocabLabel.text = vocabularys![cellcount].vocabulary
        inserImage()
        ModelExetendViewController.shared.testShowImage(label: vocabLabel, image: showImages)
        
        descripTextView.text! = vocabularys![cellcount].descripVocab
        
    }
    
    //MARK: - METHOD
    
    func inserImage() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(didTapImage))
        showImages.addGestureRecognizer(gesture)
    }
    @objc func didTapImage() {
        alertInsertImages()
    }
    
    func notifiShowKeyboard() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        
        if let userInfo = notification.userInfo as? Dictionary<String, AnyObject> {
            let frame = userInfo[UIResponder.keyboardFrameEndUserInfoKey]
            let keyBoardRect = frame?.cgRectValue
            if let keyBoardHeight = keyBoardRect?.height {
                self.textViewContraint.constant = keyBoardHeight
            }
        }
        
    }
    
    func notifiHideKeyboard() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        self.textViewContraint.constant = 5
    }
    
    func layerImage() {
        showImages.layer.cornerRadius = 10
        showImages.layer.borderWidth = 0.6
        showImages.layer.borderColor = UIColor.black.cgColor
    }
    
    func layerDesciption() {
        descripTextView.layer.cornerRadius = 10
        descripTextView.layer.borderWidth = 0.6
        descripTextView.layer.borderColor = UIColor.black.cgColor
    }
    
    
    
}

//MARK: - UIImagePickerControllerDelegate And UINavigationControllerDelegate

extension ExetendViewController: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    func alertInsertImages() {
        let alert = UIAlertController(title: "Choose Image", message: nil, preferredStyle: .alert)
        
        let addImageCamera = UIAlertAction(title: "Add Photos From Camera", style: .default) { (action) in
            let picker = UIImagePickerController()
            picker.sourceType = .camera
            picker.delegate = self
            self.present(picker, animated: true, completion: nil)
        }
        
        let addImagePhotoLibrary = UIAlertAction(title: "Add Photos From Library", style: .default) { (action) in
            let picker = UIImagePickerController()
            picker.sourceType = .photoLibrary
            picker.delegate = self
            self.present(picker, animated: true, completion: nil)
        }
        
        let addImagePhotosAlbum = UIAlertAction(title: "Add Photos From Album", style: .default) { (action) in
            let picker = UIImagePickerController()
            picker.sourceType = .savedPhotosAlbum
            picker.delegate = self
            self.present(picker, animated: true, completion: nil)
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alert.addAction(addImagePhotoLibrary)
        alert.addAction(addImagePhotosAlbum)
        alert.addAction(addImageCamera)
        alert.addAction(cancel)
        self.present(alert, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.originalImage] as? UIImage
        showImages.image = image!
        // save image in document directory
        let fileManager = FileManager.default
        
        let PathWithFolderName = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent("FolderName")
        
        print("Document Directory Folder Path :- ",PathWithFolderName)
        
        if !fileManager.fileExists(atPath: PathWithFolderName)
        {
            try! fileManager.createDirectory(atPath: PathWithFolderName, withIntermediateDirectories: true, attributes: nil)
        }
        
        let url = URL(string: PathWithFolderName)
        let imagePath = url?.appendingPathComponent("\(vocabLabel.text!).png").absoluteString
        let imfData = UIImage.pngData(image!)
        fileManager.createFile(atPath: imagePath!, contents: imfData(), attributes: nil)
       
        dismiss(animated: true, completion: nil)
    }
    
}





