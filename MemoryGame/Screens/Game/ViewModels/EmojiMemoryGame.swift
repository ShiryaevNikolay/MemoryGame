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
    
    private static let timeDelayBySeconds = UInt64(2 * 1E9)
    
    private var task: Task<Void, Error>?
    private var chosenFirstCard: EmojiCard? = nil
    
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
            onSuccess: hideAllCardsOnMainActor,
            onError: handleError
        )
    }
    
    // Показывает карточки
    private func showCards() {
        model.showCards()
    }
    
    // Скрывает карточки
    private func hideCards(hideMathingCards: Bool = true) {
        model.hideCards(hideMathingCards: hideMathingCards)
    }
    
    // Скрывает выбранные карточки
    private func hideChoosenCards(cards: Array<EmojiCard>) {
        model.hideCards(cards: cards)
    }
    
    @MainActor
    private func hideAllCardsOnMainActor() async {
        hideCards()
    }
    
    @MainActor
    private func hideChoosenCardsOnMainActor(cards: Array<EmojiCard>) async {
        hideChoosenCards(cards: cards)
    }
    
    @MainActor
    private func handleError(error: Error) async {
//        hideCards() // TODO: убрать
    }
    
    // Скрывает разные карты
    private func hideDifferentCards(firstCard: EmojiCard, secondCard: EmojiCard) {
        self.task?.cancel()
        self.task = EmojiMemoryGame.subscribeOn(
            onSuccess: {
                await self.hideChoosenCardsOnMainActor(cards: [firstCard, secondCard])
            },
            onError: { erron in
                await self.hideChoosenCardsOnMainActor(cards: [firstCard, secondCard])
            }
        )
    }
    
    // MARK: - Access to the Model
    
    var cards: Array<EmojiCard> {
        model.cards // если одна строчка, то можно убрать return
    }
    
    var score: Int {
        model.score
    }
    
    // MARK: - Intent(s)
    
    /**
     Выбор карточки
     */
    func choose(card: EmojiCard) {
        // Если карточка показывается, то ничего не делаем
        if card.isFaceUp {
            return
        }
        // Если повторно выбрали ту же карту, то ничего не делаем
        if card.id == chosenFirstCard?.id {
            return
        }
        
        self.task?.cancel()
        
        if chosenFirstCard == nil {
            chosenFirstCard = card
            hideCards(hideMathingCards: false)
        } else {
            if card.content == chosenFirstCard?.content && card.id != chosenFirstCard?.id {
                model.changeScore(by: 2)
                model.match(firstCard: chosenFirstCard!, secondCard: card)
            } else if card.content != chosenFirstCard?.content && card.id != chosenFirstCard?.id {
                model.changeScore(by: -1)
                hideDifferentCards(firstCard: chosenFirstCard!, secondCard: card)
            }
            chosenFirstCard = nil
        }
        model.choose(card: card)
    }
    
    /**
     Создает модель с новыми данными
     */
    func newGame() {
        model = EmojiMemoryGame.createMemoryGame()
        showCardsForTime()
    }
    
    /**
     Перемешивает карточки
     */
    func shuffleCards() {
        model.shuffle()
        showCardsForTime()
    }
}
