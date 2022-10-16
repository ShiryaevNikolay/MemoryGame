//
//  ThemeCardView.swift
//  MemoryGame
//
//  Created by shiryaev on 15.10.2022.
//

import SwiftUI

/**
 Карточка для выбора темы
 */
struct ThemeCardView: View {
    var theme: Theme
    var card: EmojiCard
    
    var body: some View {
        let baseTheme = theme.getTheme()
        ZStack {
            RoundedRectangle(cornerRadius: 16)
                .fill(
                    Color(baseTheme.backgroundScreenColor)
                )
            CardView(
                card: card,
                backColor: Color(baseTheme.backgroundCardColor)
            )
                .padding()
        }
    }
}

struct ThemeCardView_Previews: PreviewProvider {
    static var previews: some View {
        ThemeCardView(
            theme: Theme.firstTheme,
            card: EmojiCard(isFaceUp: false, content: "🐱", id: 0)
        )
    }
}
