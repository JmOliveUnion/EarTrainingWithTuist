//
//  Combine+UITextField.swift
//  EarTraining
//
//  Created by 김민종 on 2023/07/12.
//

import UIKit
import Combine

extension UITextField {
    var textPublisher: AnyPublisher<String, Never> {
        return controlPublisher(for: .editingChanged)
            .map { _ in self.text ?? ""}
            .eraseToAnyPublisher()
    }
    
    var endEditing: AnyPublisher<UITextField, Never> {
        return controlPublisher(for: .editingDidEnd)
            .map { _ in self }
            .eraseToAnyPublisher()
    }
    
    var startEditing: AnyPublisher<UITextField, Never> {
        return controlPublisher(for: .editingDidBegin)
            .map { _ in self }
            .eraseToAnyPublisher()
    }
}
