//
//  CreateUserNameView.swift
//  EarTraining
//
//  Created by 김민종 on 2023/07/27.
//

import UIKit

import SnapKit
import CountryPickerView

final class CreateUserNameView: UIView {
    
    let userNameScrollView: UIScrollView = {
      let scrollView = UIScrollView()
      scrollView.backgroundColor = .systemBackground
      scrollView.translatesAutoresizingMaskIntoConstraints = false
      return scrollView
    }()
    
    let userNameContentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemBackground
        return view
       }()
    
    private let headerView = NumberSequenceView(order: .two)
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "signup_text_name_phone_title".localized
        label.font = .Roboto_B32
        label.numberOfLines = 3
        label.textAlignment = .left
        return label
    }()
    
    let nameStackView = OliveTextField(title: "signup_text_name".localized, placeHolder: "signup_text_create_account_first_name".localized, errorMessage: "signup_text_create_account_error_format".localized, isDoubleTextField: true, secondPlaceHolder: "signup_text_create_account_last_name".localized)
    
    private lazy var countryName: UILabel = {
        let label = UILabel()
        label.text = "signup_text_country".localized
        label.font = .Roboto_B16
        label.textColor = .label
        return label
    }()

    lazy var countryPicker: CountryPickerView = {
        let view = CountryPickerView()
        view.textColor = .label
        return view
    }()
    
    lazy var countryView: UIView = {
        let view = UIView()
        
        view.addSubview(countryPicker)
        
        countryPicker.snp.makeConstraints {
            $0.leading.equalTo(view.snp.leading).offset(20)
            $0.trailing.equalTo(-20)
            $0.centerY.equalToSuperview()
        }
        
        view.layer.borderColor = UIColor.label.cgColor
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 15
        
        view.snp.makeConstraints {
            $0.width.equalTo(140)
//            $0.height.equalTo(60)
        }
        return view
    }()
    
    private lazy var countryStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [countryName, countryView])
        stack.axis = .vertical
        stack.spacing = 5
        return stack
        
    }()
    
    let phoneNumberView: OliveTextField = {
        let textField = OliveTextField(title: "signup_text_phone_box".localized, placeHolder: "123456", errorMessage: "")
        textField.errorLabel.isHidden = true
        textField.mainTextField.keyboardType = UIKeyboardType.numberPad
        return textField
        
    }()
    
    private lazy var phoneView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [countryStack, phoneNumberView])
        stack.axis = .horizontal
        stack.distribution = .fillProportionally
        stack.spacing = 5
        return stack
    }()
    
    let timeLabel: UILabel = {
        let label = UILabel()
        label.text = "00 : 00"
        label.font = .Roboto_L16
        label.textColor = .red
        return label
    }()
    
    lazy var phoneErrorMessageLabel: UILabel = {
        let label = LabelWithPadding(top: 0, bottom: 0, left: 20, right: 0)
        label.text = "signup_text_error_phone_number".localized
        label.textColor = .red
        label.font = .Roboto_L14
        label.isHidden = true
        
        return label
        
    }()
    
    private lazy var phoneViewWithErrorMessage: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [phoneView, phoneErrorMessageLabel])
        stack.axis = .vertical
        stack.distribution = .fillProportionally
        stack.spacing = 0
        return stack
    }()
    
    lazy var smsView: OliveTextField = {
        var textField = OliveTextField(title: "signup_text_sms_code".localized, placeHolder: "123456", errorMessage: "")
        let view = UIView()
        view.addSubview(timeLabel)
        timeLabel.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        textField.mainTextField.addSubview(view)
        view.snp.makeConstraints {
            $0.width.equalTo(70)
            $0.height.equalTo(30)
            $0.trailing.equalTo(textField.snp.trailing).offset(-10)
            $0.centerY.equalToSuperview()
        }
        
        textField.isHidden = true
        textField.mainTextField.keyboardType = UIKeyboardType.numberPad
        return textField
    }()
    
    lazy var authStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [phoneViewWithErrorMessage, smsView])
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.spacing = 15
        return stack
    }()
    
    let doneButton: OliveButton = {
        let button = OliveButton(title: "signup_text_phone_sms_code_box".localized)
        
        return button
    }()

    lazy var doneButtonStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [doneButton, resendStackView])
        stack.axis = .vertical
        stack.spacing = 20
        return stack
    }()
    
    let didNotReceivedLabel: UILabel = {
        let label = UILabel()
        label.text = "signup_text_resend_button0".localized
        label.font = .Roboto_L14
        return label
    }()
    
    lazy var didNotReceiveStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [didNotReceivedLabel, resendButton])
        stack.distribution = .fillProportionally
        stack.spacing = 0
        return stack
    }()
    
    let resendButton: UnderLineButton = {
        let button = UnderLineButton(title: "signup_text_resend_button1".localized)
        button.setTitleColor(UIColor.blue, for: .normal)
        return button
    }()
    
    let fiveTimesAlertLabel: UILabel = {
        let label = UILabel()
        label.text = "signup_text_noti_sms_code_resend".localized
        label.font = .Roboto_L14
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
    lazy var resendStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [didNotReceiveStackView, fiveTimesAlertLabel])
        stack.axis = .vertical
        stack.spacing = 5
        stack.isHidden = true
        
        return stack
    }()

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
        
        addSubview(userNameScrollView)
        userNameScrollView.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide)
            $0.bottom.leading.trailing.equalToSuperview()
        }
        
        userNameScrollView.addSubview(userNameContentView)
        userNameContentView.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.centerX.top.bottom.equalToSuperview()
        }
        
        userNameContentView.addSubview(headerView)
        headerView.snp.makeConstraints {
            $0.top.equalTo(userNameContentView.snp.top).offset(20)
            $0.leading.equalTo(userNameContentView.snp.leading).offset(20)
        }
        
        userNameContentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.leading.equalTo(headerView)
            $0.trailing.lessThanOrEqualToSuperview().offset(-5)
            $0.top.equalTo(headerView.snp.bottom).offset(20)
        }
        
        userNameContentView.addSubview(nameStackView)
        nameStackView.snp.makeConstraints {
            $0.leading.equalTo(headerView)
            $0.trailing.equalToSuperview().offset(-20)
            $0.top.equalTo(titleLabel.snp.bottom).offset(40)
        }
        
        userNameContentView.addSubview(authStack)
        authStack.snp.makeConstraints {
            $0.leading.equalTo(headerView)
            $0.trailing.equalToSuperview().offset(-20)
            $0.top.equalTo(nameStackView.snp.bottom).offset(25)
        }
        
        userNameContentView.addSubview(doneButtonStack)
        doneButtonStack.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.top.equalTo(authStack.snp.bottom).offset(40)
            $0.bottom.lessThanOrEqualToSuperview().offset(-5)
        }
        
    }
}
