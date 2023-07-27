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
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        goToMain()
    }
    private func goToMain() {
//        let vc = MainTabBarController.instance
//        changeRootViewController(to: vc)

        let vc = TutorialVC1()
        let nav = UINavigationController(rootViewController: vc)
        changeRootViewController(to: nav)
        
    }
}
