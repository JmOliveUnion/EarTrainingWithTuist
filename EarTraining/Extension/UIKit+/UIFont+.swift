//
//  UIFont+.swift
//  EarTraining
//
//  Created by 김민종 on 2023/07/12.
//

import UIKit

extension UIFont {
    static let Roboto_B60 = oliveFont(type: "Bold", size: 60)
    static let Roboto_B48 = oliveFont(type: "Bold", size: 48)
    static let Roboto_B40 = oliveFont(type: "Bold", size: 40)
    static let Roboto_B32 = oliveFont(type: "Bold", size: 32)
    static let Roboto_B28 = oliveFont(type: "Bold", size: 28)
    static let Roboto_B24 = oliveFont(type: "Bold", size: 24)
    static let Roboto_B20 = oliveFont(type: "Bold", size: 20)
    static let Roboto_B18 = oliveFont(type: "Bold", size: 18)
    static let Roboto_B16 = oliveFont(type: "Bold", size: 16)
    static let Roboto_B14 = oliveFont(type: "Bold", size: 14)
    static let Roboto_B12 = oliveFont(type: "Bold", size: 12)
    
    static let Roboto_R48 = oliveFont(type: "Regular", size: 48)
    static let Roboto_R32 = oliveFont(type: "Regular", size: 32)
    static let Roboto_R30 = oliveFont(type: "Regular", size: 30)
    static let Roboto_R28 = oliveFont(type: "Regular", size: 28)
    static let Roboto_R26 = oliveFont(type: "Regular", size: 26)
    static let Roboto_R24 = oliveFont(type: "Regular", size: 24)
    static let Roboto_R20 = oliveFont(type: "Regular", size: 20)
    static let Roboto_R18 = oliveFont(type: "Regular", size: 18)
    static let Roboto_R16 = oliveFont(type: "Regular", size: 16)
    static let Roboto_R15 = oliveFont(type: "Regular", size: 15)
    static let Roboto_R14 = oliveFont(type: "Regular", size: 14)
    static let Roboto_R12 = oliveFont(type: "Regular", size: 12)
    
    static let Roboto_L40 = oliveFont(type: "Light", size: 40)
    static let Roboto_L26 = oliveFont(type: "Light", size: 26)
    static let Roboto_L24 = oliveFont(type: "Light", size: 24)
    static let Roboto_L18 = oliveFont(type: "Light", size: 18)
    static let Roboto_L16 = oliveFont(type: "Light", size: 16)
    static let Roboto_L14 = oliveFont(type: "Light", size: 14)
    static let Roboto_L12 = oliveFont(type: "Light", size: 12)
    static let Roboto_L10 = oliveFont(type: "Light", size: 10)

    static func oliveFont(type: String, size: CGFloat) -> UIFont {
        switch NSLocale.autoupdatingCurrent.languageCode {
        case "ko":
            return UIFont(name: "NotoSansKR-\(type)", size: size) ?? UIFont(name: "AppleSDGothicNeo-\(type)", size: size)!
        case "jp":
            return UIFont(name: "NotoSansJP-\(type)", size: size) ?? UIFont(name: "AppleSDGothicNeo-\(type)", size: size)!
        default:
            return UIFont(name: "Roboto-\(type)", size: size) ?? UIFont(name: "AppleSDGothicNeo-\(type)", size: size)!
        }
    }
}
