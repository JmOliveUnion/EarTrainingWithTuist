//
//  ProfileTableViewCell.swift
//  EarTraining
//
//  Created by 김민종 on 2023/07/25.
//

import UIKit
import Combine

import SnapKit

class ProfileTableViewCell: UITableViewCell {
    
    var cancellableBag = Set<AnyCancellable>()
    
//    var delegate = SettingVC()
    var logOutButtonTapped: (() -> Void)?

    static let identifier = "ProfileTableViewCell"
    
    @IBOutlet weak var profileTitleLabel: UILabel!
    @IBOutlet weak var profileEditImageView: UIImageView!
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var loginProviderImageView: UIImageView!
    
    private let nickNameLabel: UILabel = {
       let label = UILabel()
        label.text = "닉네임"
        label.font = .Roboto_B18
        label.textColor = .l_gray1100
        return label
    }()
    
    private lazy var nickNameTextField: UITextField = {
       let tf = UITextField()
        tf.textColor = .label
        tf.font = UIFont.systemFont(ofSize: 18)
        tf.layer.borderWidth = 1.0
        tf.layer.borderColor = UIColor.l_gray1200.cgColor
        tf.layer.cornerRadius = 15
        tf.placeholder = "닉네임"
        tf.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: tf.frame.height))
        tf.leftViewMode = .always
        return tf
    }()
    
    private let birthdayLabel: UILabel = {
       let label = UILabel()
        label.text = "생년월일"
        label.font = .Roboto_B18
        label.textColor = .l_gray1100
        return label
    }()
    
    private lazy var birthdayTextField: UITextField = {
       let tf = UITextField()
        tf.textColor = .label
        tf.font = UIFont.systemFont(ofSize: 18)
        tf.layer.borderWidth = 1.0
        tf.layer.borderColor = UIColor.l_gray1200.cgColor
        tf.layer.cornerRadius = 15
        tf.placeholder = "생년월일"
        tf.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: tf.frame.height))
        tf.leftViewMode = .always
        return tf
    }()
    
    private let genderLabel: UILabel = {
       let label = UILabel()
        label.text = "성별"
        label.font = .Roboto_B18
        label.textColor = .l_gray1100
        return label
    }()
    
    private lazy var genderTextField: UITextField = {
       let tf = UITextField()
        tf.textColor = .label
        tf.font = UIFont.systemFont(ofSize: 18)
        tf.layer.borderWidth = 1.0
        tf.layer.borderColor = UIColor.l_gray1200.cgColor
        tf.layer.cornerRadius = 15
        tf.placeholder = "성별"
        tf.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: tf.frame.height))
        tf.leftViewMode = .always
        return tf
    }()
    
    let logoutButton: UIButton = {
       let button = UIButton()
        
        button.setTitle("로그아웃", for: .normal)
        button.setTitleColor(.red, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        return button
    }()
    
    // MARK: - Life Cycle
    
    static func nib() -> UINib {
        return UINib(nibName: "ProfileTableViewCell", bundle: nil)
    }
    
    public func configure(profileImage: String, name: String, email: String) {
        profileImageView.image = UIImage(named: profileImage)
        nameLabel.text = name
        emailLabel.text = email
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        
        profileTitleLabel.text = "프로필".localized
        profileTitleLabel.font = .Roboto_B32
        
        nameLabel.font = .Roboto_B24
        emailLabel.font = .Roboto_R14
        emailLabel.textColor = .l_gray100
        
        loginProviderImageView.image = UIImage(named: "mail")
        loginProviderImageView.contentMode = .scaleAspectFit
        
        setUp()
        bind()
        self.selectionStyle = .none
    }
    
    // MARK: - View SetUp
    
    private func setUp() {
        addSubview(nickNameLabel)
        nickNameLabel.snp.makeConstraints {
            $0.leading.equalTo(profileImageView.snp.leading)
            $0.top.equalTo(profileImageView.snp.bottom).offset(20)
        }
        
        addSubview(nickNameTextField)
        nickNameTextField.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(53)
            $0.top.equalTo(nickNameLabel.snp.bottom).offset(10)
            
        }
        
        addSubview(birthdayLabel)
        birthdayLabel.snp.makeConstraints {
            $0.leading.equalTo(profileImageView.snp.leading)
            $0.top.equalTo(nickNameTextField.snp.bottom).offset(20)
        }
        
        addSubview(birthdayTextField)
        birthdayTextField.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(53)
            $0.top.equalTo(birthdayLabel.snp.bottom).offset(10)
        }
        
        addSubview(genderLabel)
        genderLabel.snp.makeConstraints {
            $0.leading.equalTo(profileImageView.snp.leading)
            $0.top.equalTo(birthdayTextField.snp.bottom).offset(20)
        }
        
        addSubview(genderTextField)
        genderTextField.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(53)
            $0.top.equalTo(genderLabel.snp.bottom).offset(10)
        }
        
        addSubview(logoutButton)
        logoutButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(genderTextField.snp.bottom).offset(40)
            $0.bottom.greaterThanOrEqualToSuperview().offset(-40)
        }
    }
    
    private func bind() {
        logoutButton.tapPublisher
            .sink {[weak self] _ in
                self?.logOutButtonTapped?()
            }
            .store(in: &cancellableBag)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
