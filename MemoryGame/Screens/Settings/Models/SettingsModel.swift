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
        difficulty: Difficalty = Difficalty.normal
    ) {
        self.theme = theme
        self.difficulty = difficulty
    }
    
    mutating func setTheme(_ selectedTheme: Theme) {
        self.theme = selectedTheme
    }
    
    mutating func setDifficalty(_ selectedDifficalty: Difficalty) {
        self.difficulty = selectedDifficalty
    }
}
