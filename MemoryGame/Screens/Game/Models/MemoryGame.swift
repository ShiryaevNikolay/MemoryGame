//
//  MemoryGame.swift
//  MemoryGame
//
//  Created by shiryaev on 26.09.2022.
//

import Foundation

// Model
struct MemoryGame<CardContent> {
    var cards: Array<Card>
    var score: Int = 0
    
    init(numberOfPairOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        cards = Array<Card>()
        for pairIndex in 0..<numberOfPairOfCards {
            let content = cardContentFactory(pairIndex)
            cards.append(Card(content: content, id: pairIndex * 2))
            cards.append(Card(content: content, id: pairIndex * 2 + 1))
        }
        // Случайно перемешиваем массив
        cards.shuffle()
    }
    
    /**
     Выбирается карточка
     */
    mutating func choose(card: Card) {
        print("card choosen: \(card)")
        
        let choosenIndex: Int = self.index(of: card)
        self.cards[choosenIndex].isFaceUp.toggle()
    }
    
    /**
     Показывает все карты
     */
    mutating func showCards() {
        turnOverAllCards(isFaceUp: true)
    }
    
    /**
     Скрывает все карты
     @param hideMathingCards true - нужно скрыть одинаковые карточки, false - если нужно скрыть все карточки
     */
    mutating func hideCards(hideMathingCards: Bool = true) {
        turnOverAllCards(isFaceUp: false, turnOverMathingCards: hideMathingCards)
    }
    
    /**
     Скрываются только выбранные карточки
     */
    mutating func hideCards(cards: Array<Card>) {
        turnOverCards(cards: cards, isFaceUp: false)
    }
    
    /**
     Перемешивает все карты
     */
    mutating func shuffle() {
        self.cards.shuffle()
        for index in 0..<self.cards.count {
            self.cards[index].isMatched = false
        }
    }
    
    /**
     Прибавляет к счету новое значение
     */
    mutating func changeScore(by newScore: Int) {
        self.score += newScore
    }
    
    /**
     Очищает счет
     */
    mutating func clearScore() {
        self.score = 0
    }
    
    /**
     Устанавливает, что карточки были одинаковые
     */
    mutating func match(firstCard: Card, secondCard: Card) {
        let firstChoosenIndex: Int = self.index(of: firstCard)
        let secondChoosenIndex: Int = self.index(of: secondCard)
        self.cards[firstChoosenIndex].isMatched = true
        self.cards[secondChoosenIndex].isMatched = true
    }
    
    // Переворачивает все карты
    private mutating func turnOverAllCards(isFaceUp: Bool, turnOverMathingCards: Bool = true) {
        for index in 0..<self.cards.count {
            if !turnOverMathingCards && self.cards[index].isMatched {
                continue
            }
            self.cards[index].isFaceUp = isFaceUp
        }
    }
    
    // Переворачивает выбранные карты
    private mutating func turnOverCards(cards choosenCards: Array<Card>, isFaceUp: Bool) {
        choosenCards.forEach { choosenCard in
            let choosenIndex: Int = self.index(of: choosenCard)
            self.cards[choosenIndex].isFaceUp = isFaceUp
        }
    }
    
    // Получает индекс карты
    private func index(of card: Card) -> Int {
        for index in 0..<self.cards.count {
            if self.cards[index].id == card.id {
                return index
            }
        }
        return -1 // TODO: value
    }
    
    struct Card: Identifiable {
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        var content: CardContent
        var id: Int
    }
}
