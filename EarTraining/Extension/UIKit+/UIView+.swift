//
//  UIView+.swift
//  EarTraining
//
//  Created by 김민종 on 2023/07/12.
//

import UIKit

extension UIView {
    
    func fadeIn(duration: TimeInterval = 0.5, delay: TimeInterval = .zero, completed: (() -> Void)? = nil) {
        self.isHidden = false
        UIView.animate(withDuration: duration, delay: delay) {
            self.alpha = 1.0
        } completion: { bool in
            if bool { completed?() }
        }
    }

    func fadeOut(duration: TimeInterval = 0.5, delay: TimeInterval = .zero, completed: (() -> Void)? = nil) {
        UIView.animate(withDuration: duration, delay: delay) {
            self.alpha = .zero
        } completion: { bool in
            if bool {
                self.isHidden = true
                completed?()
            }
        }
    }
}
