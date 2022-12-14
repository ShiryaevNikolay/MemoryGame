//
//  EmojiMemoryGame.swift
//  MemoryGame
//
//  Created by shiryaev on 28.09.2022.
//

import Foundation

// ViewModel
class EmojiMemoryGame: ObservableObject {
    // Иммет смысл написать typealias для MemoryGame<String>
    
    @Published private var model: MemoryGame<String> = EmojiMemoryGame.createMemoryGame()
    
    private static func createMemoryGame() -> MemoryGame<String> {
        let emojis = ["👾", "🚕", "📕"]
        return MemoryGame<String>(numberOfPairOfCards: emojis.count) { pairIndex in
            return emojis[pairIndex]
        }
    }
    
    // MARK: - Access to the Model
    
    var cards: Array<MemoryGame<String>.Card> {
        model.cards // если одна строчка, то можно убрать return
    }
    
    // MARK: - Intent(s)
    
    func choose(card: MemoryGame<String>.Card) {
        model.choose(card: card)
    }
    
    func resetGame() {
        model = EmojiMemoryGame.createMemoryGame()
    }
}
