//
//  MainMenu4.swift
//  witcher_3_glossary
//
//  Created by Konrad Waszczuk on 23/11/2024.
//

import SwiftUI

struct MainMenu4: View {
    @State private var showMapContinent = false

    var body: some View {
        ZStack {
            Image("background4")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .ignoresSafeArea()

            HStack(spacing: 8) {
                Button(action: {
                    showMapContinent = true
                }) {
                    Text("Map")
                        .font(Font.custom("Inter", size: 16))
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

            HStack(spacing: 8) {
                Image("human_icon")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 35, height: 36)
            }
            .padding(12)
            .frame(width: 60, height: 60)
            .background(Color.black.opacity(0.30))
            .cornerRadius(50)
            .overlay(
                RoundedRectangle(cornerRadius: 50)
                    .stroke(Color(red: 1, green: 0.94, blue: 0.74), lineWidth: 0.50)
            )
            .offset(x: 16.50, y: -8)
        }
        .fullScreenCover(isPresented: $showMapContinent) {
            MapContinent()
        }
    }
}

struct MainMenu4_Previews: PreviewProvider {
    static var previews: some View {
        MainMenu4()
    }
}

