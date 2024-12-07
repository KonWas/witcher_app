//
//  Item.swift
//  witcher_3_glossary
//
//  Created by Konrad Waszczuk on 07/12/2024.
//


import Foundation

enum ItemCategory {
    case alchemy
    case monsters
    case armor
    case people
    case crafting
}

class Item: Identifiable {
    let id = UUID()
    let name: String
    let description: String
    let imageName: String
    let category: ItemCategory
    let additionalInfo: String
    let components: [Item]?
    
    init(name: String, description: String, imageName: String, category: ItemCategory, additionalInfo: String, components: [Item]?) {
        self.name = name
        self.description = description
        self.imageName = imageName
        self.category = category
        self.additionalInfo = additionalInfo
        self.components = components
    }
}

