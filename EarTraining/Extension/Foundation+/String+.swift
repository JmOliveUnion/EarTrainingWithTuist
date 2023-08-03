//
//  String+.swift
//  EarTraining
//
//  Created by 김민종 on 2023/07/12.
//

import Foundation

extension String {
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
    
    func substrFrom(from: Int) -> String {
        let fromIndex = self.index(self.startIndex, offsetBy: from)
        return String(self[fromIndex...])
    }
}
