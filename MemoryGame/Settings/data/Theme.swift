//
//  Theme.swift
//  MemoryGame
//
//  Created by shiryaev on 12.12.2022.
//

import Foundation

/**
 Темы приложения
 */
enum Themes: CaseIterable {
    case firstTheme
    case secondTheme
    case thirdTheme
}

struct Theme {
    let name: String
    let backgroundColor: UInt
    let cardColor: UInt
}
