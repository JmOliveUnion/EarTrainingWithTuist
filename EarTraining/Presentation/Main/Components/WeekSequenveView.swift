//
//  WeekSequenveView.swift
//  EarTraining
//
//  Created by 김민종 on 2023/08/08.
//

import UIKit

import SnapKit

final class WeekSequenveView: UIView {
    
    enum Day: String, CaseIterable {
        case mon = "월"
        case tue = "화"
        case wed = "수"
        case thu = "목"
        case fri = "금"
        case sat = "토"
        case sun = "일"
    }
    
    private var day: Day = .mon
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        getDate()

        let stackView = UIStackView()
        stackView.distribution = .fillEqually
        
        Day.allCases.forEach {
            let view = makeDayView(day: $0)
            stackView.addArrangedSubview(view)
        }
        self.addSubview(stackView)
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    private func makeDayView(day: Day) -> UIView {
        let view = UIView()
        
        let todayLabel = UILabel()
        todayLabel.text = "오늘"
        todayLabel.textColor = .white
        todayLabel.textAlignment = .center
        todayLabel.font = .Roboto_R12
        
        let image = UIImageView()
        image.image = UIImage(named: Image.unchecked.rawValue)
        image.contentMode = .scaleAspectFit
        
        let dateLabel = UILabel()
        dateLabel.textColor = .white
        dateLabel.textAlignment = .center
        dateLabel.clipsToBounds = true
        dateLabel.font = .Roboto_R16
        dateLabel.text = day.rawValue
        
        view.addSubview(todayLabel)
        todayLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(10)
        }
        
        view.addSubview(image)
        image.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(todayLabel.snp.bottom).offset(5)
        }
        
        view.addSubview(dateLabel)
        dateLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(image.snp.bottom).offset(7)
        }
        
        todayLabel.isHidden = self.day != day
        view.backgroundColor = self.day == day ? .white.withAlphaComponent(0.3) : .clear
        view.layer.cornerRadius = 15
        return view
    }
    
    private func getDate() {
        let weekArray: [Int] = [1, 2, 3, 4, 5, 6, 7]
        let date = Date()
        let calendar = Calendar.current
        let weekday = calendar.component(.weekday, from: date)
        let weekdaySymbol = calendar.shortWeekdaySymbols[weekday - 1]
        self.day = Day(rawValue: weekdaySymbol) ?? .mon
    }
}
