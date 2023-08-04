//
//  AuditoryStroopDoneView.swift
//  EarTraining
//
//  Created by 김민종 on 2023/08/03.
//

import UIKit
import Combine

import SnapKit

final class AuditoryStroopDoneView: UIView {
    
    private var cancellableBag = Set<AnyCancellable>()

    private let image: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.image = UIImage(named: "AuditoryStroopDone")
        return image
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .Roboto_B32
        label.textColor = .label
        label.text = "잘 했어요!"
        return label
    }()
    
    private let myScoreTitle: UILabel = {
        let label = UILabel()
        label.font = .Roboto_R18
        label.textColor = .l_gray700
        label.text = "최종 점수"
        return label
    }()
    
    let myScore: UILabel = {
        let label = UILabel()
        label.font = .Roboto_B32
        label.textColor = .l_gray700
        label.text = "1000"
        return label
    }()
    
    let retryButton: UIButton = {
        let button = UIButton()
        button.setTitle("다시하기", for: .normal)
        button.titleLabel?.font = .Roboto_R30
        button.backgroundColor = .l_keyBlue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 15
        return button
    }()
    
    let stopButton: UIButton = {
        let button = UIButton()
        button.setTitle("그만하기", for: .normal)
        button.titleLabel?.font = .Roboto_R30
        button.backgroundColor = .white
        button.setTitleColor(.l_keyBlue, for: .normal)
        button.layer.borderColor = UIColor.l_keyBlue.cgColor
        button.layer.cornerRadius = 13
        button.layer.borderWidth = 1
        return button
    }()
    
    private lazy var buttonStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [stopButton, retryButton])
        stack.spacing = 10
        stack.distribution = .fillEqually
        return stack
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
        self.backgroundColor = .white
        self.addSubview(image)
        
        image.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().offset(-30)
        }
        
        self.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(image.snp.bottom).offset(20)
        }
        
        self.addSubview(myScoreTitle)
        myScoreTitle.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(titleLabel.snp.bottom).offset(20)
        }
        
        self.addSubview(myScore)
        myScore.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(myScoreTitle.snp.bottom).offset(10)
        }
        
        self.addSubview(buttonStackView)
        buttonStackView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview().offset(-50)
            $0.height.equalTo(60)
        }
    }
}
