//
//  Item.swift
//  witcher_3_glossary
//
//  Created by Konrad Waszczuk on 07/12/2024.
//


import Foundation
import UIKit

class Item: Identifiable, Decodable {
    let id = UUID()
    let name: String
    let description: String
    var imageName: String
    let category: ItemCategory
    let additionalInfo: String
    let componentNames: [String]?
    var components: [Item]?
    
    enum CodingKeys: String, CodingKey {
        case name
        case description
        case imageName
        case category
        case additionalInfo
        case componentNames = "components"
    }

    init(name: String, description: String, imageName: String, category: ItemCategory, additionalInfo: String, components: [Item]?) {
        self.name = name
        self.description = description
        self.imageName = imageName
        self.category = category
        self.additionalInfo = additionalInfo
        self.components = components
        self.componentNames = nil
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.description = try container.decode(String.self, forKey: .description)
        self.imageName = try container.decode(String.self, forKey: .imageName)
        self.category = try container.decode(ItemCategory.self, forKey: .category)
        self.additionalInfo = try container.decode(String.self, forKey: .additionalInfo)
        self.componentNames = try container.decodeIfPresent([String].self, forKey: .componentNames)
        self.components = nil
        
        if UIImage(named: self.imageName) == nil {
            self.imageName = "question_mark"
        }
    }
}

enum ItemCategory: String, Decodable {
    case crafting = ".crafting"
    case armor = ".armor"
    case sword = ".sword"
    case alchemy = ".alchemy"
    case monsters = ".monsters"
    case people = ".people"
}
