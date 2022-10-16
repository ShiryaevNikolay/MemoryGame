//
//  SettingsViewModel.swift
//  MemoryGame
//
//  Created by shiryaev on 13.10.2022.
//

import Foundation

/**
 ViewModel экрана настроек
 */
class SettingsViewModel: ObservableObject {
    
    init() {
        model = SettingsModel()
    }
    
    @Published private var model: SettingsModel
    
    // MARK: - Access to the model
    
    var theme: Theme {
        model.theme
    }
    
    var difficalty: Difficalty {
        model.difficulty
    }
    
    var cardView: EmojiCard {
        EmojiCard(content: "🐱", id: 0)
    }
    
    // MARK: - Intent(s)
    
    func changeTheme() {
        // TODO: менять тему
    }
    
    func changeDifficalty() {
        // TODO: менять уровень сложности
    }
}
