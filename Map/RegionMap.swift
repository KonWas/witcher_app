//
//  RegionMap.swift
//  witcher_3_glossary
//
//  Created by Konrad Waszczuk on 03/12/2024.
//

import SwiftUI

struct RegionMap: View {
    @Environment(\.presentationMode) var presentationMode
    let regionName: String

    var body: some View {
        ZStack {
            ZoomableScrollView {
                Image("\(regionName.lowercased())_map")
                    .resizable()
                    .scaledToFill()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .ignoresSafeArea()
            }
            .ignoresSafeArea()

            VStack {
                HStack {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "arrow.left")
                            .foregroundColor(Color(red: 1, green: 0.94, blue: 0.74).opacity(0.70))
                            .frame(width: 40, height: 40)
                            .background(Color.black.opacity(0.30))
                            .cornerRadius(50)
                            .overlay(
                                RoundedRectangle(cornerRadius: 50)
                                    .stroke(Color(red: 1, green: 0.94, blue: 0.74).opacity(0.70), lineWidth: 0.50)
                            )
                    }
                    Spacer()
                }
                .padding(.top, 60)
                .padding(.leading, 30)
                Spacer()
            }
        }
        .ignoresSafeArea()
        .background(Color.black)
    }
}

struct RegionMap_Previews: PreviewProvider {
    static var previews: some View {
        RegionMap(regionName: "Novigrad")
    }
}
