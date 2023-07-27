//
//  CreateUserAdditionalVC.swift
//  EarTraining
//
//  Created by 김민종 on 2023/07/27.
//

import UIKit
import Combine

import Alamofire
// import FirebaseMessaging

final class CreateUserAdditionalVC: BaseViewController {
    
    // MARK: - Properties
//    var providerValue : LoginStatus!
//    var userDatas : addUserDatasUpdate!
    
    var isPhoneNumberUser: Bool = false
    
    // MARK: - LifeCylce
    
    override func loadView() {
        super.loadView()
        
        view = CreateUserAdditionalView(frame: view.frame)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        print(self.userDatas)
        setup()
//        bind()
    }
    
    private func setup() {
        guard let mainView = view as? CreateUserAdditionalView else {
            return assertionFailure("MainView is not Exist")
        }
        setNavigationBackButton()
        hideNavigationBarLine()
        dismissKeyboardWhenTappedAround()
//        userDatas.loginId = OliveKeychain.loadUUIDData(service: "OliveUUID")

        if !self.isPhoneNumberUser {
            mainView.emailStackView.state = .disabled
            mainView.emailStackView.isUserInteractionEnabled = false
//            mainView.emailStackView.mainTextField.text = userDatas.email
            mainView.emailStackView.mainTextField.textColor = .systemGray
        }
    }
    
//    private func bind() {
//        guard let mainView = view as? CreateUserAdditionalView else {
//            return assertionFailure("MainView is not Exist")
//        }
//        mainView.doneButton.buttonState = .enabled
//
//        mainView.emailStackView.mainTextField.startEditing
//            .sink { tf in
//                mainView.emailStackView.state = .enabled
//                mainView.doneButton.isSelected = true
//            }
//            .store(in: &cancellableBag)
//
//        mainView.emailStackView.mainTextField.textPublisher
//            .sink { tf in
//                if mainView.emailStackView.mainTextField.text!.count > 4 && isValidEmail(eamilStr: mainView.emailStackView.mainTextField.text ?? "") {
//                    mainView.doneButton.buttonState = .enabled
//                    mainView.doneButton.setTitle("tutoril_text_done".localized, for: .normal)
//                }  else if mainView.emailStackView.mainTextField.text!.count == 0 {
//                    mainView.doneButton.buttonState = .enabled
//                    mainView.doneButton.setTitle("signup_text_skip".localized, for: .normal)
//                } else {
//                    mainView.doneButton.buttonState = .disabled
//                }
//            }
//            .store(in: &cancellableBag)
//
//        mainView.emailStackView.mainTextField.endEditing
//            .sink { tf in
//                if (mainView.emailStackView.mainTextField.text!.count > 4 && isValidEmail(eamilStr: mainView.emailStackView.mainTextField.text ?? "")) {
//                    mainView.doneButton.buttonState = .enabled
//                    mainView.doneButton.setTitle("tutoril_text_done".localized, for: .normal)
//                } else if mainView.emailStackView.mainTextField.text!.count == 0 {
//                    mainView.doneButton.buttonState = .enabled
//                    mainView.doneButton.setTitle("signup_text_skip".localized, for: .normal)
//                } else {
//                    mainView.doneButton.buttonState = .disabled
//                }
//
//                mainView.emailStackView.state = isValidEmail(eamilStr: tf.text ?? "") ? .enabled : .error
//                self.userDatas.email = mainView.emailStackView.mainTextField.text!
//            }
//            .store(in: &cancellableBag)
//
//        mainView.birthDayStackView.mainTextField.startEditing
//            .sink { [weak self] _ in
//                mainView.birthDayStackView.state = .enabled
//                mainView.birthDayStackView.mainTextField.text = mainView.formatDate(date: Date())
//                mainView.doneButton.isSelected = true
//            }
//            .store(in: &cancellableBag)
//
//        mainView.birthDayStackView.mainTextField.textPublisher
//            .sink { _ in
//
//            }
//            .store(in: &cancellableBag)
//
//        mainView.birthDayStackView.mainTextField.endEditing
//            .sink { [weak self] _ in
//
//            }
//            .store(in: &cancellableBag)
//
//        mainView.maleButton.tapPublisher
//            .sink { [weak self] _ in
//                mainView.radioButtons.forEach{ $0.isSelected = false }
//                mainView.maleButton.isSelected = true
//                mainView.doneButton.isSelected = true
//                self?.userDatas.gender = "male"
//
//            }
//            .store(in: &cancellableBag)
//
//        mainView.femaleButton.tapPublisher
//            .sink { [weak self] _ in
//                mainView.radioButtons.forEach{ $0.isSelected = false }
//                mainView.femaleButton.isSelected = true
//                mainView.doneButton.isSelected = true
//                self?.userDatas.gender = "female"
//
//            }
//            .store(in: &cancellableBag)
//
//        mainView.otherButton.tapPublisher
//            .sink { [weak self] _ in
//                mainView.radioButtons.forEach{ $0.isSelected = false }
//                mainView.otherButton.isSelected = true
//                mainView.doneButton.isSelected = true
//
//                self?.userDatas.gender = "other"
//            }
//            .store(in: &cancellableBag)
//
//        mainView.doneButton.tapPublisher
//            .throttle(for: 1, scheduler: RunLoop.main, latest: true)
//            .sink { [weak self] _ in
//                let saveDateFormat: DateFormatter = DateFormatter()
//                saveDateFormat.timeZone = TimeZone(identifier: "GMT")
//                saveDateFormat.calendar = Calendar(identifier: .gregorian)
//                saveDateFormat.dateFormat = "yyyyMMdd"
//                print("birthday = \(saveDateFormat.string(from: mainView.birthDayDatePicker.date))")
//
//                if mainView.birthDayStackView.mainTextField.text == "" {
//                    self?.userDatas.birthday = ""
//                } else {
//                    self?.userDatas.birthday = "\(saveDateFormat.string(from: mainView.birthDayDatePicker.date))"
//                }
//
//                if self!.isPhoneNumberUser {
//                    self?.oliveSignInPhoneNumber()
//                } else {
//                    self?.oliveSignInEmail()
//                }
//
//                mainView.doneButton.buttonState = .disabled
//            }
//            .store(in: &cancellableBag)
//
//        NotificationCenter.default.publisher(for: UIApplication.keyboardWillShowNotification)
//            .sink { [weak self] noti in
//                guard let self = self else { return }
//
//                guard let keyboardFrame = noti.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
//
//                var inset = mainView.createUserScrollView.contentInset
//                inset.bottom = keyboardFrame.height
//
//                mainView.createUserScrollView.contentInset = inset
//                mainView.createUserScrollView.scrollIndicatorInsets = inset
//                mainView.createUserScrollView.scrollRectToVisible(mainView.emailStackView.frame, animated: true)
//            }
//            .store(in: &cancellableBag)
//
//        NotificationCenter.default.publisher(for: UIApplication.keyboardWillHideNotification)
//            .sink { [weak self] noti in
//                guard let self = self else { return }
//
//                var inset = mainView.createUserScrollView.contentInset
//                inset.bottom = .zero
//
//                mainView.createUserScrollView.contentInset = inset
//                mainView.createUserScrollView.scrollIndicatorInsets = inset
//            }
//            .store(in: &cancellableBag)
//
//        NotificationCenter.default.publisher(for: UIApplication.keyboardWillShowNotification)
//            .sink { noti in
//
//                guard let keyboardFrame = noti.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
//
//                var inset = mainView.createUserScrollView.contentInset
//                inset.bottom = keyboardFrame.height
//
//                mainView.createUserScrollView.contentInset = inset
//                mainView.createUserScrollView.scrollIndicatorInsets = inset
//            }
//            .store(in: &cancellableBag)
//
//        NotificationCenter.default.publisher(for: UIApplication.keyboardWillHideNotification)
//            .sink { noti in
//
//                var inset = mainView.createUserScrollView.contentInset
//                inset.bottom = .zero
//                mainView.createUserScrollView.contentInset = inset
//                mainView.createUserScrollView.scrollIndicatorInsets = inset
//            }
//            .store(in: &cancellableBag)
//    }
    
