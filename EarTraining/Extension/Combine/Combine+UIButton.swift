//
//  Combine+UIButton.swift
//  EarTraining
//
//  Created by 김민종 on 2023/07/12.
//

import UIKit
import Combine

extension UIButton {
    var tapPublisher: AnyPublisher<Void, Never> {
        return controlPublisher(for: .touchUpInside)
            .map { _ in }
            .eraseToAnyPublisher()
    }
    
    var tapPublisherTouchDown: AnyPublisher<Void, Never> {
        return controlPublisher(for: .touchDown)
            .map { _ in }
            .eraseToAnyPublisher()
    }
}
