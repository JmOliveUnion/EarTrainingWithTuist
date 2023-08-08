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
        label.text = "소리기억".localized
        label.font = .Roboto_B24
        label.textColor = .label
        return label
    }()
    
    private let subTitleViewFirst: UIView = {
        let view = UIView()
        let label = UILabel()
        label.text = "집중력"
        label.font = .Roboto_R12
        label.textColor = .l_gray1000
        view.addSubview(label)
        label.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
        
        view.snp.makeConstraints {
            $0.width.equalTo(45)
            $0.height.equalTo(17)
        }
        
        view.backgroundColor = .l_gray900
        view.layer.cornerRadius = 5
        return view
    }()
    
    private let subTitleViewSecond: UIView = {
        let view = UIView()
        let label = UILabel()
        label.text = "인지력"
        label.font = .Roboto_R12
        label.textColor = .l_gray1000
        view.addSubview(label)
        label.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
        
        view.snp.makeConstraints {
            $0.width.equalTo(45)
            $0.height.equalTo(17)
        }
        
        view.backgroundColor = .l_gray900
        view.layer.cornerRadius = 5
        return view
    }()
    
    private let subTitleViewThird: UIView = {
        let view = UIView()
        let label = UILabel()
        label.text = "기억력"
        label.font = .Roboto_R12
        label.textColor = .l_gray1000
        view.addSubview(label)
        label.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
        
        view.snp.makeConstraints {
            $0.width.equalTo(45)
            $0.height.equalTo(17)
        }
        
        view.backgroundColor = .l_gray900
        view.layer.cornerRadius = 5
        return view
    }()
    
    private lazy var subTitleStack: UIStackView = {
      let stack = UIStackView(arrangedSubviews: [subTitleViewFirst, subTitleViewSecond, subTitleViewThird])
        stack.spacing = 5
        return stack
    }()
    
    let playButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: Image.rightArrow.rawValue), for: .normal)
        button.setTitle("도전하기".localized, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.setTitleColor(.l_keyBlue, for: .normal)
        button.semanticContentAttribute = .forceRightToLeft
        return button
    }()
    
    private let scoreTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "최고점수".localized
        label.font = .Roboto_R14
        label.textColor = .l_gray100
        return label
    }()
    
    private lazy var scoreLabel: UILabel = {
        let label = UILabel()
        label.text = "\(self.score)"
        label.font = .Roboto_B24
        label.textColor = .label
        return label
    }()

    private lazy var blurView: UIView = {
        let view = UIView()
        
        let image = UIImageView()
        image.image = UIImage(named: "locker")
        image.contentMode = .scaleAspectFit
        
        let label = UILabel()
        label.text = "공개 예정"
        label.font = .Roboto_B20
        
        // Blur
        view.backgroundColor = .white.withAlphaComponent(0.5)
        // 2
        let blurEffect = UIBlurEffect(style: .regular)
        // 3
        let blurView = UIVisualEffectView(effect: blurEffect)
        // 4
        blurView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        blurView.translatesAutoresizingMaskIntoConstraints = false
        blurView.backgroundColor = .white.withAlphaComponent(0.5)
        blurView.layer.cornerRadius = 20
        blurView.layer.masksToBounds = true
        
        view.insertSubview(blurView, at: 0)
        view.layer.cornerRadius = 20
        
        view.addSubview(image)
        image.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().offset(-15)
        }
        view.addSubview(label)
        label.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(image.snp.bottom).offset(10)
        }
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
        layer.cornerRadius = 20
        backgroundColor = .systemBackground
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOpacity = 0.2
        self.layer.shadowOffset = CGSize.zero
        self.layer.shadowRadius = 6
    
        addSubview(imageView)
        imageView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(10)
            $0.top.equalToSuperview().offset(20)
        }
        
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.leading.equalTo(imageView.snp.trailing).offset(10)
            $0.top.equalTo(imageView.snp.top)
        }
        
        addSubview(subTitleStack)
        subTitleStack.snp.makeConstraints {
            $0.leading.equalTo(titleLabel.snp.leading)
            $0.top.equalTo(titleLabel.snp.bottom).offset(0)
            
        }
        
        addSubview(playButton)
        playButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().offset(-20)
            $0.centerY.equalTo(titleLabel.snp.centerY)
        }
        
        addSubview(scoreTitleLabel)
        scoreTitleLabel.snp.makeConstraints {
            $0.top.equalTo(subTitleStack.snp.bottom).offset(15)
            $0.leading.equalTo(imageView.snp.trailing).offset(10)
        }
        
        addSubview(scoreLabel)
        scoreLabel.snp.makeConstraints {
            $0.top.equalTo(scoreTitleLabel.snp.bottom).offset(5)
            $0.leading.equalTo(scoreTitleLabel.snp.leading).offset(0)
            $0.bottom.greaterThanOrEqualToSuperview().offset(-10)
        }
    
        if isLocked {
            // 블러뷰 추가
            addSubview(blurView)
            blurView.snp.makeConstraints {
                $0.edges.equalToSuperview()
            }
        }
    }

}
