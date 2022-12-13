//
//  RadioButtonView.swift
//  MemoryGame
//
//  Created by shiryaev on 12.12.2022.
//

import SwiftUI

struct RadioButtonView: View {
    let text: String
    let isOn: Bool
    let onClickListener: () -> ()
    var body: some View {
        Button(action: onClickListener) {
            HStack(spacing: 16) {
                Circle()
                    .fill(Color.white)
                    .shadow(radius: 3)
                    .overlay(
                        isOn ? Circle()
                            .strokeBorder(Color.blue, style: StrokeStyle(
                                lineWidth: 6,
                                lineCap: .butt,
                                lineJoin: .round,
                                miterLimit: 1,
                                dash: [],
                                dashPhase: 0
                            ))
                        : Circle()
                            .strokeBorder(Color.clear, style: StrokeStyle(
                                lineJoin: .round
                            ))
                    )
                    .frame(width: 18, height: 18)
                Text(text)
                    .foregroundColor(Color.black)
            }
            .contentShape(Rectangle())
        }
        .buttonStyle(RadioButtonStyle())
    }
}

struct RadioButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(.vertical, 4)
            .padding(.horizontal, 8)
            
    }
}
