//
//  CardView.swift
//  MemoryGame
//
//  Created by shiryaev on 05.10.2022.
//

import SwiftUI

// Отображает карту
struct CardView: View {
    var card: MemoryGame<String>.Card
    var backColor: Color
    var body: some View {
        ZStack {
            if card.isFaceUp {
                RoundedRectangle(cornerRadius: 16.0)
                    .fill(Color.white)
                    .aspectRatio(1.0, contentMode: .fit)
                    .shadow(radius: 4.0)
                Text(card.content)
            } else {
                RoundedRectangle(cornerRadius: 16.0)
                    .fill(backColor)
                    .aspectRatio(1.0, contentMode: .fit)
                    .shadow(radius: 4.0)
            }
        }
    }
}
