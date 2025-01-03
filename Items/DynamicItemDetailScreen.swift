////
////  DynamicItemDetailScreen.swift
////  witcher_3_glossary
////
////  Created by Konrad Waszczuk on 07/12/2024.
////
//
//
//import SwiftUI
//
//struct DynamicItemDetailScreen: View {
//    @Environment(\.presentationMode) var presentationMode
//    @EnvironmentObject var buildModel: BuildModel
//    
//    let item: Item
//    let backgroundImageName: String
//
//    @State private var selectedComponent: Item?
//
//    init(item: Item, backgroundImageName: String) {
//        self.item = item
//        self.backgroundImageName = backgroundImageName
//    }
//
//    var body: some View {
//        ZStack {
//            Image(backgroundImageName)
//                .resizable()
//                .scaledToFill()
//                .opacity(0.6)
//                .edgesIgnoringSafeArea(.all)
//
//            VStack(spacing: 20) {
//                // Back button
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
//                // Item name
//                Text(item.name)
//                    .font(.largeTitle)
//                    .foregroundColor(.white)
//                    .padding(.top, 20)
//                    .frame(maxWidth: .infinity, alignment: .leading)
//                    .padding(.leading, 20)
//
//                // Scrollable content
//                ScrollView {
//                    VStack(spacing: 20) {
//                        // Item image
//                        Image(item.imageName)
//                            .resizable()
//                            .frame(
//                                width: (item.category == .armor || item.category == .sword) ? 100 : 200,
//                                height: 200
//                            )
//                            .clipShape(Rectangle())
//                            .padding()
//
//                        Text("Description")
//                            .font(.title2)
//                            .foregroundColor(.white)
//                            .padding(.top)
//
//                        Text(item.description)
//                            .font(.body)
//                            .foregroundColor(.white)
//                            .multilineTextAlignment(.center)
//                            .padding()
//
//                        // Category-specific content
//                        categorySpecificView(item: item)
//                            .padding()
//
//                        // If the item is .armor or .sword, show "Add to Build" button
//                        if item.category == .armor || item.category == .sword {
//                            Button(action: {
//                                addToBuild(item)
//                            }) {
//                                Text("Add to Build")
//                                    .foregroundColor(Color(red: 1, green: 0.94, blue: 0.74).opacity(0.70))
//                                    .frame(width: 120, height: 40)
//                                    .background(Color.black.opacity(0.30))
//                                    .cornerRadius(50)
//                                    .overlay(
//                                        RoundedRectangle(cornerRadius: 50)
//                                            .stroke(Color(red: 1, green: 0.94, blue: 0.74).opacity(0.70), lineWidth: 0.50)
//                                    )
//                            }
//                        }
//
//                        var categoryText: String {
//                            switch item.category {
//                            case .people:   return "Location"
//                            case .monsters: return "Vulnerable to"
//                            default:        return "Components"
//                            }
//                        }
//
//                        if let components = item.components, !components.isEmpty {
//                            Text(categoryText)
//                                .font(.title2)
//                                .foregroundColor(.white)
//                                .padding(.top)
//
//                            ForEach(components) { component in
//                                Button(action: {
//                                    selectedComponent = component
//                                }) {
//                                    HStack {
//                                        Image(component.imageName)
//                                            .resizable()
//                                            .frame(width: 50, height: 50)
//                                            .clipShape(Rectangle())
//                                        Text(component.name)
//                                            .font(.headline)
//                                            .foregroundColor(.white)
//                                            .padding(.leading, 10)
//                                    }
//                                    .padding()
//                                    .background(Color.black.opacity(0.5))
//                                    .cornerRadius(10)
//                                }
//                            }
//                            .padding(.bottom, 20)
//                        }
//                    }
//                }
//                .padding(.horizontal, 20)
//            }
//        }
//        .fullScreenCover(item: $selectedComponent) { component in
//            DynamicItemDetailScreen(
//                item: component,
//                backgroundImageName: backgroundImageName
//            )
//            .environmentObject(buildModel)
//        }
//    }
//
//    // Here you can customize how items go into build slots
//    private func addToBuild(_ item: Item) {
//        let lowercasedName = item.name.lowercased()
//
//        if lowercasedName.contains("armor") {
//            buildModel.armor = item
//        } else if lowercasedName.contains("trousers") {
//            buildModel.trousers = item
//        } else if lowercasedName.contains("gauntlets") {
//            buildModel.gauntlets = item
//        } else if lowercasedName.contains("boots") {
//            buildModel.boots = item
//        } else if lowercasedName.contains("silver sword") || lowercasedName.contains("silver_sword") {
//            buildModel.silverSword = item
//        } else if lowercasedName.contains("steel sword") || lowercasedName.contains("steel_sword") {
//            buildModel.steelSword = item
//        }
//        // You can add more logic as needed.
//    }
//
//    @ViewBuilder
//    private func categorySpecificView(item: Item) -> some View {
//        switch item.category {
//        case .armor:
//            armorView(item: item)
//        case .sword:
//            armorView(item: item)
//        case .alchemy:
//            alchemyView(item: item)
//        case .monsters:
//            monsterView(item: item)
//        case .people:
//            peopleView(item: item)
//        case .crafting:
//            craftingView(item: item)
//        }
//    }
//
//    @ViewBuilder
//    private func armorView(item: Item) -> some View {
//        VStack(alignment: .leading, spacing: 10) {
//            Text("Gear Specific Stats:")
//                .font(.headline)
//                .foregroundColor(.white)
//            Text(item.additionalInfo)
//                .foregroundColor(.white)
//        }
//    }
//
//    @ViewBuilder
//    private func alchemyView(item: Item) -> some View {
//        VStack(alignment: .leading, spacing: 10) {
//            Text("Alchemy Specific Stats:")
//                .font(.headline)
//                .foregroundColor(.white)
//            Text(item.additionalInfo)
//                .foregroundColor(.white)
//        }
//    }
//
//    @ViewBuilder
//    private func monsterView(item: Item) -> some View {
//        VStack(alignment: .leading, spacing: 10) {
//            Text("Monster Info:")
//                .font(.headline)
//                .foregroundColor(.white)
//            Text(item.additionalInfo)
//                .foregroundColor(.white)
//        }
//    }
//
//    @ViewBuilder
//    private func peopleView(item: Item) -> some View {
//        VStack(alignment: .leading, spacing: 10) {
//            Text("Person Info:")
//                .font(.headline)
//                .foregroundColor(.white)
//            Text(item.additionalInfo)
//                .foregroundColor(.white)
//        }
//    }
//
//    @ViewBuilder
//    private func craftingView(item: Item) -> some View {
//        VStack(alignment: .leading, spacing: 10) {
//            Text("Crafting Material Info:")
//                .font(.headline)
//                .foregroundColor(.white)
//            Text(item.additionalInfo)
//                .foregroundColor(.white)
//        }
//    }
//}

