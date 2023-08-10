//
//  OthersTableViewCell.swift
//  EarTraining
//
//  Created by 김민종 on 2023/07/25.
//

import UIKit

import SnapKit

class OthersTableViewCell: UITableViewCell {
    
    static let identifier = "OthersTableViewCell"

    private let title = ["알림설정", "이용약관", "개인정보처림방침"]
    
    private let titleLabel: UILabel = {
      let label = UILabel()
        
        return label
    }()
    
    func configure(row: Int) {
        contentView.addSubview(titleLabel)
        
        titleLabel.text = title[row]
        
        self.selectionStyle = .default
//        titleLabel.highlightedTextColor = .red
        if titleLabel.isHighlighted {
            titleLabel.backgroundColor = .red
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        titleLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(20)
        }
    }
}
