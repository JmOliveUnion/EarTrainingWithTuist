//
//  UIColor+.swift
//  EarTraining
//
//  Created by 김민종 on 2023/07/12.
//

import UIKit

extension UIColor {
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat, alpha: CGFloat = 1.0) {
        self.init(red: r/255, green: g/255, blue: b/255, alpha: alpha)
    }
    
    convenience init(light: UIColor, dark: UIColor) {
        self.init { collection in
            if collection.userInterfaceStyle == .dark {
                return dark
            } else {
                return light
            }
        }
    }
    
    static let white = UIColor(r: 255, g: 255, b: 255)
    static let white_40 = UIColor(r: 255, g: 255, b: 255, alpha: 0.4)
    static let black = UIColor(r: 0, g: 0, b: 0)
    static let black_80 = UIColor(r: 0, g: 0, b: 0, alpha: 0.8)
    static let black_60 = UIColor(r: 0, g: 0, b: 0, alpha: 0.6)
    static let black_40 = UIColor(r: 0, g: 0, b: 0, alpha: 0.4)
    static let black_20 = UIColor(r: 0, g: 0, b: 0, alpha: 0.2)
    
    static let l_gray100 = UIColor(r: 132, g: 132, b: 132)
    static let l_gray200 = UIColor(r: 240, g: 240, b: 240)
    static let l_gray300 = UIColor(r: 243, g: 243, b: 243)
    static let l_gray400 = UIColor(r: 120, g: 120, b: 120)
    static let l_gray500 = UIColor(r: 242, g: 242, b: 242)
    static let l_gray600 = UIColor(r: 139, g: 139, b: 139)
    static let l_gray700 = UIColor(r: 109, g: 109, b: 109)
    static let l_gray800 = UIColor(r: 217, g: 217, b: 217)


    static let l_keyBlue = UIColor(r: 0, g: 102, b: 255)
    static let l_keyBlue200 = UIColor(r: 134, g: 182, b: 255)

    static let l_keyBlue_40 = UIColor(r: 174, g: 188, b: 255)
    static let l_keyYellow = UIColor(r: 255, g: 179, b: 0)
    static let l_keyYellow_40 = UIColor(r: 255, g: 227, b: 160)
    static let l_subRed = UIColor(r: 234, g: 65, b: 24)
    static let l_subBlue = UIColor(r: 0, g: 149, b: 242)
    static let l_subPink = UIColor(r: 255, g: 44, b: 123)
    static let l_red = UIColor(r: 234, g: 24, b: 50)
    
    static let d_gray100 = UIColor(r: 162, g: 162, b: 169)
    static let d_gray100_50 = UIColor(r: 162, g: 162, b: 169, alpha: 0.5)
    static let d_gray200 = UIColor(r: 90, g: 90, b: 95)
    static let d_gray300 = UIColor(r: 69, g: 69, b: 74)
    static let d_gray400 = UIColor(r: 45, g: 45, b: 51)
    static let d_gray500 = UIColor(r: 28, g: 28, b: 31)
    static let d_gray600 = UIColor(r: 71, g: 71, b: 80)

    static let d_keyBlue = UIColor(r: 91, g: 124, b: 255)
    static let d_keyBlue60 = UIColor(r: 40, g: 67, b: 153)
    static let d_keyYellow = UIColor(r: 255, g: 179, b: 0)
    static let d_keyYellow60 = UIColor(r: 130, g: 84, b: 0)
    static let d_subRed = UIColor(r: 234, g: 65, b: 24)
    static let d_subBlue = UIColor(r: 0, g: 149, b: 242)
    static let d_subPink = UIColor(r: 255, g: 44, b: 123)
    static let d_red = UIColor(r: 234, g: 24, b: 50)
}
