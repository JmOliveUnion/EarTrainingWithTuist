//
//  ThreeCountdownView.swift
//  EarTraining
//
//  Created by 김민종 on 2023/08/02.
//

import UIKit

import SnapKit

final class ThreeCountdownView: UIView {
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .Roboto_B60
        label.textColor = .systemBackground
        label.text = "3"
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        self.isHidden = false
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    private func setupView() {
        self.backgroundColor = UIColor.black.withAlphaComponent(0.6)

        self.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }
    }
    
    func update(text: String) {
        titleLabel.text = text
    }
}
