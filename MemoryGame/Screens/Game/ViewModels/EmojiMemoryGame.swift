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
    
    init() {
        model = EmojiMemoryGame.createMemoryGame()
        showCardsForTime()
    }
    
    @Published private var model: MemoryGame<String>
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
    
    private static let timeDelayBySeconds = UInt64(4 * 1E9)
    
    private var task: Task<Void, Error>?
//    private var chosenFirstCardId: Int? = nil
    
    private static func createMemoryGame(numberOfPairsOfCards: Int = Int.random(in: 2...5)) -> MemoryGame<String> {
        let randomEmojis = emojisFirstTheme.shuffled().prefix(numberOfPairsOfCards)
        return MemoryGame<String>(numberOfPairOfCards: numberOfPairsOfCards) { pairIndex in
            return randomEmojis[pairIndex]
        }
    }
    
    private static func subscribeOn(
        onSuccess: @escaping () async -> (),
        onError: @escaping (Error) async -> ()
    ) -> Task<Void, Error> {
        Task {
            do {
                try Task.checkCancellation()
                try await Task.sleep(nanoseconds: EmojiMemoryGame.timeDelayBySeconds)
                await onSuccess()
            } catch {
                await onError(error)
            }
        }
    }
    
    // Показывает карточки на время
    private func showCardsForTime() {
        self.task?.cancel()
        showCards()
        self.task = EmojiMemoryGame.subscribeOn(
            onSuccess: handleSuccess,
            onError: handleError
        )
    }
    
    // Показывает карточки
    private func showCards() {
        model.showCards()
    }
    
    // Скрывает карточки
    private func hideCards() {
        model.hideCards()
    }
    
    @MainActor
    private func handleSuccess() async {
        hideCards()
    }
    
    @MainActor
    private func handleError(error: Error) async {
//        hideCards()
    }
    
    // MARK: - Access to the Model
    
    var cards: Array<MemoryGame<String>.Card> {
        model.cards // если одна строчка, то можно убрать return
    }
    
    var score: Int {
        model.score
    }
    
    // MARK: - Intent(s)
    
    func choose(card: MemoryGame<String>.Card) {
//        if chosenFirstCardId == nil {
//            chosenFirstCardId = card.id
//        } else {
//            if chosenFirstCardId == card.id {
//                model.changeScore(by: 2)
//            } else {
//                model.changeScore(by: -1)
//            }
//            chosenFirstCardId = nil
//        }
        model.choose(card: card)
    }
    
    func newGame() {
        model = EmojiMemoryGame.createMemoryGame()
        showCardsForTime()
    }
    
    func shuffleCards() {
        model.shuffle()
        showCardsForTime()
    }
}
