//
//  GameView.swift
//  EarTraining
//
//  Created by 김민종 on 2023/07/26.
//

import UIKit

import SnapKit

class GameView: UIView {
    enum Day: String, CaseIterable {
        case mon = "1"
        case tue = "2"
        case wed = "3"
        case thu = "4"
        case fri = "5"
        case sat = "6"
        case sun = "7"
    }
    
    private let day: Day
    private let image: String
    private let score: Int

    // MARK: - Properties
    private lazy var imageView: UIImageView = {
       let image = UIImageView()
        image.image = UIImage(named: "\(self.image)")
        image.contentMode = .scaleAspectFit
        return image
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "game_title1".localized
        label.font = .Roboto_B28
        label.textColor = .label
        label.numberOfLines = 0
        return label
    }()
    
    let playButton: UIButton = {
        let button = UIButton()
       
        button.setImage(UIImage(named: "HomeTab"), for: .normal)
        button.setTitle("play_title".localized, for: .normal)
        button.setTitleColor(.l_keyBlue, for: .normal)
        
        button.semanticContentAttribute = .forceRightToLeft
        return button
    }()
    
    private let scoreTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "high_score".localized
        label.font = .Roboto_R16
        label.textColor = .l_gray100
        return label
    }()
    
    private lazy var scoreLabel: UILabel = {
        let label = UILabel()
        label.text = "\(self.score)"
        label.font = .Roboto_B28
        label.textColor = .label
        return label
    }()

    private lazy var blurView: UIView = {
        let view = UIView()
        // Blur
//        let blurEffect = UIBlurEffect(style: .systemUltraThinMaterial)
//        let blurView = UIVisualEffectView(effect: blurEffect)
//        blurView.frame = view.bounds
//        blurView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//        blurView.alpha = 1
//        view.insertSubview(blurView, at: 0)
//        view.addSubview(blurView)
//        view.layer.zPosition = 1
//        view.layer.cornerRadius = 25

        return view
    }()
    
    // MARK: - Life Cycle
    
    init(day: Day, image: String, score: Int, isLocked: Bool = true) {
        self.day = day
        self.image = image
        self.score = score
        super.init(frame: .zero)
        
        setUp(isLocked: isLocked)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUp(isLocked: Bool) {
        backgroundColor = .white
        layer.cornerRadius = 20
        
        if isLocked {
            // 블러뷰 추가
            addSubview(blurView)
            blurView.snp.makeConstraints {
                $0.edges.equalToSuperview()
            }
        }
        
        addSubview(imageView)
        imageView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20)
            $0.top.equalToSuperview().offset(20)
        }
        
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.leading.equalTo(imageView.snp.trailing).offset(10)
            $0.top.equalTo(imageView.snp.top)
        }
        
        addSubview(playButton)
        playButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().offset(-20)
            $0.top.equalToSuperview().offset(20)
        }
        
        addSubview(scoreTitleLabel)
        scoreTitleLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(30)
            $0.leading.equalTo(imageView.snp.trailing).offset(10)
        }
        
        addSubview(scoreLabel)
        scoreLabel.snp.makeConstraints {
            $0.top.equalTo(scoreTitleLabel.snp.bottom).offset(5)
            $0.leading.equalTo(scoreTitleLabel.snp.leading).offset(0)
            $0.bottom.greaterThanOrEqualToSuperview().offset(-5)
        }
    }
}
