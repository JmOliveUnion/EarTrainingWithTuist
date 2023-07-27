//
//  SurveyVC1.swift
//  EarTraining
//
//  Created by 김민종 on 2023/07/24.
//

import UIKit
import Combine

import SnapKit

final class SurveyVC1: BaseViewController {
    
    // MARK: - Properties
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Survey_Title1".localized
        label.font = .Roboto_B24
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
    let nextButton = OliveButton(title: "Next".localized)

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        bind()
        hideNavigationBarLine()
    }
    
    // MARK: - View
    
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
            $0.leading.equalTo(20)
            $0.trailing.equalTo(-20)
            $0.top.equalToSuperview().offset(UIScreen.main.bounds.height / 13)
        }
        
        view.addSubview(nextButton)
        nextButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview().offset(-50)
        }
    }
    
    private func bind() {
        nextButton.tapPublisher
            .sink {[weak self] _ in
                let vc = SurveyVC2()
                self?.navigationController?.pushViewController(vc, animated: true)
            }
            .store(in: &cancellableBag)
    }
}
