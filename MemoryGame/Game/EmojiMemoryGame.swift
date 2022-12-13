//
//  EmojiMemoryGame.swift
//  MemoryGame
//
//  Created by shiryaev on 28.09.2022.
//

import Foundation

typealias EmojiCard = MemoryGame<String>.Card

// ViewModel
class EmojiMemoryGame: ObservableObject {
    
    @Published private var model: MemoryGame<String> = EmojiMemoryGame.createMemoryGame()
    
    var theme: Theme
    
    init(theme: Themes) {
        self.theme = theme.getTheme()
    }
    
    private static func createMemoryGame() -> MemoryGame<String> {
        let emojis = ["👾", "🚕", "📕"]
        return MemoryGame<String>(numberOfPairOfCards: emojis.count) { pairIndex in
            return emojis[pairIndex]
        }
    }
    
    // MARK: - Access to the Model
    
    var cards: Array<EmojiCard> {
        model.cards // если одна строчка, то можно убрать return
    }
    
    // MARK: - Intent(s)
    
    func choose(card: EmojiCard) {
        model.choose(card: card)
    }
    
    func resetGame() {
        model = EmojiMemoryGame.createMemoryGame()
    }
}
