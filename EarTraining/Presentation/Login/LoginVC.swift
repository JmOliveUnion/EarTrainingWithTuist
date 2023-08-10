//
//  LoginVC.swift
//  EarTraining
//
//  Created by 김민종 on 2023/07/14.
//

import UIKit
import Combine

import SnapKit
import Alamofire

final class LoginVC: BaseViewController {
    
    private let vm = LoginViewModel()
        
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "우리의 트레이닝은\n당신의 청력에 도움을\n줄거에요!".localized
        label.font = .Roboto_R32
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
    private let imageView: UIImageView = {
       let image = UIImageView()
        image.image = UIImage(named: Image.loginImage.rawValue)
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private let checkImage: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "circleUncheck"), for: .normal)
        button.setImage(UIImage(named: "circleCheck"), for: .selected)
        return button
    }()
    
    private let personalInformation: UIButton = {
       let button = UIButton()
        button.setTitle( "  개인정보처리방침", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        return button
    }()
    
    private let orLabel: UILabel = {
        let label = UILabel()
        label.text = "및"
        label.textColor = .lightGray
        label.font = .Roboto_R14
        return label
    }()
    
    private let termsAndConditions: UIButton = {
       let button = UIButton()
        button.setTitle("이용 약관", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        return button
    }()
    
    private let agreeLabel: UILabel = {
        let label = UILabel()
        label.text = "에 동의합니다."
        label.textColor = .lightGray
        label.font = .Roboto_R14
        return label
    }()
    
    private lazy var checkStackView: UIStackView = {
       let stack = UIStackView(arrangedSubviews: [checkImage, personalInformation, orLabel, termsAndConditions, agreeLabel])
        stack.spacing = 3
        stack.distribution = .fillProportionally
        return stack
    }()
    
    private let appleLoginButton: UIButton = {
        let button = UIButton()
        button.setBackgroundColor(.label, for: .normal)
        button.layer.cornerRadius = 15
        button.clipsToBounds = true
        button.setImage(UIImage(named: "AppleLoginButton"), for: .normal)
        
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
            $0.top.equalToSuperview().offset(UIScreen.main.bounds.height / 6)
            $0.leading.trailing.equalToSuperview().inset(20)

        }
        
        contentView.addSubview(imageView)
        imageView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(70)
            $0.leading.trailing.equalToSuperview().inset(0)
        }
        
        contentView.addSubview(checkStackView)
        checkStackView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(imageView.snp.bottom).offset(50)
        }
        
        contentView.addSubview(appleLoginButton)
        appleLoginButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(64)
            $0.top.greaterThanOrEqualTo(checkStackView.snp.bottom).offset(15)
            $0.bottom.equalToSuperview().offset(-36)
        }
        
    }
    
    private func bind() {
        
        checkImage.tapPublisher
            .sink {[weak self] _ in
                HapticManager.instace.impact(type: .medium)
                self?.checkImage.isSelected.toggle()
            }
        
            .store(in: &cancellableBag)
        
        personalInformation.tapPublisher
            .sink { _ in
                
            }
            .store(in: &cancellableBag)
        
        termsAndConditions.tapPublisher
            .sink { _ in
                
            }
            .store(in: &cancellableBag)
        
        appleLoginButton.tapPublisher
            .sink {[weak self] _ in
                guard NetworkReachabilityManager()?.isReachable == true else {
                    self?.showNetworkDisconnectedAlert()
                    return
                }
                HapticManager.instace.impact(type: .medium)
                self?.vm.didTappedAppleLogin()
            }
            .store(in: &cancellableBag)
        
        vm.$loginSucess
            .sink {[weak self] isOn in
                if isOn {
                    print("Tapped")
                    let vc = MainTabBarController.instance
                    let nav = UINavigationController(rootViewController: vc)
                    self?.changeRootViewController(to: nav)
                }
            }
            .store(in: &cancellableBag)
        
    }
}