    // MARK: - 리팩토링 절실 Method
    
    override func backButtonDidTap() {
        AlertBuilder(viewController: self)
            .addAction(title: "user_profile_leave_button".localized, style: .default) {
                super.backButtonDidTap()
            }
            .addAction(title: "hearing_calibration_text_result_cancel".localized, style: .cancel)
            .show(title: "setting_hearing_setting_notice", message: "signup_text_back_button_tapped".localized, style: .alert)
    }

    // 이메일로 가입할때 타는로직
    
//    private func oliveSignInEmail() {
//            guard let datas = userDatas else { return }
//
//            self.setLoading(true)
//            //이메일 확인 후 진행.
//            AuthAPIService.getUserListForEmail(email: userDatas.email) { statusCode, json, error in
//
//                guard error == nil else {
//                    return print("getUserListForEmail error: \(String(describing: error?.localizedDescription))")
//                }
//
//                print("getUserListForEmail statusCode: \(statusCode)")
//                print("getUserListForEmail json: \(json!)")
//                switch statusCode {
//                case serverRequestCase.success.rawValue:
//                    switch json!["code"].intValue {
//                    case JSONRequestCase.success.rawValue:
//                        //계정이 이미 있음
//                        self.setLoading(false)
//                        //self.disableDoneBtn()
//                        AlertBuilder(viewController: self)
//                            .addAction(title: "hearing_calibration_text_result_ok", style: .default)
//                            .show(title: "setting_hearing_setting_notice", message: "login_text_same_email_exist", style: .alert)
//
//                    case JSONRequestCase.userNotFound.rawValue:
//                        print("getUserListForEmail \(statusCode) \(json!["code"].intValue)")
//                        //회원가입 진행하는데, 로컬인지 아닌지 확인하고 넘겨야함
//                        if let currentProviderValue = UserDefaults.standard.string(forKey: UserDefault.currentProvider.rawValue) {
//                            if currentProviderValue == "local" {
//                                self.oliveSignUpUpdate(useData: datas)
//                            } else {
//                                //여기 문제있음
//                                print("currentProviderValue가 있는데 local이 아닌데 여기까지 왔다? 뭔가 문제가 있다.")
//                                self.oliveSignUp(useData: datas)
//
//                            }
//                        } else {
//                            self.oliveSignUp(useData: datas)
//                        }
//                    default:
//                        //여기 문제있음
//                        print("getUserListForEmail \(statusCode) \(json!["code"].intValue)")
//                    }
//                case serverRequestCase.error.rawValue:
//                    switch json!["code"].intValue {
//                    case JSONRequestCase.userNotFound.rawValue:
//                        print("getUserListForEmail \(statusCode) \(json!["code"].intValue)")
//                        //회원가입 진행하는데, 로컬인지 아닌지 확인하고 넘겨야함
//                        if let currentProviderValue = UserDefaults.standard.string(forKey: UserDefault.currentProvider.rawValue) {
//                            if currentProviderValue == "local" {
//                                self.oliveSignUpUpdate(useData: datas)
//                            } else {
//                                // 4.26 추가 이유(한 핸드폰으로 기존에 가입한 사람이 있으면 UUID때문에 provider가 생성됨 그래서 여기를 타서 에러가 나서 모든 업데이트 시 추가함
//                                print("currentProviderValue가 있는데 local이 아닌데 여기까지 왔다? 뭔가 문제가 있다.")
//                                self.oliveSignUp(useData: datas)
//
//                            }
//                        } else {
//                            self.oliveSignUp(useData: datas)
//                        }
//                    default:
//                        //여기 문제있음
//                        print("getUserListForEmail \(statusCode) \(json!["code"].intValue)")
//                    }
//                default:
//                    //여기 문제있음
//                    print("getUserListForEmail \(statusCode) \(json!["code"].intValue)")
//                }
//            }
//        }
    
