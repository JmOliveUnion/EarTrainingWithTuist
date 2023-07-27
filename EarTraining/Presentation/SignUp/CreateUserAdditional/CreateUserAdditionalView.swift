//
//  CreateUserAdditionalView.swift
//  EarTraining
//
//  Created by 김민종 on 2023/07/27.
//

import UIKit

import SnapKit

class CreateUserAdditionalView: UIView {
    
//    let loadingIndicator: ProgressView = {
//        let progress = ProgressView(colors: [.label], lineWidth: 5)
//        progress.translatesAutoresizingMaskIntoConstraints = false
//        return progress
//    }()
    
    let createUserScrollView: UIScrollView = {
      let scrollView = UIScrollView()
      scrollView.backgroundColor = .systemBackground
      scrollView.translatesAutoresizingMaskIntoConstraints = false
      return scrollView
    }()
    
    let createUserContentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemBackground
        return view
       }()
    
    
    private let headerView = NumberSequenceView(order: .three)
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "signup_text_additional_info".localized
        label.font = .Roboto_B32
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
    private let subTitleLabel: UILabel = {
        let label = UILabel()
        
        label.text = "signup_text_additional_info_subtitle".localized
        label.font = .Roboto_R16
        label.numberOfLines = 0
        label.textColor = .lightGray
        
        return label
    }()
    
    let emailStackView = OliveTextField(title: "signup_text_exist_email".localized, placeHolder: "example@oliveunion.com", errorMessage: "signup_text_create_account_error_format".localized)
    
    let birthDayStackView = OliveTextField(title: "signup_text_birth".localized, placeHolder: "signup_text_create_account_birth".localized, errorMessage: "")
    
    lazy var birthDayDatePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.addTarget(self, action: #selector(dateChange(datePicker:)), for: .valueChanged)
        datePicker.frame.size = CGSize(width: 0, height: 300)
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.maximumDate = Date()
        
        return datePicker
    }()
    
    private let genderLabel: UILabel = {
       let label = UILabel()
        label.text = "signup_text_create_account_gender".localized
        label.textColor = .label
        label.font = .boldSystemFont(ofSize: 16)
        return label
    }()
    
    lazy var maleButton: UIButton = {
        let maleButton = UIButton()
        maleButton.setTitle("signup_text_male".localized, for: .normal)
        
        maleButton.setTitleColor(.systemGray, for: .normal)
        maleButton.setTitleColor(.label, for: .selected)

        maleButton.setImage(UIImage(named: "radio_circle_"), for: .normal)
        maleButton.setImage(UIImage(named: "radio_circle_fill"), for: .selected)

        maleButton.contentHorizontalAlignment = .left

        return maleButton
    }()
    
    lazy var femaleButton: UIButton = {
        let femaleButton = UIButton()
        femaleButton.setTitle("signup_text_female".localized, for: .normal)
        
        femaleButton.setTitleColor(.systemGray, for: .normal)
        femaleButton.setTitleColor(.label, for: .selected)

        femaleButton.setImage(UIImage(named: "radio_circle_"), for: .normal)
        femaleButton.setImage(UIImage(named: "radio_circle_fill"), for: .selected)

        femaleButton.contentHorizontalAlignment = .left
        
        return femaleButton
    }()
    
    lazy var otherButton: UIButton = {
        let otherButton = UIButton()
        otherButton.setTitle("signup_text_other".localized, for: .normal)
        
        otherButton.setTitleColor(.systemGray, for: .normal)
        otherButton.setTitleColor(.label, for: .selected)

        otherButton.setImage(UIImage(named: "radio_circle_"), for: .normal)
        otherButton.setImage(UIImage(named: "radio_circle_fill"), for: .selected)

        otherButton.contentHorizontalAlignment = .left
                
        return otherButton
    }()
    
    var radioButtons: [UIButton] {
        return [maleButton, femaleButton, otherButton]
    }
    
    private lazy var genderStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [maleButton, femaleButton, otherButton])
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.spacing = 20
        
        return stack
    }()

    
    let doneButton: OliveButton = {
        let button = OliveButton(title: "signup_text_skip".localized)
        button.setTitle("signup_text_create_account_done_button".localized, for: .selected)
        return button
        
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Do not use Storyboard")
    }
    
    private func setup() {
        backgroundColor = .systemBackground
        
        addSubview(createUserScrollView)
        createUserScrollView.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide)
            $0.bottom.leading.trailing.equalToSuperview()
        }
        
        createUserScrollView.addSubview(createUserContentView)
        createUserContentView.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.centerX.top.bottom.equalToSuperview()
        }
        
        createUserContentView.addSubview(headerView)
        headerView.snp.makeConstraints {
            $0.top.equalTo(createUserContentView.snp.top).offset(20)
            $0.leading.equalTo(createUserContentView.snp.leading).offset(20)
            $0.trailing.lessThanOrEqualToSuperview().offset(-5)
        }
        
        createUserContentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.leading.equalTo(headerView)
            $0.trailing.lessThanOrEqualToSuperview().offset(-5)
            $0.top.equalTo(headerView.snp.bottom).offset(20)
        }
        
        createUserContentView.addSubview(subTitleLabel)
        subTitleLabel.snp.makeConstraints {
            $0.leading.equalTo(headerView)
            $0.trailing.lessThanOrEqualToSuperview().offset(-20)
            $0.top.equalTo(titleLabel.snp.bottom).offset(20)
        }
        
        createUserContentView.addSubview(emailStackView)
        emailStackView.snp.makeConstraints {
            $0.leading.equalTo(headerView)
            $0.trailing.equalToSuperview().offset(-20)
            $0.top.equalTo(subTitleLabel.snp.bottom).offset(30)
        }
        
        createUserContentView.addSubview(birthDayStackView)
        birthDayStackView.snp.makeConstraints {
            $0.leading.equalTo(headerView)
            $0.trailing.equalToSuperview().offset(-20)
            $0.top.equalTo(emailStackView.snp.bottom).offset(20)
        }
        birthDayStackView.mainTextField.inputView = birthDayDatePicker
        
        createUserContentView.addSubview(genderLabel)
        genderLabel.snp.makeConstraints {
            $0.leading.equalTo(headerView)
            $0.trailing.equalToSuperview().offset(-20)
            $0.top.equalTo(birthDayStackView.snp.bottom).offset(40)
        }
        
        createUserContentView.addSubview(genderStack)
        genderStack.snp.makeConstraints {
            $0.leading.equalTo(headerView)
            $0.width.equalTo(100)
            $0.top.equalTo(genderLabel.snp.bottom).offset(10)
        }
        
        createUserContentView.addSubview(doneButton)
        doneButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.top.equalTo(genderStack.snp.bottom).offset(40)
            $0.bottom.equalToSuperview().offset(-20)

        }
        
//        createUserContentView.addSubview(loadingIndicator)
//        loadingIndicator.isHidden = true
//        loadingIndicator.snp.makeConstraints {
//            $0.width.height.equalTo(52)
//            $0.center.equalToSuperview()
//        }
    }
    
    //MARK: - DatePicker
    
    func formatDate(date: Date) -> String {
        let formatter: DateFormatter = DateFormatter()
        formatter.timeZone = TimeZone.current
        formatter.calendar = Calendar(identifier: .gregorian)
        switch Locale.current.languageCode {
        case "ko":
            formatter.dateFormat = "yyyy년 MM월dd일"
        case "ja":
            formatter.dateFormat = "yyyy年 MM月dd日"
        default:
            formatter.dateFormat = "dd/MM/yyyy"
        }
        return formatter.string(from: date)
    }
    
    @objc private func dateChange(datePicker: UIDatePicker) {
        birthDayStackView.mainTextField.text = formatDate(date: datePicker.date)
        
    }

}
