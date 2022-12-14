//
//  SettingsViewModel.swift
//  MemoryGame
//
//  Created by shiryaev on 12.12.2022.
//

import Foundation

class SettingsViewModel: ObservableObject {
    
    init(model: SettingsModel) {
        self.model = model
    }
    
    @Published private var model: SettingsModel
    
    // MARK: - Access to the model
    
    var theme: Themes {
        model.theme
    }
    
    var difficalty: Difficalties {
        model.difficalty
    }
    
    // MARK: - Intent(s)
    
    func changeTheme(to selectedTheme: Themes) {
        model.setTheme(selectedTheme)
    }
    
    func changeDifficalty(to selectedDifficalty: Difficalties) {
        model.setDifficalty(selectedDifficalty)
    }
    
    func setRandomTheme() {
        let randomTheme = Themes.allCases.randomElement()
        changeTheme(to: randomTheme!)
    }
}
