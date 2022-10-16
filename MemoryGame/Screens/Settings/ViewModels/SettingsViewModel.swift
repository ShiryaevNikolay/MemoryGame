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
    
    // MARK: - Intent(s)
    
    func changeTheme(to selectedTheme: Theme) {
        model.setTheme(selectedTheme)
    }
    
    func changeDifficalty(to selectedDifficalty: Difficalty) {
        model.setDifficalty(selectedDifficalty)
    }
}
