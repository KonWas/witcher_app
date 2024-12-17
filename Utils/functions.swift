//
//  functions.swift
//  witcher_3_glossary
//
//  Created by Konrad Waszczuk on 07/12/2024.
//

import Foundation

func getItemsAndBackground(for category: ItemCategory) -> (String, [Item], String) {
    switch category {
    case .alchemy:
        return ("alchemy_background", alchemyItems, "Alchemy")
    case .monsters:
        return ("monsters_background", monstersItems, "Monsters")
    case .armor:
        let combinedArmor = armorItems + swordItems
        return ("armors_background", combinedArmor, "Armors")
    case .sword:
        let combinedArmor = armorItems + swordItems
        return ("armors_background", combinedArmor, "Armors")
    case .people:
        return ("people_background", peopleItems, "People")
    case .crafting:
        return ("nothing_here", [], "")
    }
}


func loadItems<T: Decodable>(from fileName: String) -> [T] {
    guard let url = Bundle.main.url(forResource: fileName, withExtension: "json") else {
        print("Failed to locate \(fileName).json in bundle.")
        return []
    }

    do {
        let data = try Data(contentsOf: url)
        let items = try JSONDecoder().decode([T].self, from: data)
        return items
    } catch {
        print("Failed to decode \(fileName).json: \(error)")
        return []
    }
}

func resolveComponents(for items: [Item], using allComponents: [Item]) -> [Item] {
    for item in items {
        if let componentNames = item.componentNames {
            item.components = componentNames.compactMap { name in
                allComponents.first { $0.name == name }
            }
        }
    }
    return items
}
