//
//  Device+.swift
//  EarTraining
//
//  Created by 김민종 on 2023/07/12.
//

import UIKit

extension UIDevice {
    
    static var iPhoneSE_7_8_Series: Bool {
        return UIScreen.main.bounds.size.height == 667
    }
    
    static var iPhone7Plus8PlusSeries: Bool {
        return UIScreen.main.bounds.size.height == 736
    }

//    static let modelName: String = {
//        var systemInfo = utsname()
//        uname(&systemInfo)
//        let machineMirror = Mirror(reflecting: systemInfo.machine)
//        let identifier = machineMirror.children.reduce("") { identifier, element in
//            guard let value = element.value as? Int8, value != 0 else { return identifier }
//            return identifier + String(UnicodeScalar(UInt8(value)))
//        }
//
//        func mapToDevice(identifier: String) -> String {
// #if os(iOS)
//            switch identifier {
//            case "iPhone8,1":       return "iPhone 6s"
//            case "iPhone8,2":       return "iPhone 6s Plus"
//            case "iPhone8,4":      return "iPhone SE"
//            case "iPhone9,1":      return "iPhone 7"
//            case "iPhone9,2":      return "iPhone 7 Plus"
//            case "iPhone9,3":      return "iPhone 7"
//            case "iPhone9,4":      return "iPhone 7 Plus"
//            case "iPhone10,1":     return "iPhone 8"
//            case "iPhone10,2":     return "iPhone 8 Plus"
//            case "iPhone10,3":     return "iPhone X Global"
//            case "iPhone10,4":     return "iPhone 8"
//            case "iPhone10,5":     return "iPhone 8 Plus"
//            case "iPhone10,6":     return "iPhone X GSM"
//            case "iPhone11,2":     return "iPhone XS"
//            case "iPhone11,4":     return "iPhone XS Max"
//            case "iPhone11,6":     return "iPhone XS Max Global"
//            case "iPhone11,8":     return "iPhone XR"
//            case "iPhone12,1":     return "iPhone 11"
//            case "iPhone12,3":     return "iPhone 11 Pro"
//            case "iPhone12,5":     return "iPhone 11 Pro Max"
//            case "iPhone12,8":     return "iPhone SE 2nd Gen"
//            case "iPhone13,1":     return "iPhone 12 Mini"
//            case "iPhone13,2":     return "iPhone 12"
//            case "iPhone13,3":     return "iPhone 12 Pro"
//            case "iPhone13,4":     return "iPhone 12 Pro Max"
//            case "iPhone14,2":     return "iPhone 13 Pro"
//            case "iPhone14,3":     return "iPhone 13 Pro Max"
//            case "iPhone14,4":     return "iPhone 13 Mini"
//            case "iPhone14,5":     return "iPhone 13"
//            case "iPhone14,6":     return "iPhone SE 3rd Gen"
//            case "iPhone14,7":     return "iPhone 14"
//            case "iPhone14,8":     return "iPhone 14 Plus"
//            case "iPhone15,2":     return "iPhone 14 Pro"
//            case "iPhone15,3":     return "iPhone 14 Pro Max"
//            default:                return identifier
//            }
// #endif
//        }
//        return mapToDevice(identifier: identifier)
//    }()
    
    static var modelCode: String {
        if let simulatorModelIdentifier = ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] { return simulatorModelIdentifier }
        var systemInfo = utsname()
        uname(&systemInfo)
        return withUnsafeMutablePointer(to: &systemInfo.machine) { ptr in String(cString: UnsafeRawPointer(ptr).assumingMemoryBound(to: CChar.self)) }
    }
    
    static func getModelNumber() -> Int {
        var modelNumber: Int = 0
        let modelCode = UIDevice.modelCode
        
        if modelCode.contains("iPhone") {
            let tempCode = modelCode.replacingOccurrences(of: "iPhone", with: "")
            let tempNumber = tempCode.split(separator: ",")
            if tempNumber.count > 1 {
                modelNumber = Int(String(tempNumber[0]) as String)!
            }
        }
        return modelNumber
    }

}
