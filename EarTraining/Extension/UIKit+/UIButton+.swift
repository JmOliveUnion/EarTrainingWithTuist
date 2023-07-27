//
//  UIButton+.swift
//  EarTraining
//
//  Created by 김민종 on 2023/07/12.
//

import UIKit

extension UIButton {
    func setBackgroundColor(_ color: UIColor, for state: UIControl.State) {
        UIGraphicsBeginImageContext(CGSize(width: 1.0, height: 1.0))
        guard let context = UIGraphicsGetCurrentContext() else { return }
        context.setFillColor(color.cgColor)
        context.fill(CGRect(x: 0.0, y: 0.0, width: 1.0, height: 1.0))
        
        let backgroundImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
         
        self.setBackgroundImage(backgroundImage, for: state)
    }
    
    func alignTextBelow(spacing: CGFloat = 4.0) {
        guard let image = self.imageView?.image else { return }
        guard let titleLabel = self.titleLabel else { return }
        guard let titleText = titleLabel.text else { return }
        
        let titleSize = titleText.size(withAttributes: [NSAttributedString.Key.font: titleLabel.font as Any])
        self.titleEdgeInsets = UIEdgeInsets(top: spacing, left: -image.size.width, bottom: -image.size.height, right: 0)
        self.imageEdgeInsets = UIEdgeInsets(top: -(titleSize.height + spacing), left: 0, bottom: 0, right: -titleSize.width)
    }
}
