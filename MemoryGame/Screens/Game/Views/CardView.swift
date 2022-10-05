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
    var body: some View {
        ZStack {
            if card.isFaceUp {
                RoundedRectangle(cornerRadius: 10.0)
                    .fill(Color.white)
                    .shadow(radius: 4.0)
                Text(card.content)
            } else {
                RoundedRectangle(cornerRadius: 10.0).fill()
                Text("❔")
            }
        }
    }
}
