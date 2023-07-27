//
//  OliveUnderLineButton.swift
//  EarTraining
//
//  Created by 김민종 on 2023/07/13.
//

import UIKit
import Combine

class UnderLineButton: UIButton {
    
    init(title: String) {
        super.init(frame: .zero)
        self.setTitle(title, for: .normal)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUp() {
        self.setTitleColor(.lightGray, for: .normal)
        let underlineAttribute = [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 19)] as [NSAttributedString.Key: Any]
        let underlineAttributedString = NSAttributedString(string: self.currentTitle!, attributes: underlineAttribute)
        self.setAttributedTitle(underlineAttributedString, for: .normal)
        
    }
    
}
