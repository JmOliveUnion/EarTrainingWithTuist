//
//  CreateUserNameVC.swift
//  EarTraining
//
//  Created by 김민종 on 2023/07/27.
//

import UIKit
import Combine

import CountryPickerView

final class CreateUserNameVC: BaseViewController {

    // MARK: - Properties
//    var providerValue : LoginStatus!
//    var userDatas : addUserDatasUpdate!
    var myPhoneNumber: String!
    
    // 폰번호로 아이디를 입력한 유저를 위한 프로퍼티
    var isPhoneNumberUser: Bool = false
    var phoneNumberWithId: String = ""

    @Published var smsLimitTime = 0

    private var smsCode: String!
    private var smsRequestId: String!
    
    var currentCountryCode: String!
        
    // 버튼상태
    private var currentStatus: SendStatus = .idle
    
    enum SendStatus {
        case idle
        case wrongPhoneNumber
        case requestSMS
        case checkSMS
        case smsTimeout
        case wrongSMS
        case wrongSMSIdle
        case fiveSMSError
        case fiveMinWait
    }
    
    // MARK: - LifeCycle
    
    override func loadView() {
        super.loadView()
        view = CreateUserNameView(frame: view.frame)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        bind()
        presentAgreementVC()
        setupKeyboardHiding()
        currentStatus = .idle
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        smsLimitTime = 0
//        smsPassErrorNum = 0
    }
    
    private func setup() {
        guard let mainView = view as? CreateUserNameView else {
            return assertionFailure("MainView is not Exist")
        }
        setNavigationBackButton()
        hideNavigationBarLine()
        dismissKeyboardWhenTappedAround()
        
//        if isPhoneNumberUser {
//            mainView.phoneNumberView.state = .disabled
//            mainView.phoneNumberView.isUserInteractionEnabled = false
//            mainView.phoneNumberView.mainTextField.text = phoneNumberWithId
//            mainView.phoneNumberView.mainTextField.textColor = .systemGray
//            self.currentCountryCode = mainView.countryPicker.selectedCountry.phoneCode.substrFrom(from: 1)
//        }
    }
     
    // MARK: - Binding Method
    
