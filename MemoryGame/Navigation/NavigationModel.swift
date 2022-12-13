//
//  NavigationModel.swift
//  MemoryGame
//
//  Created by shiryaev on 12.12.2022.
//

import Foundation

struct NavigationModel {
    var currentScreen: Screens
    
    init(currentScreen: Screens = Screens.game) {
        self.currentScreen = currentScreen
    }
    
    mutating func changeScreen(to selectedScreen: Screens) {
        self.currentScreen = selectedScreen
    }
}
