//
//  Constants.swift
//  EarTraining
//
//  Created by 김민종 on 2023/07/12.
//

import Foundation

struct Constants {
    // 빌드 버전
    var buildVersion: String? {
        guard let dictionary = Bundle.main.infoDictionary,
            let build = dictionary["CFBundleVersion"] as? String else {return nil}
        
        let versionAndBuild: String = "\(build)"
        return versionAndBuild
    }
    // 앱 버전
    var appVersion: String? {
        guard let dictionary = Bundle.main.infoDictionary,
            let version = dictionary["CFBundleShortVersionString"] as? String else {return nil}
        
        let versionAndBuild: String = "\(version)"
        return versionAndBuild
    }
}
