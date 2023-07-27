//
//  OliveTextField.swift
//  EarTraining
//
//  Created by 김민종 on 2023/07/27.
//

import UIKit
import Combine

import SnapKit

final class OliveTextField: UIView {
    
    private var cancellabels = Set<AnyCancellable>()
    
    enum TextFieldState {
        case enabled
        case disabled
        case error
    }
    
    @Published var state: TextFieldState = .disabled
    
    private let title: String
    private let placeHolder: String
    private let secondPlaceHolder: String
    private let errorMessage: String
    
    init(title: String, placeHolder: String, errorMessage: String, isDoubleTextField: Bool = false, secondPlaceHolder: String = "") {
        self.title = title
        self.placeHolder = placeHolder
        self.errorMessage = errorMessage
        self.secondPlaceHolder = secondPlaceHolder
        
        super.init(frame: .zero)
        setUp(isDoubleTextField: isDoubleTextField)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var titleLabel: LabelWithPadding =  {
        let label = LabelWithPadding(top: 0, bottom: 0, left: 20, right: 0)
        label.text = title.localized
        label.textColor = .label
        label.font = .Roboto_B14
        return label
    }()
    
    private lazy var secondTitleLabel: LabelWithPadding =  {
        let label = LabelWithPadding(top: 0, bottom: 0, left: 20, right: 0)
        label.text = "signup_text_last_name".localized
        label.textColor = .label
        label.font = .Roboto_B14
        return label
    }()
    
    lazy var mainTextField: UITextField =  {
        let textField = UITextField()
        textField.textColor = .label
        textField.font = UIFont.systemFont(ofSize: 18)
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: textField.frame.height))
        textField.leftViewMode = .always
        textField.layer.borderWidth = 1.0
        textField.layer.borderColor = UIColor.systemGray.cgColor
        textField.layer.cornerRadius = 15
        textField.attributedPlaceholder = NSAttributedString(string: placeHolder.localized, attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemGray])
        textField.clearButtonMode = .whileEditing
        
        let action = UIAction(image: UIImage(named: "ic_x_button")) { [weak self] _ in
            textField.text = ""
        }
        
        let button = UIButton(type: .custom, primaryAction: action)
        button.setImage(UIImage(named: "ic_x_button"), for: .normal)
        
        button.imageEdgeInsets = .init(top: 5, left: -20, bottom: 5, right: 30)
        button.frame = .init(origin: .zero, size: CGSize(width: 5, height: 5))
        
        textField.rightView = button
        textField.rightViewMode = .whileEditing
        
        textField.snp.makeConstraints {
            $0.height.equalTo(60)
        }
        addToolBar(to: textField)
        
        return textField
    }()
    
    lazy var subTextField: UITextField =  {
        let textField = UITextField()
        textField.textColor = .label
        textField.font = UIFont.systemFont(ofSize: 18)
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: textField.frame.height))
        textField.leftViewMode = .always
        textField.layer.borderWidth = 1.0
        textField.layer.borderColor = UIColor.systemGray.cgColor
        textField.layer.cornerRadius = 15
        textField.attributedPlaceholder = NSAttributedString(string: secondPlaceHolder.localized, attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemGray])
        textField.clearButtonMode = .whileEditing
        textField.snp.makeConstraints {
            $0.height.equalTo(60)
        }
        
        addToolBar(to: textField)
        
        return textField
    }()
    
    lazy var errorLabel: LabelWithPadding = {
        let label = LabelWithPadding(top: 0, bottom: 0, left: 20, right: 0)
        label.text = errorMessage.localized
        label.textColor = .red
        label.font = .Roboto_L14
        label.isHidden = true
        return label
    }()
    
    private lazy var containerStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [titleLabel, mainTextField, errorLabel])
        stack.axis = .vertical
        stack.spacing = 5
        return stack
    }()
    
    private lazy var doubleTextFieldContainer: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [mainTextField, subTextField])
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.spacing = 5
        return stack
    }()
    
    private lazy var doubleTitleContainer: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [titleLabel, secondTitleLabel])
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.spacing = 5
        
        return stack
    }()
    
    private lazy var doubleFieldContainerStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [doubleTitleContainer, doubleTextFieldContainer, errorLabel])
        stack.axis = .vertical
        stack.spacing = 5
        return stack
    }()
    
    private func setUp(isDoubleTextField: Bool) {
        
        if isDoubleTextField {
            addSubview(doubleFieldContainerStackView)
            doubleFieldContainerStackView.snp.makeConstraints {
                $0.edges.equalToSuperview()
            }
        } else {
            addSubview(containerStackView)
            containerStackView.snp.makeConstraints {
                $0.edges.equalToSuperview()
            }
        }
        
        self.$state.sink { [weak self] value in
            switch value {
            case .disabled:
                self?.disabled()
            case .enabled:
                self?.enabled()
            case .error:
                self?.error()
            }
        }.store(in: &cancellabels)
    }
    
    private func disabled() {
        titleLabel.textColor = .systemGray
        secondTitleLabel.textColor = .systemGray
        
        mainTextField.layer.borderColor = UIColor.systemGray.cgColor
        subTextField.layer.borderColor = UIColor.systemGray.cgColor
        errorLabel.fadeOut()
    }
    
    private func enabled() {
        titleLabel.textColor = .label
        secondTitleLabel.textColor = .label
        
        mainTextField.layer.borderColor = UIColor.label.cgColor
        subTextField.layer.borderColor = UIColor.label.cgColor
        errorLabel.fadeOut()
    }
    
    private func error() {
        titleLabel.textColor = .red
        secondTitleLabel.textColor = .red
        
        mainTextField.layer.borderColor = UIColor.red.cgColor
        subTextField.layer.borderColor = UIColor.red.cgColor
        errorLabel.fadeIn()
    }
    
    func setSecureStyle() {
        mainTextField.isSecureTextEntry = true
        mainTextField.clearButtonMode = .never
        let action = UIAction(image: UIImage(named: "arrow")) { [weak self] _ in
            self?.mainTextField.isSecureTextEntry.toggle()
        }
        
        let button = UIButton(type: .custom, primaryAction: action)
        button.addTarget(self, action: #selector(changeButtonImage), for: .touchUpInside)
        button.setImage(UIImage(named: "ic_eye_closed"), for: .normal)
        button.setImage(UIImage(named: "arrow"), for: .focused)
        button.setImage(UIImage(named: "arrow"), for: .highlighted)
        button.setImage(UIImage(named: "arrow"), for: .application)
        button.imageEdgeInsets = .init(top: 0, left: -30, bottom: 0, right: 20)
        button.frame = .init(origin: .zero, size: CGSize(width: 30, height: 30))
        mainTextField.rightView = button
        mainTextField.rightViewMode = .always
    }
    
    @objc func changeButtonImage() {
        print("hihi")
    }
    
    func setRightView() {
        let action = UIAction(image: UIImage(named: "arrow")) { _ in
            
        }
        
        let button = UIButton(type: .custom, primaryAction: action)
        button.setImage(UIImage(named: "arrow"), for: .normal)
        
        button.imageEdgeInsets = .init(top: 0, left: -30, bottom: 0, right: 0)
        button.frame = .init(origin: .zero, size: CGSize(width: 30, height: 30))
        mainTextField.rightView = button
        mainTextField.rightViewMode = .always
    }
    
    private func addToolBar(to textfield: UITextField) {
        let bar = UIToolbar()
        let done = UIBarButtonItem(title: "signup_text_create_account_done_button".localized, style: .plain, target: self, action: #selector(doneBtnTapped))
        done.tintColor = .label
        bar.items = [.flexibleSpace(), done]
        bar.sizeToFit()
        textfield.inputAccessoryView = bar
    }
    
    @objc private func doneBtnTapped() {
        mainTextField.resignFirstResponder()
        subTextField.resignFirstResponder()
    }
    
    // MARK: - Timer
    
    var timer: Timer?
    var secondsLeft = 100
    
    func setTimer() {
        let label = UILabel()
        label.text = String(secondsLeft)
        label.textColor = .red
        label.textAlignment = .left
        
        mainTextField.rightView = label
        mainTextField.rightViewMode = .always
        
        for i in 0...secondsLeft {
            if i > 0 {
                startTimer()
            } else {
                stopTimer()
            }
        }
    }
    
    func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            if self.secondsLeft == 0 {
                self.timer?.invalidate()
                self.timer = nil
                
            } else {
                self.secondsLeft -= 1
                
            }
        }
    }
    
    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
}

