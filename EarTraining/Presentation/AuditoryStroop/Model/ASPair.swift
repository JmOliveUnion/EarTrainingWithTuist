//
//  ASPair.swift
//  EarTraining
//
//  Created by 김민종 on 2023/08/01.
//

import Foundation

struct ASPair: Identifiable, Equatable {
    let word: ASColorWord
    let color: ASColorWord
    
    var id: UUID { UUID() }
}
