//
//  MemoryGame.swift
//  MemoryGame
//
//  Created by shiryaev on 26.09.2022.
//

import Foundation

// Model
struct MemoryGame<CardContent> where CardContent: Equatable {
    
    private(set) var cards: Array<Card>
    private(set) var score: Int
    private(set) var hintsCount: Int
    private(set) var isEnabledHintButton: Bool = true
    
    private var indexOfOneAndOnlyFaceUpCard: Int? {
        get { cards.indices.filter { cards[$0].isFaceUp }.only }
        set {
            for index in cards.indices {
                cards[index].isFaceUp = index == newValue
            }
        }
    }
    
    private let initScore: Int = 0
    private let initHintsCount: Int = 5
    
    mutating func choose(card: Card) {
        if let choosenIndex = cards.firstIndex(matching: card), !cards[choosenIndex].isFaceUp, !cards[choosenIndex].isMatched {
            if let potentialMatchIndex = indexOfOneAndOnlyFaceUpCard {
                if cards[choosenIndex].content == cards[potentialMatchIndex].content {
                    cards[choosenIndex].isMatched = true
                    cards[potentialMatchIndex].isMatched = true
                    changeScore(by: 2)
                } else {
                    changeScore(by: -1)
                }
                self.cards[choosenIndex].isFaceUp = true
            } else {
                indexOfOneAndOnlyFaceUpCard = choosenIndex
            }
        }
    }
    
    mutating func shuffleCards() {
        cards.shuffle()
    }
    
    mutating func changeScore(by value: Int) {
        score += value
    }
    
    mutating func useHint() {
        hintsCount -= 1
        score -= 5
    }
    
    mutating func showCards() {
        changeFaceUpExpectForMatchedCards(isFaceUp: true)
    }
    
    mutating func hideCards() {
        changeFaceUpExpectForMatchedCards(isFaceUp: false)
    }
    
    mutating func setEnabledHintButton(isEnabled: Bool) {
        isEnabledHintButton = isEnabled
    }
    
    private mutating func changeFaceUpExpectForMatchedCards(isFaceUp: Bool) {
        for index in cards.indices {
            if !cards[index].isMatched {
                cards[index].isFaceUp = isFaceUp
            }
        }
    }
    
    init(numberOfPairOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        score = initScore
        hintsCount = initHintsCount
        cards = Array<Card>()
        for pairIndex in 0..<numberOfPairOfCards {
            let content = cardContentFactory(pairIndex)
            cards.append(Card(content: content, id: pairIndex * 2))
            cards.append(Card(content: content, id: pairIndex * 2 + 1))
        }
        cards.shuffle()
    }
    
    struct Card: Identifiable {
        var isFaceUp: Bool = false {
            didSet {
                if isFaceUp {
                    startUsingBonusTime()
                } else {
                    stopUsingBonusTime()
                }
            }
        }
        var isMatched: Bool = false {
            didSet {
                stopUsingBonusTime()
            }
        }
        var content: CardContent
        var id: Int
        
        // MARK: - Bonus Time
        
        var bonusTimeLimit: TimeInterval = 6
        
        private var faceUpTime: TimeInterval {
            if let lastFaceUpDate = lastFaceUpDate {
                return pastFaceUpTime + Date().timeIntervalSince(lastFaceUpDate)
            } else {
                return pastFaceUpTime
            }
        }
        
        var lastFaceUpDate: Date?
        
        var pastFaceUpTime: TimeInterval = 0
        
        var bonusTimeRemaining: TimeInterval {
            max(0, bonusTimeLimit - pastFaceUpTime)
        }
        
        var bonusRemaining: Double {
            (bonusTimeLimit > 0 && bonusTimeRemaining > 0) ? bonusTimeRemaining/bonusTimeLimit : 0
        }
        
        var hasEarnedBonus: Bool {
            isMatched && bonusTimeRemaining > 0
        }
        
        private mutating func startUsingBonusTime() {
            if isConsumingBonusTime, lastFaceUpDate == nil {
                lastFaceUpDate = Date()
            }
        }
        
        var isConsumingBonusTime: Bool {
            isFaceUp && !isMatched && bonusTimeRemaining > 0
        }
        
        private mutating func stopUsingBonusTime() {
            pastFaceUpTime = faceUpTime
            lastFaceUpDate = nil
        }
    }
}
