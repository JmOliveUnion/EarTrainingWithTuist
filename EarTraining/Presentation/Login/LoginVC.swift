//
//  LoginVC.swift
//  EarTraining
//
//  Created by 김민종 on 2023/07/14.
//

import UIKit
import Combine

import SnapKit

final class LoginVC: BaseViewController {
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Our_Training\nwill_help_your_hearing!".localized
        label.font = .Roboto_B32
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
    private let appleLoginButton: UIButton = {
        let button = UIButton()
        button.setBackgroundColor(.label, for: .normal)
        button.layer.cornerRadius = 15
        button.clipsToBounds = true
        
        button.setImage(UIImage(named: "Apple Logo"), for: .normal)
        button.setTitle("Sign_Up_With_Apple".localized, for: .normal)
        button.titleLabel?.font = .Roboto_B18
        
        return button
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUp()
        bind()
    }
    
    private func setUp() {
        view.backgroundColor = .systemBackground
        
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        scrollView.addSubview(contentView)
        contentView.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.centerX.top.bottom.equalToSuperview()
        }
        
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(UIScreen.main.bounds.height / 5)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        
        view.addSubview(appleLoginButton)
        appleLoginButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview().offset(-36)
            $0.height.equalTo(60)
        }
        
    }
    
    private func bind() {
        appleLoginButton.tapPublisher
            .sink {[weak self] _ in
//                print("Apple login Tapped")
//                let vc = SurveyVC1()
//                let nav = UINavigationController(rootViewController: vc)
//                self?.changeRootViewController(to: nav)
                
                let vc = CreateUserIDVC()
                let nav = UINavigationController(rootViewController: vc)

                self?.changeRootViewController(to: nav)
            }
            .store(in: &cancellableBag)
        
    }
}