    private func bind() {
        guard let mainView = view as? CreateUserNameView else {
            return assertionFailure("MainView is not Exist")
        }
//
//        mainView.countryPicker.delegate = self
//        mainView.countryPicker.dataSource = self
//
//        mainView.nameStackView.mainTextField.startEditing
//            .sink {  _ in
//                mainView.nameStackView.state = .enabled
//            }
//            .store(in: &cancellableBag)
//
//        mainView.nameStackView.mainTextField.textPublisher
//            .sink { tf in
//                if mainView.phoneNumberView.mainTextField.text!.count > 5 && mainView.nameStackView.mainTextField.text!.count > 0 && mainView.nameStackView.subTextField.text!.count > 0 && validName(myName: mainView.nameStackView.mainTextField.text ?? "") {
//                    mainView.doneButton.buttonState = .enabled
//                } else {
//                    mainView.doneButton.buttonState = .disabled
//                }
//                mainView.nameStackView.state = validName(myName: tf ) ? .enabled : .error
//
//            }
//            .store(in: &cancellableBag)
//
//        mainView.nameStackView.subTextField.startEditing
//            .sink { _ in
//                mainView.nameStackView.state = .enabled
//
//            }
//            .store(in: &cancellableBag)
//
//        mainView.nameStackView.subTextField.textPublisher
//            .sink { tf in
//                if mainView.phoneNumberView.mainTextField.text!.count > 5 && mainView.nameStackView.mainTextField.text!.count > 0 && mainView.nameStackView.subTextField.text!.count > 0 && validName(myName: mainView.nameStackView.subTextField.text ?? "") {
//                    mainView.doneButton.buttonState = .enabled
//                } else {
//                    mainView.doneButton.buttonState = .disabled
//
//                }
//                mainView.nameStackView.state = validName(myName: tf ) ? .enabled : .error
//
//            }
//            .store(in: &cancellableBag)
//
//        mainView.phoneNumberView.mainTextField.startEditing
//            .sink { [weak self] _ in
//                self?.currentStatus = .idle
//                mainView.phoneNumberView.state = .enabled
//                mainView.resendStackView.isHidden = true
//                mainView.phoneErrorMessageLabel.isHidden = true
//                self?.currentCountryCode = mainView.countryPicker.selectedCountry.phoneCode.substrFrom(from: 1)
//
//            }
//            .store(in: &cancellableBag)
//
//        mainView.phoneNumberView.mainTextField.textPublisher
//            .sink { [weak self] _ in
//                if mainView.phoneNumberView.mainTextField.text!.count > 5 && mainView.nameStackView.mainTextField.text!.count > 0 && mainView.nameStackView.subTextField.text!.count > 0 {
//                    if self?.currentStatus == .idle {
//                        self?.currentStatus = .requestSMS
//                    }
//                    mainView.doneButton.buttonState = .enabled
//                } else {
//                    mainView.doneButton.buttonState = .disabled
//                }
//            }
//            .store(in: &cancellableBag)
//
//        mainView.smsView.mainTextField.startEditing
//            .sink { _ in
//
//                mainView.smsView.state = .enabled
//
//            }
//            .store(in: &cancellableBag)
//
//        mainView.smsView.mainTextField.textPublisher
//            .sink { tf in
//                if self.currentStatus == .wrongSMS {
//                    self.currentStatus = .wrongSMSIdle
//                }
//
//                if tf.count > 5 {
//                    mainView.doneButton.buttonState = .enabled
//                } else if tf.count > 6 {
//                    mainView.smsView.state = .error
//                    mainView.doneButton.buttonState = .disabled
//                } else {
//                    mainView.doneButton.buttonState = .disabled
//                }
//            }
//            .store(in: &cancellableBag)
//
//        mainView.smsView.mainTextField.endEditing
//            .sink { tf in
//                if self.currentStatus == .wrongSMS {
//                    self.currentStatus = .wrongSMSIdle
//                }
//
//                if tf.text?.count ?? 1 == 6 {
//                    mainView.doneButton.buttonState = .enabled
//                } else if tf.text?.count ?? 1 > 6 {
//                    mainView.smsView.state = .error
//                    mainView.doneButton.buttonState = .disabled
//                } else {
//                    mainView.doneButton.buttonState = .disabled
//                }
//            }
//            .store(in: &cancellableBag)
//
        mainView.doneButton.tapPublisher
            .throttle(for: 1, scheduler: RunLoop.main, latest: true)
            .sink { [weak self] _ in
                // 국가별 번호 변경
//                self?.myPhoneNumber = mainView.phoneNumberView.mainTextField.text?.first == "0" ? mainView.phoneNumberView.mainTextField.text?.substrFrom(from: 1) : "\(mainView.phoneNumberView.mainTextField.text!)"
//                self?.checkExistPhone()
//                mainView.phoneErrorMessageLabel.isHidden = true
                let vc = CreateUserAdditionalVC()
                self?.navigationController?.pushViewController(vc, animated: true)

            }
            .store(in: &cancellableBag)
//
//        mainView.resendButton.tapPublisher
//            .sink { [weak self] in
//                self?.myPhoneNumber = mainView.phoneNumberView.mainTextField.text?.first == "0" ? mainView.phoneNumberView.mainTextField.text?.substrFrom(from: 1) : "\(mainView.phoneNumberView.mainTextField.text!)"
//                self?.currentStatus = .requestSMS
//                self?.checkSMS(mainView: mainView)
//            }
//            .store(in: &cancellableBag)
//
//        NotificationCenter.default.publisher(for: UIApplication.keyboardWillShowNotification)
//            .sink { [weak self] noti in
//                guard let self = self else { return }
//                guard let keyboardFrame = noti.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
//
//                var inset = mainView.userNameScrollView.contentInset
//                inset.bottom = keyboardFrame.height
//                mainView.userNameScrollView.contentInset = inset
//                mainView.userNameScrollView.scrollIndicatorInsets = inset
//                mainView.userNameScrollView.scrollRectToVisible(mainView.smsView.frame, animated: true)
//            }
//            .store(in: &cancellableBag)
//
//        NotificationCenter.default.publisher(for: UIApplication.keyboardWillHideNotification)
//            .sink { [weak self] noti in
//                guard let self = self else { return }
//
//                var inset = mainView.userNameScrollView.contentInset
//                inset.bottom = .zero
//
//                mainView.userNameScrollView.contentInset = inset
//                mainView.userNameScrollView.scrollIndicatorInsets = inset
//            }
//            .store(in: &cancellableBag)
//
//        NotificationCenter.default.publisher(for: UIApplication.keyboardWillShowNotification)
//            .sink { noti in
//                guard let keyboardFrame = noti.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
//
//                var inset = mainView.userNameScrollView.contentInset
//                inset.bottom = keyboardFrame.height
//                mainView.userNameScrollView.contentInset = inset
//                mainView.userNameScrollView.scrollIndicatorInsets = inset
//            }
//            .store(in: &cancellableBag)
//
//        NotificationCenter.default.publisher(for: UIApplication.keyboardWillHideNotification)
//            .sink { noti in
//                var inset = mainView.userNameScrollView.contentInset
//                inset.bottom = .zero
//                mainView.userNameScrollView.contentInset = inset
//                mainView.userNameScrollView.scrollIndicatorInsets = inset
//            }
//            .store(in: &cancellableBag)
    }
    
