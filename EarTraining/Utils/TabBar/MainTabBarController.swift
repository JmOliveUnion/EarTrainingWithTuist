//
//  MainTabBarController.swift
//  EarTraining
//
//  Created by 김민종 on 2023/07/12.
//

import UIKit

extension MainTabBarController {
    static var instance: MainTabBarController {
        return UIStoryboard(name: "MainTabBar", bundle: nil)
            .instantiateViewController(withIdentifier: "MainTabBarController")
        as! MainTabBarController
    }
}

final class MainTabBarController: UITabBarController {
    
    let mainVC = MainVC.instance
    let settingVC = SettingVC.instance

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUp()
        setupTabIcon()

    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        setupTabIcon()
    }
    
    private func setUp() {
        navigationController?.navigationBar.isHidden = true

        tabBar.tintColor = .blue
        tabBar.unselectedItemTintColor = .lightGray
        
        viewControllers = [mainVC, settingVC]
        
        let apperance = UITabBarAppearance()
//        apperance.configureWithTransparentBackground()
        apperance.shadowColor = .systemGray4
        tabBar.standardAppearance = apperance
        tabBar.scrollEdgeAppearance = tabBar.standardAppearance
    }
    
    private func setupTabIcon() {
        mainVC.tabBarItem = UITabBarItem(
            title: "트레이닝".localized,
            image: UIImage(named: Image.homeTab.rawValue),
            selectedImage: UIImage(named: Image.homeTabSelected.rawValue)
        )
        
        settingVC.tabBarItem = UITabBarItem(
            title: "프로필".localized,
            image: UIImage(named: Image.settingTab.rawValue),
            selectedImage: UIImage(named: Image.settingTabSelected.rawValue)
        )
    }
    
}
