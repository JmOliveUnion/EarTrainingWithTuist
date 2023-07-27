//
//  NumberSequenceView.swift
//  EarTraining
//
//  Created by 김민종 on 2023/07/27.
//

import UIKit

final class NumberSequenceView: UIView {
    enum Order: String, CaseIterable {
        case one = "1"
        case two = "2"
        case three = "3"
    }
    
    private let order: Order
    
    init(order: Order) {
        self.order = order
        super.init(frame: .zero)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        let stackView = UIStackView()
        stackView.spacing = 10
        
        Order.allCases.forEach {
            let view = makeCircleView(order: $0)
            stackView.addArrangedSubview(view)
        }
        
        self.addSubview(stackView)
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    private func makeCircleView(order: Order) -> UIView {
        let label = UILabel()
        
        label.textAlignment = .center
        label.text = order.rawValue
        label.textColor = .systemBackground
        label.font = .Roboto_B16
        
        label.backgroundColor = self.order == order ? .l_keyBlue : .lightGray
        label.clipsToBounds = true
        label.layer.cornerRadius = 15
        label.snp.makeConstraints {
            $0.width.height.equalTo(30)
        }
        
        return label
    }
}
