//
//  Difficalty.swift
//  MemoryGame
//
//  Created by shiryaev on 15.10.2022.
//

import Foundation

/**
 Уровнь сложности игры
 */
enum Difficalty: Int, CaseIterable {
    case easy = 8
    case normal = 12
    case hard = 24
}

extension Difficalty {
    func getText() -> String {
        switch self {
        case .easy:
            return "Легко"
        case .normal:
            return "Нормально"
        case .hard:
            return "Слооооожна!"
        }
    }
}
