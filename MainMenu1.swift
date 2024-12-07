//
//  MainMenu1.swift
//  witcher_3_glossary
//
//  Created by Konrad Waszczuk on 23/11/2024.
//

import SwiftUI

struct MainMenu1: View {
    @State private var showMapContinent = false

    var body: some View {
        ZStack {
            Image("background1")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .ignoresSafeArea()

            HStack(spacing: 8) {
                Button(action: {
                    showMapContinent = true
                }) {
                    Text("Map")
                        .font(Font.custom("SF", size: 16))
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
                Image("alchemy_icon")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 39, height: 39)
            }
            .frame(width: 60, height: 60)
            .background(Color.black.opacity(0.30))
            .cornerRadius(50)
            .overlay(
                RoundedRectangle(cornerRadius: 50)
                    .stroke(Color(red: 1, green: 0.94, blue: 0.74), lineWidth: 0.50)
            )
            .offset(x: -9.50, y: 0)
        }
        .fullScreenCover(isPresented: $showMapContinent) {
            MapContinent()
        }
    }
}

struct MainMenu1_Previews: PreviewProvider {
    static var previews: some View {
        MainMenu1()
    }
}
