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
                    viewModel.newGame()
                }
                ButtonView(text: "Перемешать карты") {
                    viewModel.shuffleCards()
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
        
        let columns = Array(
            repeating: GridItem(.flexible(), spacing: 20),
            count: 3
        )
        
        return ScrollView {
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(cards) { card in
                    CardView(card: card)
                    .onTapGesture {
                        onTapCard(card)
                    }
                }
            }
            .padding()
            .foregroundColor(Color.gray)
            .font(Font.largeTitle)
        }
    }
}

// Preview
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MemoryGameScreenView(viewModel: EmojiMemoryGame())
    }
}
