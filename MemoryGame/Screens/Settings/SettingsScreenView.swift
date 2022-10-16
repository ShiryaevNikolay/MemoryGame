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
    @ObservedObject var settingsViewModel: SettingsViewModel
    var body: some View {
        VStack(alignment: .leading) {
            TitleSettingsView {
                // TODO: Возвращаться назад
            }
            Spacer()
                .frame(height: 20)
            SubtitleView("Тема")
            ThemesGridView(selectedTheme: settingsViewModel.theme) { theme in
                settingsViewModel.changeTheme(to: theme)
            }
                .frame(height: 200)
            Spacer()
                .frame(height: 20)
            SubtitleView("Уровень сложности")
            DifficaltyPickerView(
                selectedDifficalty: settingsViewModel.difficalty
            ) { difficalty in
                settingsViewModel.changeDifficalty(to: difficalty)
            }
            Spacer()
        }
        .padding()
        .background(Color(settingsViewModel.theme.getTheme().backgroundScreenColor))
    }
}

/**
 Заголовок экрана настроек
 */
struct TitleSettingsView: View {
    var backNavigationListener: () -> ()
    var body: some View {
        HStack {
            Image(systemName: "house")
                .imageScale(.large)
                .onTapGesture {
                    backNavigationListener()
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
    var selectedTheme: Theme
    var onClickListener: (Theme) -> ()
    var body: some View {
        Grid(horizontalSpacing: 24, verticalSpacing: 16) {
            GridRow {
                ForEach(Theme.allCases, id: \.self) { theme in
                    ThemeCardView(
                        theme: theme,
                        card: EmojiCard(content: "", id: 0)
                    )
                        .shadow(radius: 6)
                        .onTapGesture {
                            onClickListener(theme)
                        }
                }
            }
            GridRow {
                ForEach(Theme.allCases, id: \.self) { theme in
                    if selectedTheme == theme {
                        Text("Текущая")
                    } else {
                        Spacer()
                    }
                }
            }
        }
    }
}

struct DifficaltyPickerView: View {
    var selectedDifficalty: Difficalty
    var onClickListener: (Difficalty) -> ()
    var body: some View {
        VStack(alignment: .leading) {
            ForEach(Difficalty.allCases, id: \.self) { difficalty in
                RadioButtonView(
                    text: difficalty.getText(),
                    isOn: difficalty == selectedDifficalty
                ) {
                    onClickListener(difficalty)
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
        SettingsScreenView(settingsViewModel: SettingsViewModel())
    }
}
