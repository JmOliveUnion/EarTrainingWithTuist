//
//  LoginViewModel.swift
//  EarTraining
//
//  Created by 김민종 on 2023/07/14.
//

import Foundation
import Combine

import AuthenticationServices

protocol SocialLoginViewModeInput {
    func didTappedAppleLogin()
}

protocol SocialLoginViewModeOutput {
    var loginPublisher: PassthroughSubject<Void, Error> { get set }
}

protocol SocialLoginViewModeInAndOut: SocialLoginViewModeInput & SocialLoginViewModeOutput { }

final class LoginViewModel: NSObject, SocialLoginViewModeInAndOut {
    
    @Published var loginSucess: Bool = false

    var loginPublisher = PassthroughSubject<Void, Error>()
    
    override init() {
        super.init()
    }
    
    func didTappedAppleLogin() {
        let appleProvider = ASAuthorizationAppleIDProvider()
        let request = appleProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        
        let controller = ASAuthorizationController(authorizationRequests: [request])
        controller.delegate = self
        controller.performRequests()
    }
}

extension LoginViewModel: ASAuthorizationControllerDelegate {
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        guard let credential = authorization.credential as? ASAuthorizationAppleIDCredential else { return }
        print(credential.user)
        print(credential.user.description)
        print(credential.email)
        
        let userIdentifierStr: String = credential.user.description

        print(userIdentifierStr)
        print(String(data: credential.identityToken!, encoding: .utf8) ?? "")

        print("Login Success")
        loginPublisher.send()
        self.loginSucess = true
    
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print("Login Failed")
        loginPublisher.send(completion: .failure(error))
    }
}
