//
//  MemoryGameScreenView.swift
//  MemoryGame
//
//  Created by shiryaev on 26.09.2022.
//

import SwiftUI

// Экран с картами
struct MemoryGameScreenView: View {
    var viewModel: EmojiMemoryGame
    var body: some View {
        VStack {
            CardsView(cards: viewModel.cards) { card in viewModel.choose(card: card) }
            HStack {
                ButtonView(text: "Новая игра") {
                    
                }
                ButtonView(text: "Перемешать карты") {
                    
                }
            }
        }
    }
}

// Отображает список карт
struct CardsView: View {
    var cards: Array<MemoryGame<String>.Card>
    var onTapCard: (MemoryGame<String>.Card) -> Void
    var body: some View {
        HStack {
            ForEach(cards) { card in
                CardView(card: card).onTapGesture {
                    onTapCard(card)
                }
            }
        }
            .padding()
            .foregroundColor(Color.gray)
            .font(Font.largeTitle)
    }
}

// Preview
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MemoryGameScreenView(viewModel: EmojiMemoryGame())
    }
}
