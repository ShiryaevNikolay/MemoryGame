//
//  EmojiMemoryGame.swift
//  MemoryGame
//
//  Created by shiryaev on 28.09.2022.
//

import Foundation

// ViewModel
class EmojiMemoryGame {
    
    init(model: MemoryGame<String>) {
        self.model = model
    }
    
    var model: MemoryGame<String>
}
