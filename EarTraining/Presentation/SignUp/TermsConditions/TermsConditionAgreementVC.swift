//
//  TermsConditionAgreementVC.swift
//  EarTraining
//
//  Created by 김민종 on 2023/07/27.
//

import UIKit
import Combine

import SafariServices

final class TermsConditionAgreementVC: BaseViewController {
   
    private var mainView: TermsConditionAgreementView?
    
    var closure: (() -> Void)?

    override func loadView() {
        super.loadView()
        view = TermsConditionAgreementView(frame: view.frame)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(#function)
        
        setup()
        bind()
        
    }

    // VC Setting을 위한 매서드
    private func setup() {
        guard let mainView = view as? TermsConditionAgreementView else {
            return assertionFailure("MainView is not Exist")
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            mainView.showBottomContainerView()
        }
    }
    
    // UI Binding을 위한 매서드
    private func bind() {
        guard let mainView = view as? TermsConditionAgreementView else {
            return assertionFailure("MainView is not Exist")
        }
        
        mainView.xButton.tapPublisher
            .sink { [weak self] _ in
                self?.closure?()
                mainView.dismissWithAnimation {
                    self?.dismiss(animated: false) {
                    }
                }
               
            }
            .store(in: &cancellableBag)
        
        mainView.privacyButton.tapPublisher
            .sink { [weak self] _ in
                self?.showPrivacyView()
            }
            .store(in: &cancellableBag)
        
        mainView.termsConditionsButton.tapPublisher
            .sink { [weak self] _ in
                self?.showTermsView()
            }
            .store(in: &cancellableBag)
        
        mainView.marketingButton.tapPublisher
            .sink { [weak self] _ in
//                let storyboard = UIStoryboard(name: "Main", bundle: nil)
//                let nextViewController = storyboard.instantiateViewController(withIdentifier: "viewterms") as! ViewTermsVC
//                nextViewController.modalPresentationStyle = .overCurrentContext
//                nextViewController.view.backgroundColor = .black.withAlphaComponent(0.2)
//                self?.present(nextViewController, animated: true, completion: nil)
            }
            .store(in: &cancellableBag)
        
        mainView.topCheckButton.tapPublisher
            .sink { [weak self] _ in
                mainView.updateTopContent()
            }
            .store(in: &cancellableBag)
        
        mainView.middleCheckButton.tapPublisher
            .sink { [weak self] _ in
                let newState = !mainView.middleCheckButton.isSelected
                mainView.updateMiddleContent(to: newState)
            }
            .store(in: &cancellableBag)
        
        mainView.bottomCheckButton.tapPublisher
            .sink { [weak self] _ in
                let newState = !mainView.bottomCheckButton.isSelected
                mainView.updateBottomContent(to: newState)
            }
            .store(in: &cancellableBag)
        
        mainView.agreeButton.tapPublisher
            .sink { [weak self] _ in

                mainView.dismissWithAnimation {
                    self?.dismiss(animated: false)
                }
                
            }
            .store(in: &cancellableBag)
    }
}

extension TermsConditionAgreementVC {
    final func showPrivacyView() {
        let urlString: String
        switch Locale.current.languageCode {
        case "ko":
            urlString = "http://guide.oliveapi.com/kr/privacyPolicy.html"
        case "ja":
            urlString = "http://guide.oliveapi.com/jp/privacyPolicy.html"
        default:
            urlString = "http://guide.oliveapi.com/us/privacyPolicy.html"
        }
        
        guard let url = URL(string: urlString) else {
            return debugPrint("URL Error")
        }
        
        let vc = SFSafariViewController(url: url)
        vc.modalPresentationStyle = .fullScreen
        
        self.present(vc, animated: true)
    }
    
    final func showTermsView() {
        let urlString: String
        switch Locale.current.languageCode {
        case "ko":
            urlString = "http://guide.oliveapi.com/kr/TOS.html"
        case "ja":
            urlString = "http://guide.oliveapi.com/jp/TOS.html"
        default:
            urlString = "http://guide.oliveapi.com/us/TOS.html"
        }
        
        guard let url = URL(string: urlString) else {
            return debugPrint("URL Error")
        }
        
        let vc = SFSafariViewController(url: url)
        vc.modalPresentationStyle = .fullScreen
        
        self.present(vc, animated: true)
    }
}
