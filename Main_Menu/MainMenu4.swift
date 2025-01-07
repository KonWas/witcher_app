//
//  MainMenu4.swift
//  witcher_3_glossary
//
//  Created by Konrad Waszczuk on 23/11/2024.
//


import SwiftUI

struct MainMenu4: View {
    @State private var showMapContinent = false
    @State private var showDynamicScreen = false
    @State private var selectedCategory: ItemCategory = .people

    var body: some View {
        ZStack {
            Image("background4")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .ignoresSafeArea()

            VStack {
                HStack {
                    Spacer()
                    Button(action: {
                        showMapContinent = true
                    }) {
                        Text("Map")
                            .font(Font.custom("Inter", size: 16))
                            .foregroundColor(Color(red: 1, green: 0.94, blue: 0.74).opacity(0.70))
                            .frame(width: 70, height: 40)
                            .background(Color.black.opacity(0.50))
                            .cornerRadius(50)
                            .overlay(
                                RoundedRectangle(cornerRadius: 50)
                                    .stroke(Color(red: 1, green: 0.94, blue: 0.74).opacity(0.70), lineWidth: 0.50)
                            )
                    }
                }
                .padding(.top, 60)
                .padding(.horizontal, 20)

                Spacer()

                Button(action: {
                    showDynamicScreen = true
                }) {
                    Image("human_icon")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40, height: 40)
                        .padding(12)
                        .background(Color.black.opacity(0.50))
                        .cornerRadius(50)
                        .overlay(
                            RoundedRectangle(cornerRadius: 50)
                                .stroke(Color(red: 1, green: 0.94, blue: 0.74), lineWidth: 0.50)
                        )
                }

                Spacer()
            }
        }
        .fullScreenCover(isPresented: $showMapContinent) {
            MapContinent()
        }
        .fullScreenCover(isPresented: $showDynamicScreen) {
            let (background, items, title) = getItemsAndBackground(for: selectedCategory)
            DynamicItemListScreen(
                category: selectedCategory,
                backgroundImageName: background,
                items: items,
                title: title
            )
        }
    }
}

struct MainMenu4_Previews: PreviewProvider {
    static var previews: some View {
        MainMenu4()
    }
}

