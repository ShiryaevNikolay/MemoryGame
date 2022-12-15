//
//  GameRulesModel.swift
//  MemoryGame
//
//  Created by shiryaev on 15.12.2022.
//

import Foundation

struct GameRulesModel {
    var rules = """
    · За каждое совпадение добавляется 2 очка
    · За каждое несовпадение отнимается 1 очко
    · При использовании подсказки начисляются штрафные 5 очков
    
    Уровни сложности
    
    · Легкий - количество пар карт 8
    · Нормально - количество пар карт 12
    · Слооооожна! - количество пар карт 24
    """
}
