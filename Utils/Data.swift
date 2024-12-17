//
//  Data.swift
//  witcher_3_glossary
//
//  Created by Konrad Waszczuk on 07/12/2024.
//

import Foundation
let craftingComponents: [Item] = loadItems(from: "components")

let rawArmorItems: [Item] = loadItems(from: "armor")
var armorItems: [Item] = resolveComponents(for: rawArmorItems, using: craftingComponents)

let rawSwordItems: [Item] = loadItems(from: "swords")
var swordItems: [Item] = resolveComponents(for: rawSwordItems, using: craftingComponents)

let rawMonsterItems: [Item] = loadItems(from: "monsters")
let monstersItems: [Item] = resolveComponents(for: rawMonsterItems, using: craftingComponents)

let rawAlchemyItes: [Item] = loadItems(from: "alchemy")
var alchemyItems: [Item] = resolveComponents(for: rawAlchemyItes, using: craftingComponents)

let rawPeopleItems: [Item] = loadItems(from: "people")
var peopleItems: [Item] = resolveComponents(for: rawPeopleItems, using: craftingComponents)
