//
//  DynamicItemListScreen.swift
//  witcher_3_glossary
//
//  Created by Konrad Waszczuk on 07/12/2024.
//


import SwiftUI

struct DynamicItemListScreen: View {
    @EnvironmentObject var buildModel: BuildModel
    
    @Environment(\.presentationMode) var presentationMode
    let category: ItemCategory
    let backgroundImageName: String
    let items: [Item]
    let title: String
    
    @State private var selectedItem: Item?
    @State private var selectedCategory: ItemCategory? // For filtering
    @State private var searchText: String = "" // For search input
    @State private var showBuildScreen = false  // <-- to present build screen

    var filteredItems: [Item] {
        items.filter { item in
            let matchesCategory = backgroundImageName == "armors_background" ?
                (selectedCategory == nil || item.category == selectedCategory) : true
            let matchesSearch = searchText.isEmpty ||
                item.name.lowercased().contains(searchText.lowercased())
            return matchesCategory && matchesSearch
        }
    }

    var body: some View {
        ZStack {
            Image(backgroundImageName)
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)

            VStack(spacing: 20) {
                // Top bar with Back button + optionally "Go to Build" button
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

                    // Show "Go to Build" button if in armor background
                    if backgroundImageName == "armors_background" {
                        Button(action: {
                            showBuildScreen.toggle()
                        }) {
                            Text("Go to Build")
                                .foregroundColor(Color(red: 1, green: 0.94, blue: 0.74).opacity(0.70))
                                .frame(width: 120, height: 40)
                                .background(Color.black.opacity(0.50))
                                .cornerRadius(50)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 50)
                                        .stroke(Color(red: 1, green: 0.94, blue: 0.74).opacity(0.70), lineWidth: 0.50)
                                )
                        }
                    }
                }
                .padding(.top, 60)
                .padding(.horizontal, 30)

                // Title
                Text(title)
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .padding(.top, 20)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 20)

                // Search Bar
                TextField("Search...", text: $searchText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal, 20)
                    .opacity(0.5)

                // Filter Buttons
                if backgroundImageName == "armors_background" {
                    HStack(spacing: 20) {
                        Button("All") {
                            selectedCategory = nil
                        }
                        .buttonStyle(FilterButtonStyle(isSelected: selectedCategory == nil))

                        Button("Swords") {
                            selectedCategory = .sword
                        }
                        .buttonStyle(FilterButtonStyle(isSelected: selectedCategory == .sword))

                        Button("Armor") {
                            selectedCategory = .armor
                        }
                        .buttonStyle(FilterButtonStyle(isSelected: selectedCategory == .armor))
                    }
                    .padding(.horizontal, 20)
                }

                // Item List
                List(filteredItems) { item in
                    Button(action: {
                        selectedItem = item
                    }) {
                        HStack {
                            Image(item.imageName)
                                .resizable()
                                .frame(
                                    width: (item.category == .armor || item.category == .sword) ? 25 : 50,
                                    height: 50
                                )
                                .clipShape(Rectangle())

                            Text(item.name)
                                .font(.headline)
                                .foregroundColor(.white)
                        }
                    }
                    .listRowBackground(Color.black.opacity(0.5))
                }
                .listStyle(PlainListStyle())
            }
        }
        .fullScreenCover(item: $selectedItem) { selectedItem in
            DynamicItemDetailScreen(
                item: selectedItem,
                backgroundImageName: backgroundImageName
            )
            .environmentObject(buildModel)
        }
        .fullScreenCover(isPresented: $showBuildScreen) {
            BuildScreen()
                .environmentObject(buildModel)
        }
    }
}

struct FilterButtonStyle: ButtonStyle {
    var isSelected: Bool

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.headline)
            .foregroundColor(isSelected ? .yellow : .white)
            .frame(width: 70, height: 40)
            .background(isSelected ? Color(red: 1, green: 0.94, blue: 0.74).opacity(0.3) : Color.black.opacity(0.3))
            .cornerRadius(50)
            .overlay(
                RoundedRectangle(cornerRadius: 50)
                    .stroke(Color(red: 1, green: 0.94, blue: 0.74).opacity(0.70), lineWidth: 0.5)
            )
    }
}
