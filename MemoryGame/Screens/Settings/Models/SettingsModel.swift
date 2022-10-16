//
//  SettingsModel.swift
//  MemoryGame
//
//  Created by shiryaev on 13.10.2022.
//

import Foundation

/**
 Модель экрана настроек
 */
struct SettingsModel {
    var theme: Theme
    var difficulty: Difficalty
    
    init(
        theme: Theme = Theme.firstTheme,
        difficulty: Difficalty = Difficalty.easy
    ) {
        self.theme = theme
        self.difficulty = difficulty
    }
}
