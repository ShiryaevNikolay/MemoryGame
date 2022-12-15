//
//  GameRules.swift
//  MemoryGame
//
//  Created by shiryaev on 15.12.2022.
//

import SwiftUI

struct GameRulesScreenView: View {
    
    @ObservedObject var viewModel: GameRulesViewModel
    @ObservedObject var navigationViewModel: NavigationViewModel
    @ObservedObject var settingsViewModel: SettingsViewModel
    
    var body: some View {
        VStack {
            Text("Правила игры")
            ScrollView {
                Text(self.viewModel.rules)
                    .frame(
                        maxWidth: .infinity,
                        alignment: .leading
                    )
            }
            Button { withAnimation(.easeInOut) {
                self.navigationViewModel.navigateTo(Screens.game) }
            } label: { Text("Играть") }
        }
        .frame(
            minWidth: 0,
            maxWidth: .infinity,
            minHeight: 0,
            maxHeight: .infinity
        )
        .padding()
        .background(Color(settingsViewModel.theme.getTheme().backgroundColor))
    }
}
