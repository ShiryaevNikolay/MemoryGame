//
//  Button.swift
//  MemoryGame
//
//  Created by shiryaev on 05.10.2022.
//

import SwiftUI

// Стилизованная кнопка
struct ButtonView: View {
    var text: String
    var onClickListener: () -> Void
    var body: some View {
        Button(action: onClickListener) {
            HStack {
//                Image(systemName: "plus") // Подумать на счет иконки. Как отобразить векторную иконку?
                Text(text)
            }
        }
        .buttonStyle(ButtonViewStyle())
    }
}

// Стиль кнопки
struct ButtonViewStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(Color(.secondarySystemBackground))
            .clipShape(Capsule())
            .scaleEffect(configuration.isPressed ? 0.95 : 1)
//            .animation(.spring(), value: configuration.isPressed) // Можно выбрать другую анимацию
    }
}

// Preview
struct ButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ButtonView(text: "Button") {}
    }
}