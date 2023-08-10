//
//  AppDelegate.swift
//  EarTraining
//
//  Created by 김민종 on 2023/07/12.
//

import UIKit

import FirebaseCore
import FirebaseFirestore
import FirebaseAuth
import AuthenticationServices

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let apperance = UINavigationBarAppearance()
        apperance.configureWithTransparentBackground()
        apperance.shadowColor = .systemGray2
        apperance.titleTextAttributes = [NSAttributedString.Key.font: UIFont.Roboto_R24]
        UINavigationBar.appearance().scrollEdgeAppearance = apperance
        
        let scrollApperance = UINavigationBarAppearance()
        scrollApperance.configureWithOpaqueBackground()
        scrollApperance.titleTextAttributes = [NSAttributedString.Key.font: UIFont.Roboto_R24]
        
        UINavigationBar.appearance().standardAppearance = scrollApperance
        
//        FirebaseApp.configure()
        
        // MARK: - Apple Login
        
        let appleIDProvider = ASAuthorizationAppleIDProvider()
           appleIDProvider.getCredentialState(forUserID: "rlaalswhd200@naver.com") { (credentialState, error) in
               switch credentialState {
               case .authorized:
                   // The Apple ID credential is valid.
                   print("해당 ID는 연동되어있습니다.")
               case .revoked:
                   // The Apple ID credential is either revoked or was not found, so show the sign-in UI.
                   print("해당 ID는 연동되어있지않습니다.")
               case .notFound:
                   // The Apple ID credential is either was not found, so show the sign-in UI.
                   print("해당 ID를 찾을 수 없습니다.")
               default:
                   break
               }
           }
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

}
