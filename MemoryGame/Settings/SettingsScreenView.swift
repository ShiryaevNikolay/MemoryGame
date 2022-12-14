//
//  SettingsScreenView.swift
//  MemoryGame
//
//  Created by shiryaev on 12.12.2022.
//

import SwiftUI

struct SettingsScreenView: View {
    @ObservedObject var viewModel: SettingsViewModel
    @ObservedObject var navigationViewModel: NavigationViewModel
    
    var body: some View {
        VStack {
            SubtitleView("Тема")
            ThemesGridView(selectedTheme: viewModel.theme) { theme in
                viewModel.changeTheme(to: theme)
            }
                .frame(height: 200)
            Button {
                withAnimation(.easeInOut) {
                    self.viewModel.setRandomTheme()
                }
            } label: { Text("Случайная тема") }
            Spacer()
                .frame(height: 20)
            SubtitleView("Уровень сложности")
            DifficaltyPickerView(
                selectedDifficalty: viewModel.difficalty
            ) { difficalty in
                viewModel.changeDifficalty(to: difficalty)
            }
            Spacer()
            Button {
                withAnimation(.easeInOut) { navigationViewModel.navigateTo(Screens.game) }
            } label: { Text("Играть") }
        }
        .padding()
        .background(Color(viewModel.theme.getTheme().backgroundColor))
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
    var selectedTheme: Themes
    var onClickListener: (Themes) -> ()
    var body: some View {
        Grid(horizontalSpacing: 24, verticalSpacing: 16) {
            GridRow {
                ForEach(Themes.allCases, id: \.self) { theme in
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
                ForEach(Themes.allCases, id: \.self) { theme in
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
    var selectedDifficalty: Difficalties
    var onClickListener: (Difficalties) -> ()
    var body: some View {
        VStack(alignment: .leading) {
            ForEach(Difficalties.allCases, id: \.self) { difficalty in
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
