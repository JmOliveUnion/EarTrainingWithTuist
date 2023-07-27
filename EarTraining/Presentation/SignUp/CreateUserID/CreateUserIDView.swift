//
//  CreateUserIDView.swift
//  EarTraining
//
//  Created by 김민종 on 2023/07/27.
//

import UIKit

import SnapKit

class CreateUserIDView: UIView {

    // MARK: - Properties
    
    private let headerView = NumberSequenceView(order: .one)
    
    let scrollView: UIScrollView = {
      let scrollView = UIScrollView()
      scrollView.translatesAutoresizingMaskIntoConstraints = false
      return scrollView
    }()
    
    let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemBackground
        return view
       }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "signup_text_id_title".localized
        label.font = .Roboto_B32
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
    let idStackView = OliveTextField(title: "signup_id_title".localized, placeHolder: "signup_text_id_phone_email".localized, errorMessage: "signup_text_create_account_error_format".localized)
    
    let passwordStackView: OliveTextField = {
        let stack = OliveTextField(title: "signup_text_create_account_password".localized, placeHolder: "signup_text_password".localized, errorMessage: "signup_text_create_account_error_characters".localized)
        stack.setSecureStyle()
        return stack
    }()
    
    let passwordReEnterStackView: OliveTextField = {
        let stack = OliveTextField(title: "signup_text_create_account_re_password".localized.localized, placeHolder: "signup_text_password_reenter".localized, errorMessage: "signup_text_create_account_error_not_match".localized)
        stack.setSecureStyle()
        return stack
    }()
    
    let doneButton = OliveButton(title: "forgot_password_text_password_reset_done_button".localized)
    
    // MARK: - LifeCycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Do not use Storyboard")
    }
    
    private func setup() {
        backgroundColor = .systemBackground
        
        addSubview(scrollView)
        scrollView.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide)
            $0.bottom.leading.trailing.equalToSuperview()
        }
        
        scrollView.addSubview(contentView)
        contentView.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.centerX.top.bottom.equalToSuperview()
        }
        
        contentView.addSubview(headerView)
        headerView.snp.makeConstraints {
            $0.top.equalTo(contentView.snp.top).offset(20)
            $0.leading.equalTo(contentView.snp.leading).offset(20)
        }
        
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.leading.equalTo(headerView)
            $0.trailing.lessThanOrEqualTo(contentView.snp.trailing).offset(-5)
            $0.top.equalTo(headerView.snp.bottom).offset(20)
        }
        
        contentView.addSubview(idStackView)
        idStackView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.top.equalTo(titleLabel.snp.bottom).offset(40)
        }
        
        contentView.addSubview(passwordStackView)
        passwordStackView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.top.equalTo(idStackView.snp.bottom).offset(20)
        }

        contentView.addSubview(passwordReEnterStackView)
        passwordReEnterStackView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.top.equalTo(passwordStackView.snp.bottom).offset(20)
        }
        
        contentView.addSubview(doneButton)
        doneButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.top.equalTo(passwordReEnterStackView.snp.bottom).offset(40)
            $0.bottom.equalToSuperview().offset(-20)
        }
    }

}