import SwiftUI

extension String: Identifiable {
    public var id: String { self }
}

struct DynamicItemDetailScreen: View {
    
    
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var buildModel: BuildModel
    
    let item: Item
    let backgroundImageName: String

    @State private var selectedComponent: Item?
    @State private var selectedRegionName: String?

    init(item: Item, backgroundImageName: String) {
        self.item = item
        self.backgroundImageName = backgroundImageName
    }

    var body: some View {
        ZStack {
            Image(backgroundImageName)
                .resizable()
                .scaledToFill()
                .opacity(0.6)
                .edgesIgnoringSafeArea(.all)

            VStack(spacing: 20) {
                // Back button
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

                // Item name
                Text(item.name)
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .padding(.top, 20)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 20)

                // Scrollable content
                ScrollView {
                    VStack(spacing: 20) {
                        // Item image
                        Image(item.imageName)
                            .resizable()
                            .frame(
                                width: (item.category == .armor || item.category == .sword) ? 100 : 200,
                                height: 200
                            )
                            .clipShape(Rectangle())
                            .padding()

                        Text("Description")
                            .font(.title2)
                            .foregroundColor(.white)
                            .padding(.top)

                        Text(item.description)
                            .font(.body)
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                            .padding()

                        // Category-specific content
                        categorySpecificView(item: item)
                            .padding()

                        // If the item is .armor or .sword, show "Add to Build" button
                        if item.category == .armor || item.category == .sword {
                            Button(action: {
                                addToBuild(item)
                            }) {
                                Text("Add to Build")
                                    .foregroundColor(Color(red: 1, green: 0.94, blue: 0.74).opacity(0.70))
                                    .frame(width: 120, height: 40)
                                    .background(Color.black.opacity(0.30))
                                    .cornerRadius(50)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 50)
                                            .stroke(Color(red: 1, green: 0.94, blue: 0.74).opacity(0.70), lineWidth: 0.50)
                                    )
                            }
                        }

                        // Różne tytuły sekcji:
                        var categoryText: String {
                            switch item.category {
                            case .people:   return "Location"
                            case .monsters: return "Vulnerable to"
                            default:        return "Components"
                            }
                        }

                        // Komponenty danej pozycji
                        if let components = item.components, !components.isEmpty {
                            Text(categoryText)
                                .font(.title2)
                                .foregroundColor(.white)
                                .padding(.top)

                            ForEach(components) { component in
                                Button(action: {
                                    if item.category == .people {
                                        // Zamiast otwierać detail, przejdź do RegionMap
                                        selectedRegionName = component.name
                                    } else {
                                        // Dotychczasowe przejście do detail
                                        selectedComponent = component
                                    }
                                }) {
                                    HStack {
                                        Image(component.imageName)
                                            .resizable()
                                            .frame(width: 50, height: 50)
                                            .clipShape(Rectangle())
                                        Text(component.name)
                                            .font(.headline)
                                            .foregroundColor(.white)
                                            .padding(.leading, 10)
                                    }
                                    .padding()
                                    .background(Color.black.opacity(0.5))
                                    .cornerRadius(10)
                                }
                            }
                            .padding(.bottom, 20)
                        }
                    }
                }
                .padding(.horizontal, 20)
            }
        }
        // Przejście do detail dla zwykłych komponentów
        .fullScreenCover(item: $selectedComponent) { component in
            DynamicItemDetailScreen(
                item: component,
                backgroundImageName: backgroundImageName
            )
            .environmentObject(buildModel)
        }
        // Przejście do region map, gdy category == .people
        .fullScreenCover(item: $selectedRegionName) { region in
            RegionMap(regionName: region)
        }
    }

    // Here you can customize how items go into build slots
    private func addToBuild(_ item: Item) {
        let lowercasedName = item.name.lowercased()

        if lowercasedName.contains("armor") {
            buildModel.armor = item
        } else if lowercasedName.contains("trousers") {
            buildModel.trousers = item
        } else if lowercasedName.contains("gauntlets") {
            buildModel.gauntlets = item
        } else if lowercasedName.contains("boots") {
            buildModel.boots = item
        } else if lowercasedName.contains("silver sword") || lowercasedName.contains("silver_sword") {
            buildModel.silverSword = item
        } else if lowercasedName.contains("steel sword") || lowercasedName.contains("steel_sword") {
            buildModel.steelSword = item
        }
        // You can add more logic as needed.
    }

    @ViewBuilder
    private func categorySpecificView(item: Item) -> some View {
        switch item.category {
        case .armor:
            armorView(item: item)
        case .sword:
            armorView(item: item)
        case .alchemy:
            alchemyView(item: item)
        case .monsters:
            monsterView(item: item)
        case .people:
            peopleView(item: item)
        case .crafting:
            craftingView(item: item)
        }
    }

    @ViewBuilder
    private func armorView(item: Item) -> some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Gear Specific Stats:")
                .font(.headline)
                .foregroundColor(.white)
            Text(item.additionalInfo)
                .foregroundColor(.white)
        }
    }

    @ViewBuilder
    private func alchemyView(item: Item) -> some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Alchemy Specific Stats:")
                .font(.headline)
                .foregroundColor(.white)
            Text(item.additionalInfo)
                .foregroundColor(.white)
        }
    }

    @ViewBuilder
    private func monsterView(item: Item) -> some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Monster Info:")
                .font(.headline)
                .foregroundColor(.white)
            Text(item.additionalInfo)
                .foregroundColor(.white)
        }
    }

    @ViewBuilder
    private func peopleView(item: Item) -> some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Person Info:")
                .font(.headline)
                .foregroundColor(.white)
            Text(item.additionalInfo)
                .foregroundColor(.white)
        }
    }

    @ViewBuilder
    private func craftingView(item: Item) -> some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Crafting Material Info:")
                .font(.headline)
                .foregroundColor(.white)
            Text(item.additionalInfo)
                .foregroundColor(.white)
        }
    }
}
