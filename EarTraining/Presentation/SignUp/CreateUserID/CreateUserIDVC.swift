//
//  CreateUserIDVC.swift
//  EarTraining
//
//  Created by 김민종 on 2023/07/27.
//

import UIKit
import Combine

class CreateUserIDVC: BaseViewController {

    // MARK: - Properties
//    var providerValue : LoginStatus!
//    var userDatas : addUserDatasUpdate!
    
    // MARK: - LifeCycle
    override func loadView() {
        super.loadView()
        view = CreateUserIDView(frame: view.frame)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        bind()
        dismissKeyboardWhenTappedAround()
    }
    
    private func setup() {
        setNavigationBackButton()
        hideNavigationBarLine()
//        setupKeyboardHiding()
    }
    
    private func bind() {
        guard let mainView = view as? CreateUserIDView else {
            return assertionFailure("MainView is not Exist")
        }
//
//        mainView.idStackView.mainTextField.startEditing
//            .sink { tf in
//                mainView.idStackView.state = .enabled
//            }
//            .store(in: &cancellableBag)
//
//        mainView.idStackView.mainTextField.endEditing
//            .sink { tf in
//                if isPhoneNumber(numberStr: mainView.idStackView.mainTextField.text ?? "") {
//                    self.checkExistPhone()
//                } else {
//                    self.checkExistEmail()
//                }
//
//                mainView.idStackView.errorLabel.text = "signup_text_create_account_error_format".localized
//                mainView.idStackView.state = isValidEmail(eamilStr: tf.text ?? "") || isPhoneNumber(numberStr: tf.text ?? "") ? .enabled : .error
//
//                if mainView.passwordReEnterStackView.state == .enabled && mainView.passwordStackView.state == .enabled && (isValidEmail(eamilStr: tf.text ?? "") || isPhoneNumber(numberStr: tf.text ?? "")) && mainView.idStackView.state == .enabled && (mainView.passwordStackView.mainTextField.text == mainView.passwordReEnterStackView.mainTextField.text) {
//                    mainView.doneButton.buttonState = .enabled
//                } else {
//                    mainView.doneButton.buttonState = .disabled
//                }
//            }
//            .store(in: &cancellableBag)
//
//        mainView.passwordStackView.mainTextField.startEditing
//            .sink { tf in
//                mainView.passwordStackView.state = .enabled
//            }
//            .store(in: &cancellableBag)
//
//        mainView.passwordStackView.mainTextField.endEditing
//            .sink { tf in
//                mainView.passwordStackView.state = validPassword(mypassword: tf.text ?? "") ? .enabled : .error
//
//                if mainView.passwordReEnterStackView.state == .enabled && validPassword(mypassword: tf.text ?? "") && mainView.idStackView.state == .enabled && (mainView.passwordStackView.mainTextField.text == mainView.passwordReEnterStackView.mainTextField.text) {
//                    mainView.doneButton.buttonState = .enabled
//                } else {
//                    mainView.doneButton.buttonState = .disabled
//                }
//            }
//            .store(in: &cancellableBag)
//
//        mainView.passwordReEnterStackView.mainTextField.startEditing
//            .sink { tf in
//                mainView.passwordReEnterStackView.state = .enabled
//            }
//            .store(in: &cancellableBag)
//
//        mainView.passwordReEnterStackView.mainTextField.textPublisher
//            .sink { tf in
//
//                mainView.passwordReEnterStackView.state = tf == mainView.passwordStackView.mainTextField.text ? .enabled : .error
//
//                if mainView.passwordReEnterStackView.state == .enabled && mainView.passwordStackView.state == .enabled && mainView.idStackView.state == .enabled && (mainView.passwordStackView.mainTextField.text == mainView.passwordReEnterStackView.mainTextField.text) {
//                    mainView.doneButton.buttonState = .enabled
//                } else {
//                    mainView.doneButton.buttonState = .disabled
//                }
//
//            }
//            .store(in: &cancellableBag)
//
//        mainView.passwordReEnterStackView.mainTextField.endEditing
//            .sink { tf in
//
//                mainView.passwordReEnterStackView.state = tf.text == mainView.passwordStackView.mainTextField.text ? .enabled : .error
//
//                if mainView.passwordReEnterStackView.state == .enabled && mainView.passwordStackView.state == .enabled && mainView.idStackView.state == .enabled && (mainView.passwordStackView.mainTextField.text == mainView.passwordReEnterStackView.mainTextField.text) {
//                    mainView.doneButton.buttonState = .enabled
//                } else {
//                    mainView.doneButton.buttonState = .disabled
//                }
//
//            }
//            .store(in: &cancellableBag)
//
        mainView.doneButton.tapPublisher
            .sink { [weak self] _ in
                let vc = CreateUserNameVC()
//                let text = mainView.idStackView.mainTextField.text ?? ""
//
//                if isPhoneNumber(numberStr: text) {
//                    vc.isPhoneNumberUser = true
//                    vc.phoneNumberWithId = text
//                    vc.userDatas = .init(password: mainView.passwordStackView.mainTextField.text, phoneNumber: text)
//                    vc.providerValue = .phone
//                } else {
//                    vc.userDatas = .init(email: text, password: mainView.passwordStackView.mainTextField.text)
//                    vc.providerValue = .email
//                }
                self?.navigationController?.pushViewController(vc, animated: true)
            }
            .store(in: &cancellableBag)
//
//        NotificationCenter.default.publisher(for: UIApplication.keyboardWillShowNotification)
//            .sink { noti in
//
//                guard let keyboardFrame = noti.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
//
//                var inset = mainView.scrollView.contentInset
//                inset.bottom = keyboardFrame.height
//
//                mainView.scrollView.contentInset = inset
//                mainView.scrollView.scrollIndicatorInsets = inset
//            }
//            .store(in: &cancellableBag)
//
//        NotificationCenter.default.publisher(for: UIApplication.keyboardWillHideNotification)
//            .sink { noti in
//
//                var inset = mainView.scrollView.contentInset
//                inset.bottom = .zero
//                mainView.scrollView.contentInset = inset
//                mainView.scrollView.scrollIndicatorInsets = inset
//            }
//            .store(in: &cancellableBag)
    }
    
//    private func checkExistEmail() {
//
//        guard let mainView = view as? CreateUserIDView else {
//            return assertionFailure("MainView is not Exist")
//        }
//
//        OliveCheck.checkEmailList(myEmail: mainView.idStackView.mainTextField.text ?? "") { json, error in
//            guard error == nil else{
//                QL2("checkEmailList? error : \(String(describing: error?.localizedDescription))")
//                return
//            }
//            QL3("emailCode? : \(String(describing: json))")
//
//            if json!["success"].bool! {
//                if json!["data"]["provider"].string != "email" {
//                    QL3("emailCode? : \(String(describing: json))")
//                }else{
//                    mainView.idStackView.state = .error
//                    mainView.idStackView.errorLabel.text = "user_profile_text_noti_same_id_title".localized
//                    QL3("emailCode? : \(String(describing: json))")
//                }
//            }else{
//                QL3("emailCode? : \(String(describing: json))")
//            }
//        }
//    }
    
//    private func checkExistPhone() {
//        guard let mainView = view as? CreateUserIDView else {
//            return assertionFailure("MainView is not Exist")
//        }
//
//        AuthAPIService.getUserListForPhone(phoneNumber: mainView.idStackView.mainTextField.text ?? "") { [weak self] statusCode, json, error in
//            guard error == nil else {
//                return self!.restartSplachVC()
//            }
//
//            switch statusCode {
//            case serverRequestCase.success.rawValue:
//                switch json!["code"].intValue {
//                case JSONRequestCase.success.rawValue:
//                    let idResult = json?["data"]["email"].string
//                    QL3("phone? : \(String(describing: json))")
//                    mainView.idStackView.state = .error
//                    mainView.idStackView.errorLabel.text = "user_profile_text_noti_same_id_title".localized
//                    mainView.doneButton.buttonState = .disabled
//                default:
//                    QL3("phone? : \(String(describing: json))")
//                }
//
//            default:
//                AlertBuilder(viewController: self)
//                    .addAction(title: "hearing_calibration_text_result_ok", style: .default)
//                    .show(message: "Email_Login_Error", style: .alert)
//            }
//        }
//    }

}
