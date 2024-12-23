//
//  BuildScreen.swift
//  witcher_3_glossary
//
//  Created by Konrad Waszczuk on 23/12/2024.
//


import SwiftUI

struct BuildScreen: View {
    @EnvironmentObject var buildModel: BuildModel
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        ZStack {
            Image("armors_background")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()

            VStack(spacing: 20) {
                // Back button
                HStack {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "arrow.left")
                            .foregroundColor(.white)
                            .frame(width: 40, height: 40)
                            .background(Color.black.opacity(0.3))
                            .cornerRadius(50)
                    }
                    Spacer()
                }
                .padding(.top, 60)
                .padding(.leading, 30)

                Text("My Build")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .padding(.top, 20)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 20)

                ScrollView {
                    VStack(alignment: .leading, spacing: 20) {
                        buildSlotView(label: "Armor", item: buildModel.armor)
                        buildSlotView(label: "Trousers", item: buildModel.trousers)
                        buildSlotView(label: "Gauntlets", item: buildModel.gauntlets)
                        buildSlotView(label: "Boots", item: buildModel.boots)
                        buildSlotView(label: "Silver Sword", item: buildModel.silverSword)
                        buildSlotView(label: "Steel Sword", item: buildModel.steelSword)
                    }
                    .padding(.horizontal, 20)
                }

                Button(action: {
                    buildModel.clearBuild()
                }) {
                    Text("Clear Build")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.red.opacity(0.7))
                        .cornerRadius(10)
                }
                .padding(.bottom, 20)
            }
        }
    }

    @ViewBuilder
    private func buildSlotView(label: String, item: Item?) -> some View {
        HStack {
            Text("\(label):")
                .foregroundColor(.white)
                .font(.headline)
            if let item = item {
                Text(item.name)
                    .foregroundColor(.white)
            } else {
                Text("None")
                    .foregroundColor(.gray)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(Color.black.opacity(0.7))
        .cornerRadius(10)
    }
}
