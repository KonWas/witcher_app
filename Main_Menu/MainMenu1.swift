////
////  MainMenu1.swift
////  witcher_3_glossary
////
////  Created by Konrad Waszczuk on 23/11/2024.
////
//
//import SwiftUI
//
//struct MainMenu1: View {
//    @State private var showMapContinent = false
//    @State private var showDynamicScreen = false
//    @State private var selectedCategory: ItemCategory = .alchemy
//
//    var body: some View {
//        ZStack {
//            Image("background1")
//                .resizable()
//                .aspectRatio(contentMode: .fill)
//                .ignoresSafeArea()
//
//            HStack(spacing: 8) {
//                Button(action: {
//                    showMapContinent = true
//                }) {
//                    Text("Map")
//                        .font(Font.custom("SF", size: 16))
//                        .foregroundColor(Color(red: 1, green: 0.94, blue: 0.74).opacity(0.70))
//                        .frame(width: 70, height: 40)
//                        .background(Color.black.opacity(0.50))
//                        .cornerRadius(50)
//                        .overlay(
//                            RoundedRectangle(cornerRadius: 50)
//                                .stroke(Color(red: 1, green: 0.94, blue: 0.74).opacity(0.70), lineWidth: 0.50)
//                        )
//                }
//            }
//            .offset(x: 128.50, y: -354)
//
//            Button(action: {
//                showDynamicScreen = true
//            }) {
//                Image("alchemy_icon")
//                    .resizable()
//                    .scaledToFit()
//                    .frame(width: 39, height: 39)
//                    .padding(12)
//                    .frame(width: 60, height: 60)
//                    .background(Color.black.opacity(0.50))
//                    .cornerRadius(50)
//                    .overlay(
//                        RoundedRectangle(cornerRadius: 50)
//                            .stroke(Color(red: 1, green: 0.94, blue: 0.74), lineWidth: 0.50)
//                    )
//            }
//            .offset(x: 0, y: 0)
//        }
//        .fullScreenCover(isPresented: $showMapContinent) {
//            MapContinent()
//        }
//        .fullScreenCover(isPresented: $showDynamicScreen) {
//            let (background, items, title) = getItemsAndBackground(for: selectedCategory)
//            DynamicItemListScreen(category: selectedCategory, backgroundImageName: background, items: items, title: title)
//        }
//    }
//}
//
//struct MainMenu1_Previews: PreviewProvider {
//    static var previews: some View {
//        MainMenu1()
//    }
//}

import SwiftUI

struct MainMenu1: View {
    @State private var showMapContinent = false
    @State private var showDynamicScreen = false
    @State private var selectedCategory: ItemCategory = .alchemy

    var body: some View {
        ZStack {
            // Tło
            Image("background1")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .ignoresSafeArea()

            // Warstwa na przyciski
            VStack {
                // Górny pasek
                HStack {
                    Spacer()
                    // Przycisk Map (prawy górny róg)
                    Button(action: {
                        showMapContinent = true
                    }) {
                        Text("Map")
                            .font(Font.custom("SF", size: 16))
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
                // Trochę odstępu u góry i po bokach
                .padding(.top, 60)
                .padding(.horizontal, 20)

                Spacer()

                // Główny przycisk na środku ekranu
                Button(action: {
                    showDynamicScreen = true
                }) {
                    Image("alchemy_icon")
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
        // Prezentacja widoku MapContinent
        .fullScreenCover(isPresented: $showMapContinent) {
            MapContinent()
        }
        // Prezentacja widoku alchemii (DynamicItemListScreen)
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

struct MainMenu1_Previews: PreviewProvider {
    static var previews: some View {
        MainMenu1()
    }
}
