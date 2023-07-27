//
//  BaseViewController.swift
//  EarTraining
//
//  Created by 김민종 on 2023/07/12.
//

import UIKit
import Combine

class BaseViewController: UIViewController {
    
    let fireBaseAnalytics = FireBaseAnalytics()
    var cancellableBag = Set<AnyCancellable>()
    
    // MARK: - Base View
    
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
    
    // MARK: - PopUp View
    
    final func showNetworkDisconnectedAlert() {
        AlertBuilder(viewController: self)
            .addAction(title: "contact_us_alert_ok", style: .default)
            .show(
                title: "contact_us_alert_network_fail_title",
                message: "contact_us_alert_network_fail_contents"
            )
    }

    // MARK: - View Transtion
    
    final func changeRootViewController(to viewController: UIViewController,
                                        animated: Bool = true,
                                        duration: TimeInterval = 0.5,
                                        options: UIView.AnimationOptions = .transitionCrossDissolve,
                                        _ completion: (() -> Void)? = nil) {
        guard let window = view.window else { return }
        
        guard animated else {
            window.rootViewController = viewController
            return
        }
        
        UIView.transition(with: window, duration: duration, options: options) {
            let oldState = UIView.areAnimationsEnabled
            UIView.setAnimationsEnabled(false)
            window.rootViewController = viewController
            UIView.setAnimationsEnabled(oldState)
        } completion: { _ in
            completion?()
        }
    }
    
    final func pop(numberOfTimes: Int) {
        guard let navigationController = navigationController else {
            return
        }
        let viewControllers = navigationController.viewControllers
        let index = numberOfTimes + 1
        if viewControllers.count >= index {
            navigationController.popToViewController(viewControllers[viewControllers.count - index], animated: true)
        }
    }
    
    final func restartSplachVC() {
        let dictionary = UserDefaults.standard.dictionaryRepresentation()
        dictionary.keys.forEach { key in
            UserDefaults.standard.removeObject(forKey: key)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1 ) {
            let storyboard = UIStoryboard(name: "Splash", bundle: nil)
            let nextViewController = storyboard.instantiateViewController(withIdentifier: "SplashVC")
            self.changeRootViewController(to: nextViewController)
        }
    }
    
    // Navigation BackButton
     
     func setNavigationBackButton() {
         let backButton = UIBarButtonItem(image: UIImage(named: "ic_back"), style: .plain, target: self, action: #selector(backButtonDidTap))
         self.navigationItem.leftBarButtonItem = backButton
     }
     
     @objc func backButtonDidTap() {
         navigationController?.popViewController(animated: true)
     }
    
    final func setXButton() {
        let xButton = UIBarButtonItem(image: UIImage(named: "ic_back"), style: .plain, target: self, action: #selector(xButtonDidTap))
        self.navigationItem.rightBarButtonItem = xButton
    }
    
    @objc
    func xButtonDidTap() {
        guard let settingsVC = navigationController?.viewControllers[1] else {
            return print("ViewController가 존재하지 않습니다")
        }
        navigationController?.popToViewController(settingsVC, animated: true)
    }
    
    final func hideNavigationBarLine() {
        let apperance = UINavigationBarAppearance()
        apperance.configureWithTransparentBackground()
        apperance.shadowColor = .clear
        apperance.backgroundColor = .clear
        apperance.backgroundImage = nil
        apperance.shadowImage = nil
        
        navigationController?.navigationBar.standardAppearance = apperance
        navigationController?.navigationBar.compactAppearance = apperance
        navigationController?.navigationBar.scrollEdgeAppearance = apperance
    }
    
    // MARK: - 빈 화면을 눌렀을 때 키보드가 내려가도록 처리
    func dismissKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer =
            UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        self.view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        self.view.endEditing(false)
    }
    
    func setupKeyboardHiding() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardShowing), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardHiding), name: UIResponder.keyboardWillHideNotification, object: nil)

    }
    
    // MARK: - Selectors
    
    @objc func keyboardShowing(sender: NSNotification) {
        
        guard let userInfo = sender.userInfo,
              let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue,
              let currentTextField = UIResponder.currentFirst() as? UITextField else {
            return
        }
        
        let keyboardTopY = keyboardFrame.cgRectValue.origin.y
        let convertedTextFieldFrame = view.convert(currentTextField.frame, from: currentTextField.superview)
        let textFieldBottomY = convertedTextFieldFrame.origin.y + convertedTextFieldFrame.size.height
        
        if textFieldBottomY > keyboardTopY {
            let textBoxY = convertedTextFieldFrame.origin.y
            let newFrameY = (textBoxY - keyboardTopY / 2) * -1
            view.frame.origin.y = newFrameY
        }
        
    }
    
    @objc func keyboardHiding(sender: NSNotification) {
        view.frame.origin.y = 0
    }
    
    // MARK: - 정규식
    
    final func validEmail(email: String) -> Bool {
        let regexString = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        return NSPredicate(format: "SELF MATCHES %@", regexString).evaluate(with: email)
    }
    
    final func validPassword(password: String) -> Bool {
        guard password.count > 30 || password.count < 8 else { return false }
        
        let regexString = "[A-Za-z0-9!@#$&*.-]{8,100}"
        return NSPredicate(format: "SELF MATCHES %@", regexString).evaluate(with: password)
    }
    
    final func validName(name: String) -> Bool {
        guard name.filter({ !$0.isLetter }).count > 0 else { return false }
        
        let regexString = "[a-zA-Z가-힇ㄱ-ㅎㅏ-ㅣぁ-ゔァ-ヴー々〆〤一-龥]{1,10}"
        return NSPredicate( format: "SELF MATCHES %@", regexString).evaluate(with: name)
    }
}
