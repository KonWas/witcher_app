//
//  DynamicItemDetailScreen.swift
//  witcher_3_glossary
//
//  Created by Konrad Waszczuk on 07/12/2024.
//


import SwiftUI

struct DynamicItemDetailScreen: View {
    @Environment(\.presentationMode) var presentationMode
    let item: Item
    let backgroundImageName: String

    @State private var selectedComponent: Item?

    init(item: Item, backgroundImageName: String) {
        self.item = item
        self.backgroundImageName = backgroundImageName
    }
    
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

                Text(item.name)
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .padding(.top, 20)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 20)

                ScrollView {
                    VStack(spacing: 20) {
                        Image(item.imageName)
                            .resizable()
                            .frame(
                                width: (item.category == .armor || item.category == .sword) ? 100 : 200,
                                height: 200
                            )
                            .clipShape(Rectangle())
//                            .overlay(Rectangle().stroke(Color.gray, lineWidth: 1))
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

                        categorySpecificView(item: item)
                            .padding()

                        var categoryText: String {
                            switch item.category {
                            case .people: return "Location"
                            case .monsters: return "Vulnerable to"
                            default: return "Components"
                            }
                        }
                        
                        if let components = item.components, !components.isEmpty {
                            Text(categoryText)
                                .font(.title2)
                                .foregroundColor(.white)
                                .padding(.top)

                            ForEach(components) { component in
                                Button(action: {
                                    selectedComponent = component
                                }) {
                                    HStack {
                                        Image(component.imageName)
                                            .resizable()
                                            .frame(width: 50, height: 50)
                                            .clipShape(Rectangle())
//                                            .overlay(Rectangle().stroke(Color.gray, lineWidth: 1))

                                        Text(component.name)
                                            .font(.headline)
                                            .foregroundColor(.white)
                                            .padding(.leading, 10)
                                    }
                                    .padding()
                                    .background(Color.black.opacity(0.7))
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
        .fullScreenCover(item: $selectedComponent) { component in
            DynamicItemDetailScreen(item: component, backgroundImageName: backgroundImageName)
        }
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
            // Tutaj wyświetlamy dane typowe dla zbroi, np:
            // Text("Armor Rating: \(item.armorRating ?? 0)")
            // Text("Tier: \(item.tier ?? "")")
            // itp.
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
            // Dane typowe dla mikstur/alchemii
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
            // Dane typowe dla potwora, np. słabości, gdzie występuje
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
            // Dane typowe dla postaci
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
            // Dane dla komponentów lub przedmiotów rzemieślniczych
            Text(item.additionalInfo)
                .foregroundColor(.white)
        }
    }
}