//
//  Extension.swift
//  VocabularyEnglish
//
//  Created by Cata on 8/14/20.
//  Copyright © 2020 Cata. All rights reserved.
//

import Foundation
import UIKit

extension UIButton {
    func tapAnimation() {
        let tap = CASpringAnimation(keyPath: "opacity")
        tap.damping = 0.5
        tap.fromValue = 1
        tap.toValue = 0.7
        tap.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        tap.autoreverses = true
        tap.repeatCount = 1
        layer.add(tap, forKey: nil)
    }
    
    func layerButtom(cornerRadius: CGFloat?, borderColor: CGColor, borderWidth: CGFloat? ) {
        layer.cornerRadius = cornerRadius ?? 0
        layer.borderColor = borderColor
        layer.borderWidth = borderWidth ?? 0
    }
    
    func setColorIcon(btn: UIButton, nameImage: String, colorIcon: UIColor) {
        let origImage = UIImage(named: nameImage)
        let tintedImage = origImage?.withRenderingMode(.alwaysTemplate)
        btn.setImage(tintedImage, for: .normal)
        btn.tintColor = colorIcon
    }
    
}

extension UIView {
    
    func layerViews(cornerRadius: CGFloat?, borderColor: CGColor, borderWidth: CGFloat? ) {
        layer.cornerRadius = cornerRadius ?? 0
        layer.borderColor = borderColor
        layer.borderWidth = borderWidth ?? 0
    }
}
extension UICollectionViewCell {
    func tapAnimation() {
        let tap = CASpringAnimation(keyPath: "opacity")
        tap.damping = 5
        tap.fromValue = 1
        tap.toValue = 0.7
        tap.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        tap.autoreverses = true
        tap.repeatCount = 1
        contentView.layer.add(tap, forKey: nil)
    }
    
    func layerCollectionViewCell(cornerRadius: CGFloat?, borderColor: CGColor, borderWidth: CGFloat? ) {
        layer.cornerRadius = cornerRadius ?? 0
        layer.borderColor = borderColor
        layer.borderWidth = borderWidth ?? 0
    }

}

