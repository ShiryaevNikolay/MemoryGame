//
//  GameRulesViewModel.swift
//  MemoryGame
//
//  Created by shiryaev on 15.12.2022.
//

import Foundation

class GameRulesViewModel: ObservableObject {
    @Published private var model: GameRulesModel = GameRulesViewModel.createModel()
    
    var rules: String {
        model.rules
    }
    
    private static func createModel() -> GameRulesModel {
        GameRulesModel()
    }
}
