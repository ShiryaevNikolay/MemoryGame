//
//  MemoryGameApp.swift
//  MemoryGame
//
//  Created by shiryaev on 26.09.2022.
//

import SwiftUI

@main
struct MemoryGameApp: App {
    @ObservedObject var navigationViewModel: NavigationViewModel = NavigationViewModel(
        model: NavigationModel()
    )
    @ObservedObject var settingsViewModel: SettingsViewModel = SettingsViewModel(
        model: SettingsModel()
    )
    
    var body: some Scene {
        WindowGroup {
            
            if navigationViewModel.currentScreen == Screens.game {
                let game = EmojiMemoryGame(
                    theme: settingsViewModel.theme,
                    difficalty: settingsViewModel.difficalty
                )
                EmojiMemoryGameView(
                    viewModel: game,
                    navigationViewModel: navigationViewModel
                )
            } else {
                SettingsScreenView(
                    viewModel: settingsViewModel,
                    navigationViewModel: navigationViewModel
                )
            }
        }
    }
}
