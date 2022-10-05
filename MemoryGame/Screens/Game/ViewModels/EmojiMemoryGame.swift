//
//  EmojiMemoryGame.swift
//  MemoryGame
//
//  Created by shiryaev on 28.09.2022.
//

import Foundation

// ViewModel
class EmojiMemoryGame {
    // Иммет смысл написать typealias для MemoryGame<String>
    
    init(numberOfPairsOfCards: Int) {
        model = EmojiMemoryGame.createMemoryGame(numberOfPairsOfCards: numberOfPairsOfCards)
    }
    
    static func createMemoryGame(numberOfPairsOfCards: Int) -> MemoryGame<String> {
        let emojis = [
            "🩼", "🚲", "🗿", "💻", "🧲", "⚔️",
            "🛠", "🦠", "🔊", "🍑", "🍌", "🥥",
            "🍕", "🌮", "🍔", "🍊", "🏓", "🎮",
            "✈️", "🗺", "🏩", "⛩", "💾", "💸"
        ]
        let randomEmojis = emojis.shuffled().prefix(numberOfPairsOfCards)
        return MemoryGame<String>(numberOfPairOfCards: numberOfPairsOfCards) { pairIndex in
            return randomEmojis[pairIndex]
        }
    }
    
    private var model: MemoryGame<String>
    
    // MARK: - Access to the Model
    
    var cards: Array<MemoryGame<String>.Card> {
        model.cards // если одна строчка, то можно убрать return
    }
    
    // MARK: - Intent(s)
    
    func choose(card: MemoryGame<String>.Card) {
        model.choose(card: card)
    }
}
