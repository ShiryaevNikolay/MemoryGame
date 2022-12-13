//
//  Extensions.swift
//  MemoryGame
//
//  Created by shiryaev on 12.12.2022.
//

import SwiftUI

extension Color {
    init(_ hex: UInt, alpha: Double = 1) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xFF) / 255,
            green: Double((hex >> 8) & 0xFF) / 255,
            blue: Double(hex & 0xFF) / 255,
            opacity: alpha
        )
    }
}

extension Difficalties {
    func getText() -> String {
        switch self {
        case .easy:
            return "Легко"
        case .normal:
            return "Нормально"
        case .hard:
            return "Слооооожна!"
        }
    }
}

extension Themes {
    func getTheme() -> Theme {
        switch self {
        case .firstTheme:
            return Theme(
                name: "Первая тема",
                backgroundColor: 0xEDEDED,
                cardColor: 0xD9D9D9
            )
        case .secondTheme:
            return Theme(
                name: "Вторая тема",
                backgroundColor: 0xF5A492,
                cardColor: 0xEA8079
            )
        case .thirdTheme:
            return Theme(
                name: "Третья тема",
                backgroundColor: 0x92BAF5,
                cardColor: 0x79A6EA
            )
        }
    }
}
