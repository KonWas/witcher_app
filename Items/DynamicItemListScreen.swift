////
////  DynamicItemListScreen.swift
////  witcher_3_glossary
////
////  Created by Konrad Waszczuk on 07/12/2024.
////
//
//
//import SwiftUI
//
//
//struct DynamicItemListScreen: View {
//    @Environment(\.presentationMode) var presentationMode
//    let category: ItemCategory
//    let backgroundImageName: String
//    let items: [Item]
//    let title: String
//
//    @State private var selectedItem: Item?
//
//    var body: some View {
//        ZStack {
//            Image(backgroundImageName)
//                .resizable()
//                .scaledToFill()
//                .edgesIgnoringSafeArea(.all)
//
//            VStack(spacing: 20) {
//                HStack {
//                    Button(action: {
//                        presentationMode.wrappedValue.dismiss()
//                    }) {
//                        Image(systemName: "arrow.left")
//                            .foregroundColor(Color(red: 1, green: 0.94, blue: 0.74).opacity(0.70))
//                            .frame(width: 40, height: 40)
//                            .background(Color.black.opacity(0.30))
//                            .cornerRadius(50)
//                            .overlay(
//                                RoundedRectangle(cornerRadius: 50)
//                                    .stroke(Color(red: 1, green: 0.94, blue: 0.74).opacity(0.70), lineWidth: 0.50)
//                            )
//                    }
//                    Spacer()
//                }
//                .padding(.top, 60)
//                .padding(.leading, 30)
//
//                Text(title)
//                    .font(.largeTitle)
//                    .foregroundColor(.white)
//                    .padding(.top, 20)
//                    .frame(maxWidth: .infinity, alignment: .leading)
//                    .padding(.leading, 20)
//
//                HStack {
//                    Button(action: {
//                        
//                    }) {
//                        Text("Filter")
//                            .font(Font.custom("SF", size: 16))
//                            .foregroundColor(Color(red: 1, green: 0.94, blue: 0.74).opacity(0.70))
//                            .frame(width: 70, height: 40)
//                            .background(Color.black.opacity(0.30))
//                            .cornerRadius(50)
//                            .overlay(
//                                RoundedRectangle(cornerRadius: 50)
//                                    .stroke(Color(red: 1, green: 0.94, blue: 0.74).opacity(0.70), lineWidth: 0.50)
//                            )
//                    }
//
//                    Spacer()
//
//                    Button(action: {
//                    }) {
//                        Text("Search")
//                            .font(Font.custom("SF", size: 16))
//                            .foregroundColor(Color(red: 1, green: 0.94, blue: 0.74).opacity(0.70))
//                            .frame(width: 70, height: 40)
//                            .background(Color.black.opacity(0.30))
//                            .cornerRadius(50)
//                            .overlay(
//                                RoundedRectangle(cornerRadius: 50)
//                                    .stroke(Color(red: 1, green: 0.94, blue: 0.74).opacity(0.70), lineWidth: 0.50)
//                            )
//                    }
//                }
//                .padding(.horizontal, 20)
//
//                List(items) { item in
//                    Button(action: {
//                        selectedItem = item
//                    }) {
//                        HStack {
//                            Image(item.imageName)
//                                .resizable()
//                                .frame(
//                                    width: (item.category == .armor) ? 25 : 50,
//                                    height: 50
//                                )
//                                .clipShape(Rectangle())
////                                .overlay(Rectangle().stroke(Color.gray, lineWidth: 1))
//
//                            Text(item.name)
//                                .font(.headline)
//                                .foregroundColor(.white)
//                        }
//                    }
//                    .listRowBackground(Color.black.opacity(0.7))
//                }
//                .listStyle(PlainListStyle())
//                .padding(.bottom, 10)
////                .background(Color.black.opacity(0.5))
//            }
//        }
//        .fullScreenCover(item: $selectedItem) { selectedItem in
//            DynamicItemDetailScreen(item: selectedItem, backgroundImageName: backgroundImageName)
//        }
//    }
//}


import SwiftUI

struct DynamicItemListScreen: View {
    @Environment(\.presentationMode) var presentationMode
    let category: ItemCategory
    let backgroundImageName: String
    let items: [Item]
    let title: String

    @State private var selectedItem: Item?
    @State private var selectedCategory: ItemCategory? // For filtering
    @State private var searchText: String = "" // For search input

    // Filtered and Searched Items
    var filteredItems: [Item] {
        items.filter { item in
            // Apply filtering only if background is "armors_background"
            let matchesCategory = backgroundImageName == "armors_background" ?
                (selectedCategory == nil || item.category == selectedCategory) : true
            
            // Apply search query (case insensitive)
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
                // Back Button
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

                // Filter Buttons (Only for "armors_background")
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

                // List of Items
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
                    .listRowBackground(Color.black.opacity(0.7))
                }
                .listStyle(PlainListStyle())
            }
        }
        .fullScreenCover(item: $selectedItem) { selectedItem in
            DynamicItemDetailScreen(item: selectedItem, backgroundImageName: backgroundImageName)
        }
    }
}

// Filter Button Style
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
