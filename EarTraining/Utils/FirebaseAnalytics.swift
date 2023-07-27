//
//  FirebaseAnalytics.swift
//  EarTraining
//
//  Created by 김민종 on 2023/07/12.
//

// import Firebase

struct FireBaseAnalytics {
    
//    func pageViewEvent(name: String) {
//        var parameters = makeDefaultParameters()
//
//        Analytics.logEvent(name, parameters: parameters)
//    }
//
//    func tapActionHomeEvent(target: String, value: String? = nil, action: String? = nil, direction: String? = nil) {
//        var parameters = makeDefaultParameters()
//        parameters["TARGET"] = target
//        parameters["VALUE"] = value
//        parameters["ACTION"] = action
//        parameters["DIRECTION"] = direction
//
//        Analytics.logEvent("ACTION_TAP_CONTROL", parameters: parameters)
//    }
//
//    func tapActionSettingEvent(name: String, target: String) {
//        var parameters = makeDefaultParameters()
//        parameters["TARGET"] = target
//
//        Analytics.logEvent(name, parameters: parameters)
//    }
//
//    private func makeDefaultParameters() -> [String: String] {
//        var dicts: [String: String] = [
//            "OLIVE_DEVICE": OliveBLEManager.shared.connectedOliveDevice?.rawValue ?? "",
//            "GENDER": "",
//            "AGE": "",
//            "LOGIN": currentProvider != .local ? "true" : "false"
//        ]
//
//        if let data = UserDefaults.standard.object(forKey: UserDefault.currentUserInfo.rawValue) as? Data {
//            if let userInfo = try? JSONDecoder().decode(CurrentUserData.self, from: data) {
//                dicts["GENDER"] = userInfo.gender ?? "OTHER"
//                var year: Int?
//
//                if let stringYear = userInfo.birthday {
//                    if stringYear == "" {
//                        year = 1930
//                    } else {
//                        year = Int(String(Array(stringYear)[0..<4])) ?? 1930
//                    }
//                    let currentYear = Calendar.current.component(.year, from: Date())
//                    dicts["AGE"] = "\(currentYear - (year ?? 1930))"
//                }
//            }
//        }
//
//        return dicts
//    }
}