    // 폰번호로 가입할 때 타는 로직
//    private func oliveSignInPhoneNumber() {
//            guard let datas = userDatas else { return }
//            self.setLoading(true)
//
//            //이메일 확인 후 진행.
//            AuthAPIService.getUserListForPhone(phoneNumber: userDatas.phoneNumber ?? "") { statusCode, json, error in
//
//                guard error == nil else {
//                    return print("getUserListForEmail error: \(String(describing: error?.localizedDescription))")
//                }
//                print("getUserListForEmail currentProvider: \(UserDefaults.standard.string(forKey: UserDefault.currentProvider.rawValue))")
//
//                print("getUserListForEmail statusCode: \(statusCode)")
//                print("getUserListForEmail json: \(json!)")
//                switch statusCode {
//                case serverRequestCase.success.rawValue:
//                    switch json!["code"].intValue {
//                    case JSONRequestCase.success.rawValue:
//                        //계정이 이미 있음
//                        self.setLoading(false)
//                        //self.disableDoneBtn()
//                        AlertBuilder(viewController: self)
//                            .addAction(title: "hearing_calibration_text_result_ok", style: .default)
//                            .show(title: "setting_hearing_setting_notice", message: "login_text_same_email_exist", style: .alert)
//
//                    case JSONRequestCase.userNotFound.rawValue:
//                        print("getUserListForrPhone \(statusCode) \(json!["code"].intValue)")
//                        //회원가입 진행하는데, 로컬인지 아닌지 확인하고 넘겨야함
//                        if let currentProviderValue = UserDefaults.standard.string(forKey: UserDefault.currentProvider.rawValue) {
//                            if currentProviderValue == "local" {
//                                self.oliveSignUpUpdate(useData: datas)
//                            } else {
//                                //여기 문제있음
//                                print("currentProviderValue가 있는데 local이 아닌데 여기까지 왔다? 뭔가 문제가 있다.")
//                                self.oliveSignUp(useData: datas)
//
//                            }
//                        } else {
//
//                            self.oliveSignUp(useData: datas)
//                        }
//                    default:
//                        //여기 문제있음
//                        print("getUserListForEmail \(statusCode) \(json!["code"].intValue)")
//                    }
//                case serverRequestCase.error.rawValue:
//                    switch json!["code"].intValue {
//                    case JSONRequestCase.userNotFound.rawValue:
//                        print("getUserListForEmail \(statusCode) \(json!["code"].intValue)")
//                        //회원가입 진행하는데, 로컬인지 아닌지 확인하고 넘겨야함
//                        if let currentProviderValue = UserDefaults.standard.string(forKey: UserDefault.currentProvider.rawValue) {
//                            if currentProviderValue == "local" {
//                                self.oliveSignUpUpdate(useData: datas)
//                            } else {
//                                //여기 문제있음
//                                print("currentProviderValue가 있는데 local이 아닌데 여기까지 왔다? 뭔가 문제가 있다.")
//                                self.oliveSignUp(useData: datas)
//
//                            }
//                        } else {
//                            self.oliveSignUp(useData: datas)
//                        }
//                    default:
//                        //여기 문제있음
//                        print("getUserListForEmail \(statusCode) \(json!["code"].intValue)")
//                    }
//                default:
//                    //여기 문제있음
//                    print("getUserListForEmail \(statusCode) \(json!["code"].intValue)")
//                }
//            }
//        }
    
//    private func oliveSignUpUpdate(useData: addUserDatasUpdate){
//        print("oliveSignUpUpdate \(useData)")
//        AuthAPIService.oliveSignUpSocialUpdate(userData: useData) { statusCode, json, error in
//
//            guard error == nil else { return print("oliveSignUpForAddUserDatsUpdate error: \(String(describing: error?.localizedDescription))")}
//
//            print("oliveSignUpForAddUserDatsUpdate statusCode: \(statusCode), json: \(json!)")
//
//            switch statusCode {
//            case serverRequestCase.success.rawValue:
//                switch json!["code"].intValue {
//                case JSONRequestCase.success.rawValue:
//                    if self.isPhoneNumberUser {
//                        UserDefaults.standard.set(json!["data"]["email"].string, forKey: UserDefault.OliveEmail.rawValue)
//                        currentOliveUUIDEmail = json!["data"]["email"].string
//                    } else {
//                        UserDefaults.standard.set(self.userDatas.email!, forKey: UserDefault.OliveEmail.rawValue)
//                        currentOliveUUIDEmail = self.userDatas.email!
//                    }
//
//                    UserDefaults.standard.set(json!["data"]["accessToken"].string, forKey: UserDefault.jwttoken.rawValue)
//                    UserDefaults.standard.set(self.userDatas.password!, forKey: UserDefault.OlivePassword.rawValue)
//                    UserDefaults.standard.set(self.userDatas.provider!, forKey: UserDefault.currentProvider.rawValue)
//
//
//                    // TODO: CompleteView 추가해야됨
//                    //self.completeView.alpha = 0
//                    //self.completeView.isHidden = false
//                    //self.completeView.fadeIn()
//                    self.setLoading(false)
//
//                    currentProvider = self.isPhoneNumberUser ? .phone : .email
//                    print("oliveSignUpForAddUserDatsUpdate 완료")
//
//                    //폰 디바이스 저장하기
//                    Messaging.messaging().token { token, error in
//                        if error != nil {
//                            print("oliveSignUpForAddUserDatsUpdate token error \(String(describing: error))")
//                        } else {
//                            print("oliveSignUpForAddUserDatsUpdate token: \(String(describing: token))")
//                            UserDefaults.standard.set(token, forKey: UserDefault.myollivefcmToken.rawValue)
//
//                            //이메일 추가해서 업데이트 하기?
//                            let phoneDeviceUpdate = SavePhoneDeviceInfo()
//                            DispatchQueue.main.asyncAfter(deadline: .now()) {
//                                print("나의 폰 정보가 없음")
//                                phoneDeviceUpdate.saveNewPhoneDevice()
//                            }
//                        }
//                    }
//
//                    self.saveCurrentUser()
//
//                    //이어디바이스를 강제로 추가 해줘야합니다.
//                    UserDefaults.standard.set(true, forKey: UserDefault.earForceAdd.rawValue)
//
//                    let regionCode = Locale.current.regionCode
//
//                    if fromSetting {
//                        DispatchQueue.main.asyncAfter(deadline: .now() + 1 ) {
//                            //self.navigationController?.isNavigationBarHidden = false
//                            self.navigationItem.leftBarButtonItem = UIBarButtonItem(
//                                title: "",
//                                style: .plain,
//                                target: nil,
//                                action: nil)
//                            self.navigationItem.hidesBackButton = true
//                            self.popBack(4)
//                        }
//                    }else{
//                        DispatchQueue.main.asyncAfter(deadline: .now() + 1 ) {
//                            if OliveBLEManager.shared.connectedOliveDevice == .max {
//                                let vc = TutorialDeviceSelectViewController.instance
//                                vc.startPoint = .tutorial
//                                vc.oliveDevice = .max
//                                let nav = UINavigationController(rootViewController: vc)
//                                self.changeRootViewController(to: nav)
//                            } else if regionCode == "JP" {
//                                let vc = Tutorial01ViewController.instance
//                                vc.oliveDevice = .pro
//                                vc.startPoint = .tutorial
//                                let nav = UINavigationController(rootViewController: vc)
//                                self.changeRootViewController(to: nav)
//                            } else {
//                                let vc = TutorialDeviceSelectViewController.instance
//                                vc.startPoint = .tutorial
//                                vc.oliveDevice = .max
//                                let nav = UINavigationController(rootViewController: vc)
//                                self.changeRootViewController(to: nav)
//
//                            }
//                        }
//                    }
//                case JSONRequestCase.userNotFound.rawValue:
//                    print("oliveSignUpForAddUserDatsUpdate \(statusCode) UserNotFound: \(String(describing: json!))")
//                    self.setLoading(false)
//                    self.restartSplachVC()
//
//                    //self.addAlert()
//                default:
//                    print("oliveSignUpForAddUserDatsUpdate \(statusCode) default: \(String(describing: json!))")
//                    self.setLoading(false)
//                    self.restartSplachVC()
//
//                }
//            case serverRequestCase.error.rawValue:
//                print("oliveSignUpSocialUpdate statusCode: \(statusCode) \(String(describing: json!["code"].intValue))")
//                self.restartSplachVC()
//            default:
//                print("oliveSignUpSocialUpdate statusCode: \(statusCode) \(String(describing: json!["code"].intValue))")
//
//                AlertBuilder(viewController: self)
//                    .addAction(title: "hearing_calibration_text_result_ok", style: .default)
//                    .show(title: "setting_hearing_setting_notice", message: "please_try_again", style: .alert)
//            }
//        }
//    }
    
//    private func oliveSignUp(useData: addUserDatasUpdate) {
//        print("oliveSignUp \(useData)")
//        AuthAPIService.oliveSignUpSocial(userData: useData) { statusCode, json, error in
//            guard error == nil else {
//                return print("oliveSignUpForAddUserDatsUpdate error: \(String(describing: error?.localizedDescription))")
//            }
//            print("oliveSignUpForAddUserDatsUpdate statusCode: \(statusCode)")
//            print("oliveSignUpForAddUserDatsUpdate JSON: \(String(describing: json!))")
//
//            switch statusCode {
//            case serverRequestCase.success.rawValue:
//                switch json!["code"].intValue {
//                case JSONRequestCase.success.rawValue:
//
//
//                    if self.isPhoneNumberUser {
//                        UserDefaults.standard.set(json!["data"]["email"].string, forKey: UserDefault.OliveEmail.rawValue)
//                        currentOliveUUIDEmail = json!["data"]["email"].string
//                    } else {
//                        UserDefaults.standard.set(self.userDatas.email!, forKey: UserDefault.OliveEmail.rawValue)
//                        currentOliveUUIDEmail = self.userDatas.email!
//                    }
//
//
//                    UserDefaults.standard.set(json!["data"]["accessToken"].string, forKey: UserDefault.jwttoken.rawValue)
//                    UserDefaults.standard.set(self.userDatas.password!, forKey: UserDefault.OlivePassword.rawValue)
//                    UserDefaults.standard.set(self.userDatas.provider!, forKey: UserDefault.currentProvider.rawValue)
//
//                    //TODO: 확인해봐야됨
//                    currentProvider = self.providerValue
//                    print("oliveSignUpForAddUserDatsUpdate 완료")
//                    self.setLoading(false)
//                    //폰 디바이스 저장하기
//                    Messaging.messaging().token { token, error in
//                        guard error == nil else { return print("oliveSignUpForAddUserDatsUpdate token error \(String(describing: error))") }
//
//                        print("oliveSignUpForAddUserDatsUpdate token: \(String(describing: token))")
//                        UserDefaults.standard.set(token, forKey: UserDefault.myollivefcmToken.rawValue)
//
//                        //이메일 추가해서 업데이트 하기?
//                        let phoneDeviceUpdate = SavePhoneDeviceInfo()
//                        DispatchQueue.main.asyncAfter(deadline: .now()) {
//                            print("나의 폰 정보가 없음")
//                            phoneDeviceUpdate.saveNewPhoneDevice()
//                        }
//                    }
//
//
//                    //이어디바이스를 강제로 추가 해줘야합니다.
//                    UserDefaults.standard.set(true, forKey: UserDefault.earForceAdd.rawValue)
//                    self.saveCurrentUser()
//
//                    let regionCode = Locale.current.regionCode
//
//                    if fromSetting {
//                        DispatchQueue.main.asyncAfter(deadline: .now() + 1 ) {
//                            self.navigationController?.isNavigationBarHidden = false
//                            self.navigationItem.leftBarButtonItem = UIBarButtonItem(
//                                title: "",
//                                style: .plain,
//                                target: nil,
//                                action: nil)
//                            self.navigationItem.hidesBackButton = true
//                            self.popBack(4)
//                        }
//                    }else{
//                        DispatchQueue.main.asyncAfter(deadline: .now() + 1 ) {
//                            if OliveBLEManager.shared.connectedOliveDevice == .max {
//                                let vc = TutorialDeviceSelectViewController.instance
//                                vc.startPoint = .tutorial
//                                vc.oliveDevice = .max
//                                let nav = UINavigationController(rootViewController: vc)
//                                self.changeRootViewController(to: nav)
//                            } else if regionCode == "JP" {
//                                let vc = Tutorial01ViewController.instance
//                                vc.oliveDevice = .pro
//                                vc.startPoint = .tutorial
//                                let nav = UINavigationController(rootViewController: vc)
//                                self.changeRootViewController(to: nav)
//                            } else {
//                                let vc = TutorialDeviceSelectViewController.instance
//                                vc.startPoint = .tutorial
//                                vc.oliveDevice = .max
//                                let nav = UINavigationController(rootViewController: vc)
//                                self.changeRootViewController(to: nav)
//
//                            }
//                        }
//                    }
//
//
//                case JSONRequestCase.userNotFound.rawValue:
//                    print("oliveSignUpForAddUserDatsUpdate \(statusCode) UserNotFound: \(String(describing: json!))")
//                    AlertBuilder(viewController: self)
//                        .addAction(title: "hearing_calibration_text_result_ok", style: .default)
//                        .show(title: "setting_hearing_setting_notice", message: "signup_text_exist_account_title", style: .alert)
//                case JSONRequestCase.existingUser.rawValue:
//                    print("oliveSignUpForAddUserDatsUpdate \(statusCode) existingUser: \(String(describing: json!))")
//                    AlertBuilder(viewController: self)
//                        .addAction(title: "hearing_calibration_text_result_ok", style: .default)
//                        .show(title: "setting_hearing_setting_notice", message: "signup_text_exist_account_title", style: .alert)
//                default:
//                    print("oliveSignUpForAddUserDatsUpdate \(statusCode) default: \(String(describing: json!))")
//                    self.restartSplachVC()
//
//                }
//            default:
//                print("oliveSignUpForAddUserDatsUpdate statusCode: \(statusCode)")
//
//                AlertBuilder(viewController: self)
//                    .addAction(title: "hearing_calibration_text_result_ok", style: .default)
//                    .show(title: "setting_hearing_setting_notice", message: "please_try_again", style: .alert)
//            }
//
//        }
//    }
    
//    func saveCurrentUser() {
//        if UserDefaults.standard.object(forKey: "currentUserInfo") == nil {
//            UserAPIService.getUserInfoEmail { statusCode, json, error in
//
//                guard error == nil else {
//                    return print("getCurrentUserInfo error: \(String(describing: error))")
//                }
//
//                print("getCurrentUserInfo statusCode: \(statusCode)")
//                switch statusCode {
//                case serverRequestCase.success.rawValue:
//                    print("getCurrentUserInfo \(statusCode) json: \(json!)")
//                    switch json!["code"].intValue {
//                    case JSONRequestCase.success.rawValue:
//                        if let jsonData = json!["data"] as? JSON {
//                            let currentUserInfo: CurrentUserData = CurrentUserData(email: jsonData["email"].stringValue, firstName: jsonData["firstName"].stringValue, lastName: jsonData["lastName"].stringValue, birthday: jsonData["birthday"].stringValue, gender: jsonData["gender"].stringValue, phoneNumber: jsonData["phoneNumber"].stringValue, countryCode: jsonData["countryCode"].stringValue, remoteCare: jsonData["remoteCare"].stringValue)
//
//                            let encoder = JSONEncoder()
//                            if let encoded = try? encoder.encode(currentUserInfo) {
//                                QL4("currentUserInfo: \(currentUserInfo)")
//                                UserDefaults.standard.setValue(encoded, forKey: UserDefault.currentUserInfo.rawValue)
//                            }
//                        }
//
//
//                        break
//                    default:
//                        print("getCurrentUserInfo \(statusCode) jsonCode: \(json!["code"].intValue)")
//                        break
//                    }
//                case serverRequestCase.error.rawValue:
//                    print("getCurrentUserInfo \(statusCode) json: \(json!["code"])")
//                    break
//                default:
//                    print("getCurrentUserInfo \(statusCode) default \(json!["code"])")
//                    break
//                }
//            }
//        }
//    }
    
//    private func setLoading(_ set : Bool){
//
//        guard let mainView = view as? CreateUserAdditionalView else { return }
//
//        if set {
//            mainView.loadingIndicator.isHidden = false
//            mainView.loadingIndicator.isAnimating = true
//        } else {
//            mainView.loadingIndicator.isHidden = false
//            mainView.loadingIndicator.isAnimating = false
//        }
//    }
    
//    private func updateUserDatas() -> Bool {
//        if userDatas.provider == "email" {
//            //userDatas.email = "\(String(describing: emailTxt.text!))"
//            //userDatas.password = "\(String(describing: passTxt.text!))"
//            //if LangCode == "ko" || LangCode == "ja" {
//            //userDatas.firstName = "\(String(describing: l_nameTxt.text!))"
//            //userDatas.lastName = "\(String(describing: f_nameTxt.text!))"
//            //} else {
//            //userDatas.firstName = "\(String(describing: f_nameTxt.text!))"
//            //userDatas.lastName = "\(String(describing: l_nameTxt.text!))"
//            //}
//            //userDatas.phoneNumber = "\(String(describing: myPhoneNumber!))"
//            //userDatas.birthday = "\(String(describing: myBirthDay!))"
//            //userDatas.countryCode = "\(String(describing: myCountryCode!))"
//            //userDatas.usePromo = UserDefaults.standard.bool(forKey: UserDefault.subscribePROMO.rawValue)
//            //userDatas.usePush = UserDefaults.standard.bool(forKey: UserDefault.pushbool.rawValue)
//            //
//            //switch genderTxt.text {
//            //case NSLocalizedString("signup_text_create_account_gender_male", comment: "male"):
//            //userDatas.gender = "male"
//            //break
//            //            case NSLocalizedString("signup_text_create_account_gender_female", comment: "female"):
//            //                userDatas.gender = "female"
//            //                break
//            //            default:
//            //                userDatas.gender = "other"
//            //                break
//            //            }
//
//
//            print("저장한! userDatas : \(String(describing: userDatas))")
//            return true
//        }else{
//            print("providerValue 오류: \(String(describing: userDatas.provider))")
//            return false
//        }
//    }
    
}