    // MARK: - 수정해야될 메서드
    
//    private func checkExistPhone() {
//
//        guard let mainView = view as? CreateUserNameView else {
//            return assertionFailure("MainView is not Exist")
//        }
//
//        AuthAPIService.getUserListForPhone(phoneNumber: mainView.phoneNumberView.mainTextField.text ?? "") { [weak self] statusCode, json, error in
//            guard error == nil else {
//                return self!.restartSplachVC()
//            }
//
//            switch statusCode {
//            case serverRequestCase.success.rawValue:
//                switch json!["code"].intValue {
//                case JSONRequestCase.success.rawValue:
//                    let idResult = json?["data"]["email"].string
//                    print("phone? : \(String(describing: json))")
//                    AlertBuilder(viewController: self)
//                        .addAction(title: "hearing_calibration_text_result_ok", style: .default)
//                        .show(title: "forgot_email_text_use_sns_title".localized, message: "user_profile_text_noti_same_phone_number_title".localized, style: .alert)
//                default:
//                    self?.checkSMS(mainView: mainView)
//
//                    print("phone? : \(String(describing: json))")
//                }
//
//            default:
//                AlertBuilder(viewController: self)
//                    .addAction(title: "hearing_calibration_text_result_ok", style: .default)
//                    .show(message: "Email_Login_Error", style: .alert)
//            }
//        }
//    }
    
//    private func checkSMS(mainView: CreateUserNameView) {
//        if self.currentStatus == .idle {
//            self.smsLimitTime = 0
//
//            mainView.smsView.isHidden = true
//
//            self.currentStatus = .requestSMS
//        } else if self.currentStatus == .requestSMS {
//            mainView.doneButton.buttonState = .disabled
//            print(self.myPhoneNumber)
//            // TODO: 여기 봐야됨
//
//            OliveCheck.smsVerifySignUpRequest(countryCode: self.currentCountryCode ?? "99", phoneNumber: self.myPhoneNumber ?? "123123") { json, error in
//
//                guard error == nil else { return print("smsCode? error : \(String(describing: error?.localizedDescription))") }
//
//                print("smsCode? : \(String(describing: json))")
//                guard let j = json else { return }
//                if j["success"].bool! {
//                    mainView.countryView.isUserInteractionEnabled = false
//                    //인증코드 온상태!
//                    mainView.doneButton.setTitle("signup_text_next_button".localized, for: .normal)
//                    mainView.smsView.fadeIn()
//                    self.smsRequestId = json!["data"]["requestId"].string!
//                    self.currentStatus = .checkSMS
//                    self.smsLimitTime = resetLimitTime
//                    UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseInOut) {
//                        //self.sendBtn.transform = CGAffineTransform(translationX: 0, y: self.sendBtn.frame.size.height + CGFloat(spacing1) )
//                    } completion: { bool in
//                        //self.bottomBaseAlert.transform = CGAffineTransform(translationX: 0, y: self.sendBtn.frame.size.height + CGFloat(spacing1) )
//                        //self.bottomBaseAlert.fadeIn()
//                        // TODO: 타이머 추가해야됨
//                        //self.validTimeTxt.fadeIn()
//                        // TODO: DOne button 아래 Resend부분 추가해야됨
//                        //self.resendCodeContainer.transform = CGAffineTransform(translationX: 0, y: self.sendBtn.frame.size.height + CGFloat(spacing1) )
//                        //self.resendCodeContainer.isHidden = true
//                        //self.resendCodeContainer.alpha = 0
//                        self.getSetTime()
//                        //self.smsCodeTxt.becomeFirstResponder()
//                        mainView.phoneNumberView.isUserInteractionEnabled = false
//                    }
//                }else{
//                    if json!["code"].int! == -2017 {
//                        //5분이 지난후에 보내세요
//                        mainView.doneButton.buttonState = .disabled
////                        self.currentStatus = .fiveMinWait
//
//                        AlertBuilder(viewController: self)
//                            .addAction(title: "hearing_calibration_text_result_ok", style: .default)
//                            .show(title: "", message: "signup_text_phone_sms_code_already_send", style: .alert)
//
//                    }else if json!["code"].int! == -2011 {
//                        //5번 넘어서 30분 이후에 보내세요
//                        mainView.doneButton.buttonState = .disabled
////                        self.currentStatus = .fiveMinWait
//
//                        AlertBuilder(viewController: self)
//                            .addAction(title: "hearing_calibration_text_result_ok", style: .default)
//                            .show(message: "signup_text_noti_request_limit", style: .alert)
//
//                    }else{
//                        //인증코드 못받은상태
//                        mainView.doneButton.buttonState = .disabled
//                        mainView.phoneNumberView.state = .error
//                        mainView.phoneErrorMessageLabel.isHidden = false
////                        self.currentStatus = .wrongPhoneNumber
//
//                    }
//                }
//            }
//        } else if self.currentStatus == .wrongSMSIdle {
//            // TODO: 넣어야됨?
//
//            //UIView.animate(withDuration: 0.3) {
//            //self.resendCodeContainer.transform = CGAffineTransform(translationX: 0, y: self.sendBtn.frame.size.height + CGFloat(spacing1) )
//            //}
//            self.currentStatus = .checkSMS
//        } else if self.currentStatus == .checkSMS {
//            //requestId 와 smscodeTxt 를 보내기
//            OliveCheck.smsVerifyRequestSignUpCheck(requestId: self.smsRequestId ?? "123090909", smsCode: mainView.smsView.mainTextField.text!) { json, error in
//
//                guard error == nil else {
//                    return print("smsRequestCheck? error : \(String(describing: error?.localizedDescription))")
//                }
//
//                print("smsRequestCheck? : \(String(describing: json))")
//                guard let j = json else { return }
//                if j["success"].bool! {
//                    //문자가 맞으면
//                    // TODO: Timer 추가
//                    //self.setToTimer(-2)
//                    mainView.smsView.isHidden = true
//                    //폰으로 가입자 리스트 확인하기
//                    // TODO: CountryCode 변경
//                    OliveCheck.checkPhoneList(countryCode: self.currentCountryCode ?? "99", phoneNumber: self.myPhoneNumber ?? "123123") { json, error in
//                        guard error == nil else {
//                            return print("checkPhoneList error : \(String(describing: error?.localizedDescription))")
//                        }
//
//                        print("checkPhoneList : \(String(describing: json))")
//                        if !json!["success"].bool! {
//                            self.userDatas.firstName = mainView.nameStackView.mainTextField.text!
//                            self.userDatas.lastName = mainView.nameStackView.subTextField.text!
//                            self.userDatas.phoneNumber = self.myPhoneNumber
//                            self.userDatas.countryCode = self.currentCountryCode
//                            self.userDatas.provider = self.providerValue.rawValue
//
//                            self.goNext()
//                        }else{
//                            self.currentStatus = .idle
//                            mainView.phoneNumberView.mainTextField.text = ""
//                            if self.providerValue.rawValue == self.userDatas.provider && self.myPhoneNumber == self.userDatas.phoneNumber && self.currentCountryCode == self.userDatas.countryCode {
//                                self.userDatas.firstName = mainView.nameStackView.mainTextField.text!
//                                self.userDatas.lastName = mainView.nameStackView.subTextField.text!
//                                self.userDatas.phoneNumber = self.myPhoneNumber
//                                self.userDatas.countryCode = self.currentCountryCode
//                                self.userDatas.provider = self.providerValue.rawValue
//                                self.goNext()
//                                return
//                            }
//                            let storyBoard: UIStoryboard = UIStoryboard(name: "SNSLoginStoryboard", bundle: nil)
//                            let secondView = storyBoard.instantiateViewController(withIdentifier: "phoneuservc") as! PhoneUserListVC
//                            secondView.userDatas = JSON(json!["data"].object)
//                            secondView.providerValue = self.providerValue
//                            secondView.myPhoneNumber = self.myPhoneNumber
//                            secondView.myCountryCode = self.currentCountryCode
//                            self.navigationController?.pushViewController(secondView, animated: true)
//                        }
//                    }
//                }else{
//                    //인증번호가 일치하지 않음.
//                    if json!["code"].int! == -2015 {
//
////                        self.currentStatus = .wrongSMS
//                        AlertBuilder(viewController: self)
//                            .addAction(title: "hearing_calibration_text_result_ok", style: .default)
//                            .show(title:"", message: "signup_text_noti_verification_fail", style: .alert)
//                        return
//                    }else if json!["code"].int! == -2016 {
//
//                        AlertBuilder(viewController: self)
//                            .addAction(title: "hearing_calibration_text_result_ok", style: .default)
//                            .show(title: "", message: "signup_text_noti_verification_fail", style: .alert)
//
//                        self.smsLimitTime = 0
//                        smsPassErrorNum = 0
//                        self.getSetTime()
////                        self.currentStatus = .fiveSMSError
//                        if !self.isPhoneNumberUser {
//                            mainView.phoneNumberView.isUserInteractionEnabled = true
//                        }
//
//                        mainView.countryView.isUserInteractionEnabled = true
//                        mainView.countryPicker.isUserInteractionEnabled = true
//
//                        return
//                    }
//                }
//
//            }
//        }else if self.currentStatus == .wrongSMS {
//
//            mainView.doneButton.setTitle("signup_text_next_button".localized, for: .normal)
//
////                    self.input2.isHidden = false
//            mainView.phoneNumberView.isHidden = false
//
//        }else if self.currentStatus == .wrongPhoneNumber {
//            mainView.phoneNumberView.state = .error
////                    UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut) {
////                        self.sendBtn.transform = CGAffineTransform(translationX: 0, y: CGFloat(spacing1) )
////                    } completion: { bool in
////                        self.phoneNumberAlertTxt.fadeIn()
////                        self.input1.backgroundColor = .init(light: .l_subPink, dark: .d_subPink)
////                    }
//        }
////        else if self.currentStatus == .fiveMinWait {
////
////            mainView.phoneNumberView.mainTextField.text = ""
//////                    self.bottomBaseAlert.transform = .identity
//////                    self.bottomBaseAlert.alpha = 0
////            // TODO: Resend 해야됨
//////                    if resendCodeContainer.alpha == 1 {
//////                        resendCodeContainer.fadeOut()
//////            mainView.phoneNumberView.isHidden = true
////
//////                        UIView.animate(withDuration: 0.3) {
//////                            self.sendBtn.transform = .identity
//////                        }
////
//////                }
////
////            }
////         else if self.currentStatus == .fiveSMSError {
////            mainView.phoneNumberView.errorLabel.text = ""
////
//////                    self.smsCodeAlertTxt.alpha = 0
//////                    self.input2.isHidden = true
//////                    self.phoneNumberField.text = ""
//////                    self.resendCodeContainer.isHidden = true
//////                    UIView.animate(withDuration: 0.3) {
//////                        self.sendBtn.transform = CGAffineTransform.identity
//////                    }
////        }
//    }
    
//    private func goNext(){
//        let vc = CreateUserAdditionalVC()
//        vc.providerValue = self.providerValue
//        vc.userDatas = self.userDatas!
//        if self.isPhoneNumberUser {
//            vc.isPhoneNumberUser = true
//        }
////        vc.promoFlag = self.promoFlag
//        //secondView.isTerm = self.isTerm
//        self.navigationController?.pushViewController(vc, animated: true)
//    }
    
