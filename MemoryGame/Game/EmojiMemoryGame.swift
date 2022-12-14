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
    
    private var difficalty: Difficalties
    private var themes: Themes
    var theme: Theme {
        themes.getTheme()
    }
    
    private static let emojisFirstTheme = [
        "🩼", "🚲", "🗿", "💻", "🧲", "⚔️",
        "🛠", "🦠", "🔊", "🍑", "🍌", "🥥",
        "🍕", "🌮", "🍔", "🍊", "🏓", "🎮",
        "✈️", "🗺", "🏩", "⛩", "💾", "💸"
    ]
    private static let emojisSecondTheme = [
        "📽", "🕹", "🖥", "💽", "🗜", "📸",
        "📟", "🎞", "🎚", "🧭", "🎛", "📡",
        "💡", "🖲", "🕯", "🧯", "💶", "🪙",
        "💰", "🪜", "⚙️", "🪤", "🧱", "🔫"
    ]
    private static let emojisThirdTheme = [
        "💣", "🛡", "🪓", "🔪", "⚰️", "🪬",
        "📿", "🧿", "🔬", "💈", "⚗️", "🏺",
        "🩹", "🧬", "🧪", "🧺", "🧻", "🛁",
        "🧼", "🧽", "🔑", "📦", "📭", "✏️"
    ]
    
    init(theme: Themes, difficalty: Difficalties) {
        self.themes = theme
        self.difficalty = difficalty
        self.model = EmojiMemoryGame.createMemoryGame(
            theme: self.themes,
            difficalty: self.difficalty
        )
    }
    
    private static func createMemoryGame(
        theme: Themes = Themes.firstTheme,
        difficalty: Difficalties = Difficalties.easy
    ) -> MemoryGame<String> {
        let emojis = getEmojis(theme).shuffled().prefix(difficalty.rawValue)
        return MemoryGame<String>(numberOfPairOfCards: emojis.count) { pairIndex in
            return emojis[pairIndex]
        }
    }
    
    private static func getEmojis(_ theme: Themes) -> Array<String> {
        switch theme {
        case .firstTheme:
            return emojisFirstTheme
        case .secondTheme:
            return emojisSecondTheme
        case .thirdTheme:
            return emojisThirdTheme
        }
    }
    
    // MARK: - Access to the Model
    
    var cards: Array<EmojiCard> {
        model.cards // если одна строчка, то можно убрать return
    }
    
    var score: Int {
        model.score
    }
    
    // MARK: - Intent(s)
    
    func choose(card: EmojiCard) {
        model.choose(card: card)
    }
    
    func resetGame() {
        model = EmojiMemoryGame.createMemoryGame(
            theme: self.themes,
            difficalty: self.difficalty
        )
    }
    
    func shuffleCards() {
        model.shuffleCards()
    }
}
