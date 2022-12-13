//
//  NavigationViewModel.swift
//  MemoryGame
//
//  Created by shiryaev on 12.12.2022.
//

import Foundation

class NavigationViewModel: ObservableObject {
    
    init(model: NavigationModel) {
        self.model = model
    }
    
    @Published private var model: NavigationModel
    
    var currentScreen: Screens {
        model.currentScreen
    }
    
    func navigateTo(_ screen: Screens) {
        model.changeScreen(to: screen)
    }
}
