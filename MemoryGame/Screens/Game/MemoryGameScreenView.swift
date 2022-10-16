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
    @ObservedObject var settingsViewModel: SettingsViewModel
    var body: some View {
        let theme = settingsViewModel.theme.getTheme()
        
        VStack {
            TitleGameView(
                score: viewModel.score,
                theme: settingsViewModel.theme
            )
            CardsView(
                cards: viewModel.cards,
                backOfCardsColor: Color(theme.backgroundCardColor)
            ) { card in viewModel.choose(card: card) }
            HStack {
                ButtonView(
                    text: "Новая игра",
                    backgroundColor: Color(
                        settingsViewModel.theme.getTheme().backgroundCardColor,
                        alpha: 0.5
                    )
                ) {
                    viewModel.newGame()
                }
                ButtonView(
                    text: "Перемешать карты",
                    backgroundColor: Color(
                        settingsViewModel.theme.getTheme().backgroundCardColor,
                        alpha: 0.5
                    )
                ) {
                    viewModel.shuffleCards()
                }
            }
        }
        .background(Color(settingsViewModel.theme.getTheme().backgroundScreenColor))
    }
}

/**
 Отображает заголовок
 */
struct TitleGameView: View {
    var score: Int
    var theme: Theme
    
    var body: some View {
        HStack {
            Text("Счет: \(score)")
                .font(.title)
                .padding()
            Spacer()
            ButtonView(
                text: "Настройки",
                backgroundColor: Color(
                    theme.getTheme().backgroundCardColor,
                    alpha: 0.5
                )
            ) {
                // TODO: открывать экран настроек
            }
                .padding()
        }
    }
}

/**
 Отображает список карт
 */
struct CardsView: View {
    var cards: Array<MemoryGame<String>.Card>
    var backOfCardsColor: Color
    var onTapCard: (MemoryGame<String>.Card) -> Void
    var body: some View {
        
        let adaptiveColumns = [
            GridItem(.adaptive(minimum: 60), spacing: 20)
        ]
        
        return ScrollView {
            LazyVGrid(columns: adaptiveColumns, spacing: 20) {
                ForEach(cards) { card in
                    CardView(
                        card: card,
                        backColor: backOfCardsColor
                    )
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
        MemoryGameScreenView(
            viewModel: EmojiMemoryGame(),
            settingsViewModel: SettingsViewModel()
        )
    }
}