    private func setToTimer(_ sec: Int) {
        print("sec : \(sec)")
        
        guard let mainView = view as? CreateUserNameView else {
            return assertionFailure("MainView is not Exist")
        }
//        if sec == -2 {
//            smsLimitTime = -2
//            if self.validTimeTxt.alpha == 1 {
//                self.validTimeTxt.fadeOut()
//                self.resendCodeContainer.fadeOut(duration: 0.2) {
//                    // TODO: False로 변경
//                    self.resendCodeContainer.isHidden = false
//                }
//            }
//            return
//        }
        
        let min = (sec%3600)/60
        let second = (sec%3600)%60
        if second < 10 {
            mainView.timeLabel.text = String(min) + " : " + "0" + String(second)
        } else {
            mainView.timeLabel.text = String(min) + " : " + String(second)
        }
        if smsLimitTime > 0 {
            perform(#selector(getSetTime), with: nil, afterDelay: 1.0)
        } else if smsLimitTime == 0 {
//            self.bottomBaseAlert.transform = .identity
//            self.bottomBaseAlert.alpha = 0
            mainView.countryPicker.isUserInteractionEnabled = true
//            self.validTimeTxt.alpha = 0
//            mainView.phoneNumberView.mainTextField.text = ""
            
            mainView.resendStackView.fadeIn()
            mainView.doneButton.buttonState = .disabled
            mainView.smsView.mainTextField.text = ""
            mainView.smsView.state = .disabled
            mainView.smsView.isHidden = true
            
            currentStatus = .smsTimeout
            print("currentStatus : \(currentStatus)")
            
            if !self.isPhoneNumberUser {
                mainView.phoneNumberView.isUserInteractionEnabled = true
            }
            view.endEditing(true)
        } else if smsLimitTime == -1 {
            // 문자 잘못 왔을때
            print("정상작동 끝 : \(currentStatus)")
        
            mainView.resendStackView.isHidden = true
            currentStatus = .wrongSMS
        } else if smsLimitTime == -2 {
            print("정상작동 -2 : \(currentStatus)")
        }
    }
    
    @objc func getSetTime() {
        setToTimer(smsLimitTime)
        smsLimitTime -= 1
    }
}

// MARK: - CountryPicker DataSource

extension CreateUserNameVC: CountryPickerViewDelegate {
    func countryPickerView(_ countryPickerView: CountryPickerView, didSelectCountry country: Country) {
        currentCountryCode = country.phoneCode.substrFrom(from: 1)
    }
}
extension CreateUserNameVC: CountryPickerViewDataSource {
    func preferredCountries(in countryPickerView: CountryPickerView) -> [Country] {
        return ["US", "KR", "JP"].compactMap { countryPickerView.getCountryByCode($0) }
    }
    
