//
//  EarTrainingStartVC.swift
//  EarTraining
//
//  Created by 김민종 on 2023/07/28.
//

import UIKit
import Combine

import SnapKit

class EarTrainingStartVC: BaseViewController {
    
    // MARK: - Properties
    
    private lazy var imageView: UIImageView = {
       let image = UIImageView()
        image.image = UIImage(named: Image.homeTab.rawValue)
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private let descriptionImage1: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: Image.homeTab.rawValue)
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private let descriptionTitle1: UILabel = {
       let label = UILabel()
        label.text = "Survey_Title1".localized
        label.font = .Roboto_B18
        return label
    }()
    
    private let descriptionDetail1: UILabel = {
       let label = UILabel()
        label.text = "Survey_description".localized
        label.font = .Roboto_R16
        return label
    }()
    
    private lazy var descriptionLabelStackView1: UIStackView = {
       let stack = UIStackView(arrangedSubviews: [descriptionTitle1, descriptionDetail1])
        stack.axis = .vertical
        stack.spacing = 5
        return stack
    }()
    
    private lazy var descriptionStackView1: UIStackView = {
       let stack = UIStackView(arrangedSubviews: [descriptionImage1, descriptionLabelStackView1])
        stack.axis = .horizontal
        stack.distribution = .fillProportionally
        stack.spacing = 10
        return stack
    }()
    
    private let descriptionImage2: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: Image.homeTab.rawValue)
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private let descriptionTitle2: UILabel = {
       let label = UILabel()
        label.text = "Survey_Title1".localized
        label.font = .Roboto_B18
        return label
    }()
    
    private let descriptionDetail2: UILabel = {
       let label = UILabel()
        label.text = "Survey_description".localized
        label.font = .Roboto_R16
        return label
    }()
    
    private lazy var descriptionLabelStackView2: UIStackView = {
       let stack = UIStackView(arrangedSubviews: [descriptionTitle2, descriptionDetail2])
        stack.axis = .vertical
        stack.spacing = 5
        return stack
    }()
    
    private lazy var descriptionStackView2: UIStackView = {
       let stack = UIStackView(arrangedSubviews: [descriptionImage2, descriptionLabelStackView2])
        stack.axis = .horizontal
        stack.distribution = .fillProportionally
        stack.backgroundColor = .white

        stack.spacing = 10
        return stack
    }()
    
    private let resultTitle: UILabel = {
       let label = UILabel()
        label.text = "training_result_title".localized
        label.font = .Roboto_B28
        return label
    }()
    
    private let nextButton = OliveButton(title: "Start".localized)
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        bind()
        setNavigationBackButton()
    }
    
    // MARK: - Setup
    
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
        
        contentView.addSubview(imageView)
        imageView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(view.safeAreaLayoutGuide).multipliedBy(0.4)
            $0.top.equalTo(contentView.snp.top).offset(10)

        }
        
        contentView.addSubview(descriptionStackView1)
        descriptionStackView1.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.top.equalTo(imageView.snp.bottom).offset(20)
        }
        
        contentView.addSubview(descriptionStackView2)
        descriptionStackView2.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.top.equalTo(descriptionStackView1.snp.bottom).offset(20)
        }
        
        contentView.addSubview(resultTitle)
        resultTitle.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.top.equalTo(descriptionStackView2.snp.bottom).offset(40)
        }
        
        view.addSubview(nextButton)
        nextButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview().offset(-50)
        }
    }
    
    // MARK: - Bind
    
    private func bind() {
        nextButton.tapPublisher
            .sink {[weak self] _ in
                print("")
                let vc = AuditoryStroopVC()
                vc.modalPresentationStyle = .fullScreen
                self?.navigationController?.pushViewController(vc, animated: true)
            }
            .store(in: &cancellableBag)
    }

}
