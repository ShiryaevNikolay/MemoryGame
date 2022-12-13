//
//  SettingsModel.swift
//  MemoryGame
//
//  Created by shiryaev on 12.12.2022.
//

import Foundation

struct SettingsModel {
    var theme: Themes
    var difficalty: Difficalties
    
    init(
        theme: Themes = Themes.firstTheme,
        difficalty: Difficalties = Difficalties.easy
    ) {
        self.theme = theme
        self.difficalty = difficalty
    }
    
    mutating func setTheme(_ selectedTheme: Themes) {
        self.theme = selectedTheme
    }
    
    mutating func setDifficalty(_ selectedDifficalty: Difficalties) {
        self.difficalty = selectedDifficalty
    }
}
