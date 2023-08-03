//
//  SplashVC.swift
//  EarTraining
//
//  Created by 김민종 on 2023/07/12.
//

import UIKit

class SplashVC: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        goToMain()

    }

    private func goToMain() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            let vc = MainTabBarController.instance
            let nav = UINavigationController(rootViewController: vc)

            self.changeRootViewController(to: nav)
        }
//        let vc = TutorialVC1()
//        let nav = UINavigationController(rootViewController: vc)
//        changeRootViewController(to: nav)
//
    }
}
