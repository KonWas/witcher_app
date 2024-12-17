//
//  MainMenu2.swift
//  witcher_3_glossary
//
//  Created by Konrad Waszczuk on 23/11/2024.
//

import SwiftUI

struct MainMenu2: View {
    @State private var showMapContinent = false
    @State private var showDynamicScreen = false
    @State private var selectedCategory: ItemCategory = .armor

    var body: some View {
        ZStack {
            Image("background2")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .ignoresSafeArea()

            HStack(spacing: 8) {
                Button(action: {
                    showMapContinent = true
                }) {
                    Text("Map")
                        .font(Font.custom("SF", size: 16))
                        .lineSpacing(16)
                        .foregroundColor(Color(red: 1, green: 0.94, blue: 0.74).opacity(0.70))
                        .frame(width: 70, height: 40)
                        .background(Color.black.opacity(0.30))
                        .cornerRadius(50)
                        .overlay(
                            RoundedRectangle(cornerRadius: 50)
                                .stroke(Color(red: 1, green: 0.94, blue: 0.74).opacity(0.70), lineWidth: 0.50)
                        )
                }
            }
            .offset(x: 128.50, y: -354)

            Button(action: {
                showDynamicScreen = true
            }) {
                Image("armour_icon")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 39, height: 39)
                    .padding(12)
                    .frame(width: 60, height: 60)
                    .background(Color.black.opacity(0.30))
                    .cornerRadius(50)
                    .overlay(
                        RoundedRectangle(cornerRadius: 50)
                            .stroke(Color(red: 1, green: 0.94, blue: 0.74), lineWidth: 0.50)
                    )
            }
            .offset(x: 0, y: 0)
        }
        .fullScreenCover(isPresented: $showMapContinent) {
            MapContinent()
        }
        .fullScreenCover(isPresented: $showDynamicScreen) {
            let (background, items, title) = getItemsAndBackground(for: selectedCategory)
                        DynamicItemListScreen(category: selectedCategory, backgroundImageName: background, items: items, title: title)
        }
    }
}

struct MainMenu2_Previews: PreviewProvider {
    static var previews: some View {
        MainMenu2()
    }
}
