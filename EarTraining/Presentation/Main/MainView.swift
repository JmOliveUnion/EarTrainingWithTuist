//
//  MainView.swift
//  EarTraining
//
//  Created by 김민종 on 2023/07/26.
//

import UIKit
import Combine

import SnapKit

final class MainView: UIView {
    
    // MARK: - Properties
    
    let dailyGameView = GameView(day: .mon, image: "HomeTab", score: 390)
    let firstGame = GameView(day: .mon, image: "HomeTab", score: 200)
    let secondGame = GameView(day: .mon, image: "HomeTab", score: 300)
    let thirdGame = GameView(day: .mon, image: "HomeTab", score: 100)

    let scrollView: UIScrollView = {
      let scrollView = UIScrollView()
      scrollView.translatesAutoresizingMaskIntoConstraints = false
      return scrollView
    }()
    
    let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .l_gray200
        return view
    }()
    
    let topBlueView: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .l_keyBlue
        view.layer.cornerRadius = 25

        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "today_training_title".localized
        label.font = .Roboto_B40
        label.textColor = .systemBackground
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "today_training_description".localized
        label.font = .Roboto_R18
        label.textColor = .systemBackground
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private let allGamesTitle: UILabel = {
       let label = UILabel()
        label.text = "all_game_title".localized
        label.font = .Roboto_B24
        return label
    }()
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Do not use Storyboard")
    }
    
    private func setUp() {
        backgroundColor = .l_gray200
        
        addSubview(scrollView)
        scrollView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.bottom.leading.trailing.equalToSuperview()
        }
        
        scrollView.addSubview(contentView)
        contentView.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.top.equalToSuperview()
            $0.centerX.bottom.equalToSuperview()
        }
        
        contentView.addSubview(topBlueView)
        topBlueView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(self.safeAreaLayoutGuide).multipliedBy(0.7)
            $0.top.equalTo(contentView.snp.top).offset(-70)
        }
        
        topBlueView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20)
            $0.top.greaterThanOrEqualToSuperview().offset(150)
        }
        
        topBlueView.addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20)
            $0.top.equalTo(titleLabel.snp.bottom).offset(10)
        }
        
        topBlueView.addSubview(dailyGameView)
        dailyGameView.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(150)
            $0.bottom.greaterThanOrEqualToSuperview().offset(-20)
        }
        
        contentView.addSubview(allGamesTitle)
        allGamesTitle.snp.makeConstraints {
            $0.top.equalTo(topBlueView.snp.bottom).offset(40)
            $0.leading.equalToSuperview().offset(20)
        }
        
        contentView.addSubview(firstGame)
        firstGame.snp.makeConstraints {
            $0.top.equalTo(allGamesTitle.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(150)
        }
        
        contentView.addSubview(secondGame)
        secondGame.snp.makeConstraints {
            $0.top.equalTo(firstGame.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(150)
        }

        contentView.addSubview(thirdGame)
        thirdGame.snp.makeConstraints {
            $0.top.equalTo(secondGame.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(150)
            $0.bottom.equalTo(contentView.snp.bottom).offset(-20)
        }
    }
}