//
//  SurveyVC5.swift
//  EarTraining
//
//  Created by 김민종 on 2023/07/25.
//

import UIKit
import Combine

import SnapKit

class SurveyVC5: BaseViewController {

    // MARK: - View Properties
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Survey_Title2".localized
        label.font = .Roboto_B24
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    lazy var birthDayDatePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.addTarget(self, action: #selector(dateChange(datePicker:)), for: .valueChanged)
        datePicker.frame.size = CGSize(width: 0, height: 300)
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.maximumDate = Date()
        
        return datePicker
    }()
    
    private let nextButton = OliveButton(title: "Next".localized)

    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        bind()
        setNavigationBackButton()
    }
    
    // MARK: - SetUp View
    
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
            $0.top.equalToSuperview().offset(UIScreen.main.bounds.height / 15)
        }
        
        contentView.addSubview(birthDayDatePicker)
        birthDayDatePicker.snp.makeConstraints {
            $0.leading.equalTo(20)
            $0.trailing.equalTo(-20)
            $0.top.equalTo(titleLabel.snp.bottom).offset(40)
        }
        
        view.addSubview(nextButton)
        nextButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview().offset(-50)
        }
    }
    
    // MARK: - Binding
    
    private func bind() {
        print("BindSucess")
    
        nextButton.tapPublisher
            .sink {[weak self] _ in
                let vc = MainTabBarController.instance
                self?.changeRootViewController(to: vc)
            }
            .store(in: &cancellableBag)
    }
    
    // MARK: - DatePicker
    func formatDate(date: Date) -> String {
        let formatter: DateFormatter = DateFormatter()
        formatter.timeZone = TimeZone.current
        formatter.calendar = Calendar(identifier: .gregorian)
        switch Locale.current.languageCode {
        case "ko":
            formatter.dateFormat = "yyyy년"
        case "ja":
            formatter.dateFormat = "yyyy年"
        default:
            formatter.dateFormat = "yyyy"
        }
        return formatter.string(from: date)
    }
    
    @objc private func dateChange(datePicker: UIDatePicker) {
         print("\(formatDate(date: datePicker.date))")
    }
}
