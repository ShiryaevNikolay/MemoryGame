//
//  Theme.swift
//  MemoryGame
//
//  Created by shiryaev on 14.10.2022.
//

import Foundation

/**
 Базовая тема приложения
 */
struct BaseTheme {
    let name: String
    let backgroundScreenColor: UInt
    let backgroundCardColor: UInt
}

/**
 Тема приложения
 */
enum Theme: CaseIterable {
    case firstTheme
    case secondTheme
    case thirdTheme
    
    func getTheme() -> BaseTheme {
        switch self {
        case .firstTheme:
            return BaseTheme(
                name: "Первая тема",
                backgroundScreenColor: 0xEDEDED,
                backgroundCardColor: 0xD9D9D9
            )
        case .secondTheme:
            return BaseTheme(
                name: "Вторая тема",
                backgroundScreenColor: 0xF5A492,
                backgroundCardColor: 0xEA8079
            )
        case .thirdTheme:
            return BaseTheme(
                name: "Третья тема",
                backgroundScreenColor: 0x92BAF5,
                backgroundCardColor: 0x79A6EA
            )
        }
    }
}
