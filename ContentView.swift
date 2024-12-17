//
//  ContentView.swift
//  witcher_3_glossary
//
//  Created by Konrad Waszczuk on 29/10/2024.
//

import SwiftUI

struct ContentView: View {
    @State private var showMainMenu = false

    var body: some View {
        ZStack {
            Image("main_screen_bg")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .ignoresSafeArea()

            Image("witcher_logo")
                .resizable()
                .scaledToFit()
                .frame(width: 308, height: 153)
                .offset(x: 0, y: -137)

            Button(action: {
                showMainMenu = true
            }) {
                HStack {
                    Text("Begin Your Journey")
                        .font(Font.custom("SF", size: 16))
                        .foregroundColor(Color(red: 1, green: 0.94, blue: 0.74).opacity(0.70))
                        .padding(12)
                        .background(Color.black.opacity(0.30))
                        .cornerRadius(50)
                        .overlay(
                            RoundedRectangle(cornerRadius: 50)
                                .stroke(Color(red: 1, green: 0.94, blue: 0.74).opacity(0.70), lineWidth: 0.50)
                        )
                }
                .frame(width: 224, height: 40)
            }
            .offset(x: 0, y: 142)
            .fullScreenCover(isPresented: $showMainMenu) {
                MainMenuContainer()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}