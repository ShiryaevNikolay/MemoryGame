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
    
    init() {
        model = EmojiMemoryGame.createMemoryGame()
    }
    
    private static let emojis = [
        "🩼", "🚲", "🗿", "💻", "🧲", "⚔️",
        "🛠", "🦠", "🔊", "🍑", "🍌", "🥥",
        "🍕", "🌮", "🍔", "🍊", "🏓", "🎮",
        "✈️", "🗺", "🏩", "⛩", "💾", "💸"
    ]
    private var model: MemoryGame<String>
    
    private static func createMemoryGame(numberOfPairsOfCards: Int = Int.random(in: 2...5)) -> MemoryGame<String> {
        let randomEmojis = emojis.shuffled().prefix(numberOfPairsOfCards)
        return MemoryGame<String>(numberOfPairOfCards: numberOfPairsOfCards) { pairIndex in
            return randomEmojis[pairIndex]
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
    
    func newGame() {
        model = EmojiMemoryGame.createMemoryGame()
    }
    
    func shuffleCards() {
        // TODO: по идее нужно вызывать метод из model
        model.cards.shuffle()
    }
}
