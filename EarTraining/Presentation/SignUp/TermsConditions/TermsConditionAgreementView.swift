//
//  TermsConditionAgreementView.swift
//  EarTraining
//
//  Created by 김민종 on 2023/07/27.
//

import UIKit
import Combine

import SnapKit

final class TermsConditionAgreementView: UIView {
    
    private var cancellables = Set<AnyCancellable>()
    
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(light: .white, dark: .d_gray400)
        view.layer.cornerRadius = 16
        view.clipsToBounds = true
        return view
    }()
    
    private let dimmedView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.alpha = .zero
        return view
    }()
    
    private let roundView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.layer.borderWidth = 1.0
        view.layer.borderColor = UIColor.label.cgColor
        view.layer.cornerRadius = 10
        view.snp.makeConstraints {
            $0.height.equalTo(60)
        }

        return view
    }()
    
    // Top
    
    let xButton: UIButton = {
       let button = UIButton()
        button.setImage(UIImage(named: ""), for: .normal)
        return button
    }()
    
    private lazy var topStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [topCheckButton, topLabel])
        stack.spacing = 5
        return stack
    }()
    
    let topCheckButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "ic_uncheck"), for: .normal)
        button.setImage(UIImage(named: "ic_checked"), for: .selected)
        return button
    }()
    
    private let topLabel: UILabel = {
        let label = UILabel()
        label.text = "login_text_permission_all_agree_title".localized
        return label
    }()
    
    // Middle
    
    private lazy var middleStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [middleCheckButton, privacyButton, andLabel, termsConditionsButton])
        stack.spacing = 5
        return stack
    }()
    
    let middleCheckButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "ic_uncheck"), for: .normal)
        button.setImage(UIImage(named: "ic_checked"), for: .selected)
        return button
    }()
    
    let privacyButton: UIButton = {
        let button = UIButton()
                
        let normalAttribute = NSAttributedString(
            string: "tutoril_text_permission7".localized,
            attributes: [.underlineStyle: NSUnderlineStyle.single.rawValue, .foregroundColor: UIColor.lightGray]
        )
        
        let selectedAttribute = NSAttributedString(
            string: "tutoril_text_permission7".localized,
            attributes: [.underlineStyle: NSUnderlineStyle.single.rawValue, .foregroundColor: UIColor.label]
        )
        
        button.setAttributedTitle(normalAttribute, for: .normal)
        button.setAttributedTitle(selectedAttribute, for: .selected)
        
        return button
    }()
    
    private let andLabel: UILabel = {
        let label = UILabel()
        label.text = "signup_text_and".localized
        label.textColor = .lightGray
        return label
    }()
    
    let termsConditionsButton: UIButton = {
        let button = UIButton()
                
        let normalAttribute = NSAttributedString(
            string: "settings_text_policy".localized,
            attributes: [.underlineStyle: NSUnderlineStyle.single.rawValue, .foregroundColor: UIColor.lightGray]
        )
        
        let selectedAttribute = NSAttributedString(
            string: "settings_text_policy".localized,
            attributes: [.underlineStyle: NSUnderlineStyle.single.rawValue, .foregroundColor: UIColor.label]
        )
        
        button.setAttributedTitle(normalAttribute, for: .normal)
        button.setAttributedTitle(selectedAttribute, for: .selected)
        
        return button
    }()
    
    // Bottom
    
    private lazy var bottomStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [bottomCheckButton, marketingButton])
        stack.spacing = 5
        return stack
    }()
    
    let bottomCheckButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "ic_uncheck"), for: .normal)
        button.setImage(UIImage(named: "ic_checked"), for: .selected)
        return button
    }()
    
    let marketingButton: UIButton = {
        let button = UIButton()
        
        let normalAttribute = NSAttributedString(
            string: "tutoril_text_permission_marketing_push_title1".localized,
            attributes: [.underlineStyle: NSUnderlineStyle.single.rawValue, .foregroundColor: UIColor.lightGray]
        )
        
        let selectedAttribute = NSAttributedString(
            string: "tutoril_text_permission_marketing_push_title1".localized,
            attributes: [.underlineStyle: NSUnderlineStyle.single.rawValue, .foregroundColor: UIColor.label]
        )
        
        button.setAttributedTitle(normalAttribute, for: .normal)
        button.setAttributedTitle(selectedAttribute, for: .selected)
        return button
    }()
    
    let agreeButton = OliveButton(title: "login_text_permission_done_button")
    
    private var heightConstraint: NSLayoutConstraint?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
        bind()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // setup
    private func setup() {
        addSubview(dimmedView)
        dimmedView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        addSubview(containerView)
        containerView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
        containerView.addSubview(xButton)
        xButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().offset(-20)
            $0.top.equalToSuperview().offset(10)
        }
        
        containerView.addSubview(roundView)
        roundView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(15)
            $0.top.equalTo(xButton.snp.bottom).offset(10)
        }
        
        containerView.addSubview(topStackView)
        topStackView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(30)
            $0.centerY.equalTo(roundView)
        }
        
        containerView.addSubview(middleStackView)
        middleStackView.snp.makeConstraints {
            $0.leading.equalTo(topStackView)
            $0.trailing.lessThanOrEqualToSuperview().offset(-5)
            $0.top.equalTo(roundView.snp.bottom).offset(20)
        }
        
        containerView.addSubview(bottomStackView)
        bottomStackView.snp.makeConstraints {
            $0.leading.equalTo(topStackView)
            $0.trailing.lessThanOrEqualToSuperview().offset(-5)
            $0.top.equalTo(middleStackView.snp.bottom).offset(20)
        }
        
        agreeButton.isEnabled = false
        containerView.addSubview(agreeButton)
        agreeButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.bottom.equalTo(safeAreaLayoutGuide).inset(30)
        }
        
        heightConstraint = containerView.heightAnchor.constraint(equalToConstant: .zero)
        heightConstraint?.isActive = true
    }
    
    private func bind() {
   
    }
    
    // Show Half Modal animation
    func showBottomContainerView() {
        UIView.animate(withDuration: 0.3) {
            self.heightConstraint?.constant = UIScreen.main.bounds.height / 2
            self.dimmedView.alpha = 0.6
            self.layoutIfNeeded()
        }
    }
    
    // Hide Modal Dismiss animation
    func dismissWithAnimation(completion: (() -> Void)? = nil) {
        UIView.animate(withDuration: 0.3) {
            self.heightConstraint?.constant = .zero
            self.dimmedView.alpha = .zero
            self.layoutIfNeeded()
        } completion: { _ in
            completion?()
        }
    }
    
    // top content를 업데이트 + middle, bottom content도 업데이트
    func updateTopContent() {
        let newState = !topCheckButton.isSelected
        
        topCheckButton.isSelected = newState
        topLabel.textColor = newState ? .label : .lightGray
        
        updateMiddleContent(to: newState)
        updateBottomContent(to: newState)
    }
    
    // middle content를 업데이트
    func updateMiddleContent(to state: Bool) {
        middleCheckButton.isSelected = state
        privacyButton.isSelected = state
        termsConditionsButton.isSelected = state
        
        andLabel.textColor = state ? .label : .lightGray
        agreeButton.isEnabled = state
        
        updateTop()
    }
    
    // bottom content를 업데이트
    func updateBottomContent(to state: Bool) {
        bottomCheckButton.isSelected = state
        marketingButton.isSelected = state
        
        updateTop()
    }
    
    // 두번째, 세번째 버튼을 눌렀을때, 첫번째 버튼 상태를 업데이트
    private func updateTop() {
        let state = middleCheckButton.isSelected && bottomCheckButton.isSelected
        topCheckButton.isSelected = state
        topLabel.textColor = state ? .label : .lightGray
    }
}
