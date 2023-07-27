//
//  AlertBuilder.swift
//  EarTraining
//
//  Created by 김민종 on 2023/07/13.
//

import UIKit

struct AlertAction {
    let title: String
    let style: UIAlertAction.Style
    let completion: (() -> Void)?
}

final class AlertBuilder {
    private var actions: [AlertAction] = []
    private weak var viewController: UIViewController?
    
    init(viewController: UIViewController?) {
        self.viewController = viewController
    }
    
    func addAction(title: String, style: UIAlertAction.Style = .default, action: (() -> Void)? = nil) -> Self {
        actions.append(AlertAction(title: title.localized, style: style, completion: action))
        return self
    }
    
    func show(title: String? = nil, message: String? = nil, style: UIAlertController.Style = .alert) {
        let alertController = UIAlertController(title: title?.localized, message: message?.localized, preferredStyle: style)
        
        actions.forEach { action in
            let alertAction = UIAlertAction(title: action.title.localized, style: action.style) { _ in
                action.completion?()
            }
            alertController.addAction(alertAction)
        }
        
        DispatchQueue.main.async {
            self.viewController?.present(alertController, animated: true)
        }
    }
}
