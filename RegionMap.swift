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
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.black.opacity(0.7))
                            .cornerRadius(12)
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
