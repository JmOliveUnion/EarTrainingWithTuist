//
//  ASChoiceButton.swift
//  EarTraining
//
//  Created by 김민종 on 2023/08/01.
//

import UIKit
import Combine

import SnapKit

class ASChoiceButton: UIButton {

    init(title: String, color: UIColor) {
        super.init(frame: .zero)
        setTitle(title, for: .normal)
        setUp(color: color)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setUp(color: UIColor) {
        self.setTitleColor(color, for: .normal)
        self.setBackgroundColor(.systemBackground, for: .normal)
        self.titleLabel?.font = UIFont.boldSystemFont(ofSize: 40)
        self.layer.shadowOffset =  CGSize(width: 2.0, height: 2.0)
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOpacity = 0.4
        self.layer.shadowRadius = 6

        self.translatesAutoresizingMaskIntoConstraints = false
//        self.clipsToBounds = false
        self.layer.cornerRadius = 30

        self.layer.masksToBounds = false

    }

}
