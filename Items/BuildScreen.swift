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

                Text("My Build")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .padding(.top, 20)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 20)

                let totalArmor = calculateTotalArmor()
                
                let steelDamage = parseDamage(from: buildModel.steelSword?.additionalInfo)
                let silverDamage = parseDamage(from: buildModel.silverSword?.additionalInfo)

                VStack(spacing: 8) {
                    Text("Total Armor: \(totalArmor)")
                        .foregroundColor(.white)
                        .font(.headline)

                    Text("Steel Sword Damage: \(steelDamage ?? "-")")
                        .foregroundColor(.white)
                    Text("Silver Sword Damage: \(silverDamage ?? "-")")
                        .foregroundColor(.white)
                }
                .padding(.vertical, 10)
                .padding(.horizontal, 16)
                .background(Color.black.opacity(0.6))
                .cornerRadius(12)

                ScrollView {
                    VStack(alignment: .leading, spacing: 20) {
                        buildSlotView(label: "Armor", item: buildModel.armor)
                        buildSlotView(label: "Trousers", item: buildModel.trousers)
                        buildSlotView(label: "Gauntlets", item: buildModel.gauntlets)
                        buildSlotView(label: "Boots", item: buildModel.boots)
                        buildSlotView(label: "Silver Sword", item: buildModel.silverSword)
                        buildSlotView(label: "Steel Sword", item: buildModel.steelSword)

                        if !allEffects().isEmpty {
                            Text("Combined Effects:")
                                .font(.headline)
                                .foregroundColor(.white)
                            VStack(alignment: .leading, spacing: 10) {
                                ForEach(allEffects(), id: \.self) { effectLine in
                                    Text(effectLine)
                                        .foregroundColor(.white)
                                }
                            }
                            .padding()
                            .background(Color.black.opacity(0.7))
                            .cornerRadius(10)
                        }
                    }
                    .padding(.horizontal, 20)
                }

                HStack(spacing: 20) {
                    Button(action: {
                        buildModel.clearBuild()
                    }) {
                        Text("Clear Build")
                            .foregroundColor(Color(red: 1, green: 0.94, blue: 0.74).opacity(0.70))
                            .frame(width: 120, height: 40)
                            .background(Color.black.opacity(0.30))
                            .cornerRadius(50)
                            .overlay(
                                RoundedRectangle(cornerRadius: 50)
                                    .stroke(Color(red: 1, green: 0.94, blue: 0.74).opacity(0.70), lineWidth: 0.50)
                            )
                    }

                    Button(action: {
                        buildModel.saveBuild()
                    }) {
                        Text("Save Build")
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
                .padding(.bottom, 40)
            }
        }
    }


    private func calculateTotalArmor() -> Int {
        var total = 0

        let gearItems: [Item?] = [
            buildModel.armor,
            buildModel.trousers,
            buildModel.gauntlets,
            buildModel.boots
        ]

        for gear in gearItems.compactMap({ $0 }) {
            if let armorValue = parseArmor(from: gear.additionalInfo) {
                total += armorValue
            }
        }
        return total
    }

    private func parseArmor(from additionalInfo: String) -> Int? {
        let lines = additionalInfo.components(separatedBy: "\n")
        for line in lines {
            if line.contains("Armor:") {
                // we search for example: "Armor: 105,"
                if let numberString = line.components(separatedBy: "Armor:").last?
                    .trimmingCharacters(in: .whitespacesAndNewlines)
                    .components(separatedBy: CharacterSet.decimalDigits.inverted)
                    .joined(),
                   let armorValue = Int(numberString) {
                    return armorValue
                }
            }
        }
        return nil
    }

    private func parseDamage(from additionalInfo: String?) -> String? {
        guard let additionalInfo = additionalInfo else { return nil }
        let lines = additionalInfo.components(separatedBy: "\n")
        for line in lines {
            if line.contains("Damage:") {
                // we search for example "Damage: 229-279,"
                if let damageString = line.components(separatedBy: "Damage:").last?
                    .trimmingCharacters(in: .whitespacesAndNewlines)
                    .replacingOccurrences(of: ",", with: "") {
                    return damageString
                }
            }
        }
        return nil
    }


    private func allEffects() -> [String] {
        let allItems: [Item?] = [
            buildModel.armor,
            buildModel.trousers,
            buildModel.gauntlets,
            buildModel.boots,
            buildModel.silverSword,
            buildModel.steelSword
        ]

        var effectsLines: [String] = []

        for item in allItems.compactMap({ $0 }) {
            let lines = item.additionalInfo.components(separatedBy: "\n")
            var shouldCollect = false
            for line in lines {
                if line.contains("Effect(s):") {
                    shouldCollect = true
                    continue
                }
    
                if shouldCollect {
                    if line.hasPrefix("Slots:") ||
                       line.hasPrefix("Armor:") ||
                       line.hasPrefix("Damage:") ||
                       line.hasPrefix("Diagram:") ||
                       line.isEmpty {
                        shouldCollect = false
                    } else {
                        // clean string from commas and whitespaces
                        let cleanedLine = line.trimmingCharacters(in: .whitespacesAndNewlines)
                            .replacingOccurrences(of: ",", with: "")
                        if !cleanedLine.isEmpty {
                            effectsLines.append(cleanedLine)
                        }
                    }
                }
            }
        }

        return effectsLines
    }

    // Build Slot View - function that helps creating slots for each piece of build
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
