//
//  WrongAnswerView.swift
//  EarTraining
//
//  Created by 김민종 on 2023/08/02.
//

import UIKit

import SnapKit

final class WrongAnswerView: UIView {
    
    private let image: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.image = UIImage(named: "SoundWrong")
        return image
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .Roboto_B32
        label.textColor = .label
        label.text = "다시 해봐요!"
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        self.isHidden = true
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func setupView() {
        self.addSubview(image)
        self.addSubview(titleLabel)
        self.backgroundColor = .white
        
        image.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(image.snp.bottom).offset(-10)
        }
    }
}
