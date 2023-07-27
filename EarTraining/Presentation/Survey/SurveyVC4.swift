//
//  SurveyVC4.swift
//  EarTraining
//
//  Created by 김민종 on 2023/07/25.
//

import UIKit
import Combine

import SnapKit

class SurveyVC4: BaseViewController {
    
    // MARK: - View Properties
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Survey_Title2".localized
        label.font = .Roboto_B24
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private let firstButton: OliveButton = {
        let button = OliveButton(title: "Survey_button1".localized)
        return button
    }()
    
    private let secondButton: OliveButton = {
        let button = OliveButton(title: "Survey_button2".localized)
        button.isEnabled = false
        return button
    }()
    
    private let thirdButton: OliveButton = {
        let button = OliveButton(title: "Survey_button3".localized)
        button.isEnabled = false
        return button
    }()
    
    private lazy var buttonStack: UIStackView = {
       let stack = UIStackView(arrangedSubviews: [firstButton, secondButton, thirdButton])
        stack.axis = .vertical
        stack.spacing = 15
        
        return stack
    }()
    
    private let nextButton = OliveButton(title: "Next".localized)

    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        bind()
        setNavigationBackButton()
    }
    
    // MARK: - SetUp View
    
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
            $0.top.equalToSuperview().offset(UIScreen.main.bounds.height / 15)
        }
        
        contentView.addSubview(buttonStack)
        buttonStack.snp.makeConstraints {
            $0.leading.equalTo(20)
            $0.trailing.equalTo(-20)
            $0.top.equalTo(titleLabel.snp.bottom).offset(40)
        }
        
        view.addSubview(nextButton)
        nextButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview().offset(-50)
        }
    }
    
    // MARK: - Binding
    
    private func bind() {
        print("BindSucess")
    
        nextButton.tapPublisher
            .sink {[weak self] _ in
                let vc = SurveyVC5()
                self?.navigationController?.pushViewController(vc, animated: true)
            }
            .store(in: &cancellableBag)
    }
    
}
