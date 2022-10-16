//
//  SettingsScreenView.swift
//  MemoryGame
//
//  Created by shiryaev on 13.10.2022.
//

import SwiftUI

/**
 Экран настроек
 */
struct SettingsScreenView: View {
    var body: some View {
        VStack(alignment: .leading) {
            TitleSettingsView()
            Spacer()
                .frame(height: 20)
            SubtitleView("Тема")
            ThemesGridView()
                .frame(height: 200)
            Spacer()
                .frame(height: 20)
            SubtitleView("Уровень сложности")
            DifficaltyPickerView(selectedDifficalty: Difficalty.easy)
            Spacer()
        }
        .padding()
    }
}

/**
 Заголовок экрана настроек
 */
struct TitleSettingsView: View {
    var body: some View {
        HStack {
            Image(systemName: "house")
                .imageScale(.large)
                .onTapGesture {
                    // TODO: Вернуться на главный экран
                }
            HeaderView("Настройки")
        }
    }
}

struct HeaderView: View {
    var text: String
    
    init(_ text: String) {
        self.text = text
    }
    
    var body: some View {
        Text(text)
            .font(.title)
    }
}

struct SubtitleView: View {
    var text: String
    
    init(_ text: String) {
        self.text = text
    }
    
    var body: some View {
        Text(text)
            .font(.title2)
    }
}

struct ThemesGridView: View {
    var selectedTheme: Theme = Theme.firstTheme
    var body: some View {
        Grid(horizontalSpacing: 24, verticalSpacing: 16) {
            GridRow {
                ForEach(Theme.allCases, id: \.self) { theme in
                    ThemeCardView(
                        theme: theme,
                        card: EmojiCard(content: "", id: 0)
                    )
                        .shadow(radius: 6)
                }
            }
            GridRow {
                ForEach(Theme.allCases, id: \.self) { theme in
                    if selectedTheme == theme {
                        Text("Текущая")
                    }
                }
            }
        }
    }
}

struct DifficaltyPickerView: View {
    var selectedDifficalty: Difficalty
    var body: some View {
        VStack(alignment: .leading) {
            ForEach(Difficalty.allCases, id: \.self) { difficalty in
                return RadioButtonView(
                    text: difficalty.getText(),
                    isOn: difficalty == selectedDifficalty
                ) {
                    // TODO: переключать уровень сложности
                }
            }
        }
    }
}

/**
 Preview
 */
struct SettingsScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsScreenView()
    }
}
