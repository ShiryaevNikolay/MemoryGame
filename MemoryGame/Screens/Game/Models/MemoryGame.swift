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
    
    mutating func choose(card: Card) {
        print("card choosen: \(card)")
        
        let choosenIndex: Int = self.index(of: card)
        self.cards[choosenIndex].isFaceUp.toggle()
    }
    
    // Показывает все карты
    mutating func showCards() {
        turnOverAllCards(isFaceUp: true)
    }
    
    // Скрывает все карты
    mutating func hideCards() {
        turnOverAllCards(isFaceUp: false)
    }
    
    // Перемешивает все карты
    mutating func shuffle() {
        self.cards.shuffle()
    }
    
    // Меняет значение счета
    mutating func changeScore(by newScore: Int) {
        self.score += newScore
    }
    
    // Переворачивает все карты
    private mutating func turnOverAllCards(isFaceUp: Bool) {
        for index in 0..<self.cards.count {
            self.cards[index].isFaceUp = isFaceUp
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
