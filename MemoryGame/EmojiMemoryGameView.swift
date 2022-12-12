//
//  EmojiMemoryGameView.swift
//  MemoryGame
//
//  Created by shiryaev on 26.09.2022.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var viewModel: EmojiMemoryGame
    var body: some View {
        VStack {
            MyGrid(viewModel.cards) { card in
                CardView(card: card).onTapGesture {
                    withAnimation(.linear(duration: 0.75)) {
                        viewModel.choose(card: card)
                    }
                }
                .padding(5)
            }
                .padding()
                .foregroundColor(Color.orange)
            Button { withAnimation(.easeInOut) { self.viewModel.resetGame() }} label: { Text("New Game") }
        }
    }
}

struct CardView: View {
    var card: MemoryGame<String>.Card
    
    var body: some View {
        GeometryReader { geometry in
            self.body(for: geometry.size)
        }
    }
    
    @State private var animateedBonusRemaining: Double = 0
    
    private func startBonusTimeAnnimation() {
        animateedBonusRemaining = card.bonusRemaining
        withAnimation(.linear(duration: card.bonusTimeRemaining)) {
            animateedBonusRemaining = 0
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
                            endAngle: Angle.degrees(-animateedBonusRemaining*360 - 90),
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
                .transition(AnyTransition.identity) // AnyTransition.scale
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        game.choose(card: game.cards[0])
        return EmojiMemoryGameView(viewModel: game)
    }
}
