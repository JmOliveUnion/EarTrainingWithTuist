//
//  TutorialVC1.swift
//  EarTraining
//
//  Created by 김민종 on 2023/07/13.
//

import UIKit
import Combine

import SnapKit

final class TutorialVC1: BaseViewController {
    
    // MARK: - View Properties
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Tutorial_Title1".localized
        label.font = .Roboto_B24
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Tutorial_Description1".localized
        label.font = .Roboto_L16
        label.numberOfLines = 0
        label.textColor = .l_gray100
        label.textAlignment = .center
        return label
    }()
    
    let nextButton = OliveButton(title: "Next".localized)
    
    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        bind()
        hideNavigationBarLine()
    }
    
    // MARK: - View SetUp

    private func setUp() {
        view.backgroundColor = .systemBackground

        view.addSubview(scrollView)
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        scrollView.addSubview(contentView)
        contentView.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.centerX.top.bottom.equalToSuperview()
        }
        
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.leading.equalTo(20)
            $0.trailing.equalTo(-20)
            $0.top.equalToSuperview().offset(UIScreen.main.bounds.height / 3)
        }
        
        contentView.addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints {
            $0.leading.equalTo(20)
            $0.trailing.equalTo(-20)
            $0.top.equalTo(titleLabel.snp.bottom).offset(20)
            $0.bottom.greaterThanOrEqualTo(contentView.snp.bottom).offset(-10)
        }
        
        view.addSubview(nextButton)
        nextButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview().offset(-36)
        }
    }
    
    // MARK: - Combine binding
    
    private func bind() {
        print("BindSucess")
    
        nextButton.tapPublisher
            .sink {[weak self] _ in
                let vc = TutorialVC2()
                self?.navigationController?.pushViewController(vc, animated: true)
                
            }
            .store(in: &cancellableBag)
    }
}
