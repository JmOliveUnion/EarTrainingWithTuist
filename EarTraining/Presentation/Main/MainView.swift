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
    
    private lazy var headerView = WeekSequenveView(day: .tue)
    let dailyGameView = GameView(day: .mon, image: Image.gameImage1.rawValue, score: 390, isLocked: false)
    let firstGame = GameView(day: .mon, image: Image.gameImage1.rawValue, score: 200)
    let secondGame = GameView(day: .mon, image: Image.gameImage1.rawValue, score: 300)
    let thirdGame = GameView(day: .mon, image: Image.gameImage1.rawValue, score: 100)

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
        label.text = "오늘의 트레이닝".localized
        label.font = .Roboto_B32
        label.textColor = .systemBackground
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "매일매일 함께해요!".localized
        label.font = .Roboto_R16
        label.textColor = .systemBackground
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private let allGamesTitle: UILabel = {
       let label = UILabel()
        label.text = "모든 게임".localized
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
            $0.top.equalTo(contentView.snp.top).offset(-100)
        }
        
        topBlueView.addSubview(headerView)
        headerView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.top.equalToSuperview().offset(130)
            $0.height.equalTo(95)
            $0.width.equalTo(8)
        }
        
        topBlueView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20)
            $0.top.equalTo(headerView.snp.bottom).offset(30)
        }
        
        topBlueView.addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20)
            $0.top.equalTo(titleLabel.snp.bottom).offset(5)
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
            $0.top.equalTo(allGamesTitle.snp.bottom).offset(10)
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
