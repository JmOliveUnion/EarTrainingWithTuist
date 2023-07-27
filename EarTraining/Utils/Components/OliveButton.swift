//
//  OliveButton.swift
//  EarTraining
//
//  Created by 김민종 on 2023/07/13.
//

import UIKit
import Combine

import SnapKit

final class OliveButton: UIButton {
    
    private var cancelbuttons = Set<AnyCancellable>()
    
    enum ButtonState {
        case enabled
        case disabled
    }
    
    @Published var buttonState: ButtonState = .enabled
    
    init(title: String) {
        super.init(frame: .zero)
        setTitle(title.localized, for: .normal)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUp() {
        self.setTitleColor(.systemBackground, for: .normal)
        self.setBackgroundColor(.l_keyBlue, for: .normal)
        
        self.setTitleColor(.init(light: .l_gray400, dark: .l_gray400), for: .disabled)
        self.setBackgroundColor(.init(light: .l_gray300, dark: .l_gray400), for: .disabled)
        
        self.layer.cornerRadius = 15
        self.clipsToBounds = true
        self.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        
        self.snp.makeConstraints {
            $0.height.equalTo(60)
        }
        
        self.$buttonState.sink { [weak self] value in
            switch value {
            case .disabled:
                self?.disabled()
            case .enabled:
                self?.enabled()
            }
        }.store(in: &cancelbuttons)
    }
    
    private func disabled() {
        self.isEnabled = false
    }
    
    private func enabled() {
        self.isEnabled = true
    }
}