    func sectionTitleForPreferredCountries(in countryPickerView: CountryPickerView) -> String? {
        return NSLocalizedString("signup_text_phone_preferred_countries", comment: "")
    }
    
    func showOnlyPreferredSection(in countryPickerView: CountryPickerView) -> Bool {
        return false
    }
    
    func navigationTitle(in countryPickerView: CountryPickerView) -> String? {
        return NSLocalizedString("signup_text_phone_select_country", comment: "")
    }
    
    func searchBarPosition(in countryPickerView: CountryPickerView) -> SearchBarPosition {
        return .hidden
    }
    
    func showPhoneCodeInList(in countryPickerView: CountryPickerView) -> Bool {
        return true
    }
    
    func showCountryCodeInList(in countryPickerView: CountryPickerView) -> Bool {
        return true
    }
    
    func cellLabelColor(in countryPickerView: CountryPickerView) -> UIColor? {
        return .label
    }
    func closeButtonNavigationItem(in countryPickerView: CountryPickerView) -> UIBarButtonItem? {
        return UIBarButtonItem(image: UIImage(named: "ButtonLeft"), style: .plain, target: .none, action: .none)
    }
    
    private func presentAgreementVC() {
        let vc = TermsConditionAgreementVC()
        
        vc.modalPresentationStyle = .overCurrentContext
        vc.closure = {
            print("HI")
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                print("After 1 second")
                self.navigationController?.popViewController(animated: true)
            }
            
        }
        present(vc, animated: false)
//        self.navigationController?.pushViewController(vc, animated: true)
    }
}
