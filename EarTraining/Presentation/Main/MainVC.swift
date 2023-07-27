//
//  MainVC.swift
//  EarTraining
//
//  Created by 김민종 on 2023/07/12.
//

import UIKit
import Combine

extension MainVC {
    static var instance: MainVC {
        return UIStoryboard(name: "Main", bundle: nil)
            .instantiateViewController(withIdentifier: "MainVC")
        as! MainVC
    }
}

class MainVC: BaseViewController {
    
    override func loadView() {
        super.loadView()
        view = MainView(frame: view.frame)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        
    }
    
    private func bind() {
        guard let mainView = view as? MainView else {
            return assertionFailure("MainView is not Exist")
        }
        
        mainView.dailyGameView.playButton.tapPublisher
            .sink { _ in
                print("Tapped")
            }
            .store(in: &cancellableBag)
        
        mainView.firstGame.playButton.tapPublisher
            .sink { _ in
                print("Tapped")
            }
            .store(in: &cancellableBag)
        
    }
   
}