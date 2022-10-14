//
//  MemoryGameScreenView.swift
//  MemoryGame
//
//  Created by shiryaev on 26.09.2022.
//

import SwiftUI

/**
 Экран с картами
 */
struct MemoryGameScreenView: View {
    @ObservedObject var viewModel: EmojiMemoryGame
    var body: some View {
        VStack {
            TitleView(score: viewModel.score)
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

/**
 Отображает заголовок
 */
struct TitleView: View {
    var score: Int
    
    var body: some View {
        HStack {
            Text("Счет: \(score)")
                .font(.title)
                .padding()
            Spacer()
            Button(
                action: {
                    // TODO: обработать нажатие
                },
                label: {
                    // TODO: добавить иконку
//                    Image("is_settings").foregroundColor(Color.black)
                }
            )
        }
    }
}

/**
 Отображает список карт
 */
struct CardsView: View {
    var cards: Array<MemoryGame<String>.Card>
    var onTapCard: (MemoryGame<String>.Card) -> Void
    var body: some View {
        
        let adaptiveColumns = [
            GridItem(.adaptive(minimum: 60), spacing: 20)
        ]
        
        return ScrollView {
            LazyVGrid(columns: adaptiveColumns, spacing: 20) {
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

/**
 Preview
 */
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MemoryGameScreenView(viewModel: EmojiMemoryGame())
    }
}
