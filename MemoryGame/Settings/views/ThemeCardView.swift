//
//  ThemeCardView.swift
//  MemoryGame
//
//  Created by shiryaev on 12.12.2022.
//

import SwiftUI

struct ThemeCardView: View {
    var theme: Themes
    var card: EmojiCard
    
    var body: some View {
        let appTheme = theme.getTheme()
        ZStack {
            RoundedRectangle(cornerRadius: 16)
                .fill(
                    Color(appTheme.backgroundColor)
                )
            CardView(card: card)
                .padding()
                .foregroundColor(Color(appTheme.cardColor))
        }
    }
}
