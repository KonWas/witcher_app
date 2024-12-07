//
//  DynamicItemListScreen.swift
//  witcher_3_glossary
//
//  Created by Konrad Waszczuk on 07/12/2024.
//


import SwiftUI


struct DynamicItemListScreen: View {
    @Environment(\.presentationMode) var presentationMode
    let category: ItemCategory
    let backgroundImageName: String
    let items: [Item]
    let title: String

    @State private var selectedItem: Item?

    var body: some View {
        ZStack {
            Image(backgroundImageName)
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)

            VStack(spacing: 20) {
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

                Text(title)
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .padding(.top, 20)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 20)

                HStack {
                    Button(action: {
                    }) {
                        Text("Filter")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.blue.opacity(0.7))
                            .cornerRadius(10)
                    }

                    Spacer()

                    Button(action: {
                    }) {
                        Text("Search")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.green.opacity(0.7))
                            .cornerRadius(10)
                    }
                }
                .padding(.horizontal, 20)

                List(items) { item in
                    Button(action: {
                        selectedItem = item
                    }) {
                        HStack {
                            Image(item.imageName)
                                .resizable()
                                .frame(width: 50, height: 50)
                                .clipShape(Rectangle())
                                .overlay(Rectangle().stroke(Color.gray, lineWidth: 1))

                            Text(item.name)
                                .font(.headline)
                                .foregroundColor(.white)
                        }
                    }
                    .listRowBackground(Color.black.opacity(0.7))
                }
                .listStyle(PlainListStyle())
                .padding(.top, -20)
                .padding(.bottom, 10)
                .background(Color.black.opacity(0.5))
            }
        }
        .fullScreenCover(item: $selectedItem) { selectedItem in
            DynamicItemDetailScreen(item: selectedItem, backgroundImageName: backgroundImageName)
        }
    }
}
