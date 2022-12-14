//
//  EmojiMemoryGameView.swift
//  MemoryGame
//
//  Created by shiryaev on 26.09.2022.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var viewModel: EmojiMemoryGame
    @ObservedObject var navigationViewModel: NavigationViewModel
    
    var body: some View {
        VStack {
            Button { withAnimation(.easeInOut) {
                self.navigationViewModel.navigateTo(Screens.settings) }
            } label: { Text("Настройки") }
            MyGrid(viewModel.cards) { card in
                CardView(card: card).onTapGesture {
                    withAnimation(.linear(duration: 0.75)) {
                        viewModel.choose(card: card)
                    }
                }
                .padding(5)
            }
            .padding(.vertical)
            .foregroundColor(Color(viewModel.theme.cardColor))
            GameControlButtons(viewModel: viewModel)
        }
        .padding()
        .background(Color(viewModel.theme.backgroundColor))
    }
}

struct CardView: View {
    var card: EmojiCard
    
    var body: some View {
        GeometryReader { geometry in
            self.body(for: geometry.size)
        }
    }
    
    @State private var animatedBonusRemaining: Double = 0
    
    private func startBonusTimeAnnimation() {
        animatedBonusRemaining = card.bonusRemaining
        withAnimation(.linear(duration: card.bonusTimeRemaining)) {
            animatedBonusRemaining = 0
        }
    }
    
    @ViewBuilder // EmptyView если условие не выполняется
    private func body (for size: CGSize) -> some View {
        if card.isFaceUp || !card.isMatched {
            ZStack {
                Group {
                    if card.isConsumingBonusTime {
                        Pie(
                            startAngle: Angle.degrees(0 - 90),
                            endAngle: Angle.degrees(-animatedBonusRemaining*360 - 90),
                            clockwise: true
                        ).onAppear {
                            self.startBonusTimeAnnimation()
                        }
                    } else {
                        Pie(
                            startAngle: Angle.degrees(0 - 90),
                            endAngle: Angle.degrees(-card.bonusRemaining*360 - 90),
                            clockwise: true
                        )
                    }
                }
                .padding(5)
                .opacity(0.4)
//                .transition(AnyTransition.identity) // AnyTransition.scale
                Text(self.card.content)
                    .font(Font.system(size: fontSize(for: size)))
                    .rotationEffect(Angle.degrees(card.isMatched ? 360 : 0))
                    .animation(
                        card.isMatched
                        ? Animation.linear(duration: 1).repeatForever(autoreverses: false)
                        : .default
                    )
            }
            .cardify(isFaceUp: card.isFaceUp)
            .transition(AnyTransition.scale)
        }
    }
    
    // MARK: - Drawing Constants
    
    private func fontSize (for size: CGSize) -> CGFloat {
        min(size.width, size.height) * 0.7
    }
    
    // TODO: константы для рисования
}

struct GameControlButtons: View {
    
    var viewModel: EmojiMemoryGame
    
    var body: some View {
        HStack() {
            Button {
                withAnimation(.easeInOut) { self.viewModel.resetGame() }
            } label: { Text("Новая игра") }
            Spacer()
            Button {
                withAnimation(.easeInOut) { self.viewModel.shuffleCards() }
            } label: { Text("Перемешать карты") }
        }
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        let game = EmojiMemoryGame()
//        game.choose(card: game.cards[0])
//        return EmojiMemoryGameView(viewModel: game)
//    }
//}
