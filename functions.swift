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
        return ("armors_background", armorItems, "Armors")
    case .people:
        return ("humans_background", peopleItems, "Humans")
    case .crafting:
        return ("nothing_here", [], "")
    }
}
