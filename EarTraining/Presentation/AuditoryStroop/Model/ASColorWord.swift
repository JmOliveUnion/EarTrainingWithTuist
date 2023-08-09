//
//  ASColorWord.swift
//  EarTraining
//
//  Created by 김민종 on 2023/08/01.
//

import UIKit

enum ASColorWord: String, CaseIterable {
    case red = "RED"
    case blue = "BLUE"
    case green = "GREEN"
    case yellow = "YELLOW"
    case none = "NONE"
    
    var color: UIColor {
        switch self {
        case .red:
            return .red
        case .blue:
            return .blue
        case .green:
            return .green
        case .yellow:
            return .l_keyYellow100
        default:
            return .clear
        }
    }
    
    var enMp3Url: URL {
        switch self {
        case .red:
            return Bundle.main.url(forResource: "en_red", withExtension: "mp3")!
        case .blue:
            return Bundle.main.url(forResource: "en_blue", withExtension: "mp3")!
        case .green:
            return Bundle.main.url(forResource: "en_green", withExtension: "mp3")!
        case .yellow:
            return Bundle.main.url(forResource: "en_yellow", withExtension: "mp3")!
        default:
            return Bundle.main.url(forResource: "en_red", withExtension: "mp3")!
        }
    }
    
    var krMp3Url: URL {
        switch self {
        case .red:
            return Bundle.main.url(forResource: "kr_red", withExtension: "mp3")!
        case .blue:
            return Bundle.main.url(forResource: "kr_blue", withExtension: "mp3")!
        case .green:
            return Bundle.main.url(forResource: "kr_green", withExtension: "mp3")!
        case .yellow:
            return Bundle.main.url(forResource: "kr_yellow", withExtension: "mp3")!
        default:
            return Bundle.main.url(forResource: "kr_red", withExtension: "mp3")!
        }
    }
    
}
