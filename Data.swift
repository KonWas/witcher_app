//
//  Data.swift
//  witcher_3_glossary
//
//  Created by Konrad Waszczuk on 07/12/2024.
//

import Foundation

let craftingComponents = [
    Item(name: "Shirt", description: "A plain shirt used in crafting armor.", imageName: "shirt", category: .crafting, additionalInfo: "Base component for light armor crafting.", components: nil),
    Item(name: "Dark Steel Plate", description: "A reinforced steel plate.", imageName: "dark_steel_plate", category: .crafting, additionalInfo: "Crafted from steel ingots and used in armor crafting.", components: nil),
    Item(name: "Hardened Leather", description: "Leather reinforced for crafting.", imageName: "hardened_leather", category: .crafting, additionalInfo: "Crafted from tanned hides.", components: nil),
    Item(name: "Powdered Monster Tissue", description: "Rare material from monsters.", imageName: "powdered_monster_tissue", category: .crafting, additionalInfo: "Found on powerful monsters.", components: nil),
    Item(name: "Meteorite Silver Ingot", description: "Refined silver from meteorite ore.", imageName: "meteorite_silver_ingot", category: .crafting, additionalInfo: "Used in weapon crafting.", components: nil),
    Item(name: "Ruby", description: "A precious red gemstone.", imageName: "ruby", category: .crafting, additionalInfo: "Valuable crafting material.", components: nil),
    Item(name: "Emerald", description: "A precious green gemstone.", imageName: "emerald", category: .crafting, additionalInfo: "Used in crafting magical equipment.", components: nil),
    Item(name: "Griffin Feather", description: "Feather from a Griffin.", imageName: "griffin_feather", category: .crafting, additionalInfo: "Rare component found on Griffins.", components: nil),
    Item(name: "Wyvern Hide", description: "Hide of a mighty Wyvern.", imageName: "wyvern_hide", category: .crafting, additionalInfo: "Used in crafting durable armor.", components: nil),
    Item(name: "Beast Oil", description: "Oil for coating blades.", imageName: "beast_oil", category: .alchemy, additionalInfo: "Increases damage against beasts.", components: nil),
    Item(name: "Alcohol", description: "Strong alcohol for alchemy.", imageName: "alcohol", category: .alchemy, additionalInfo: "Base ingredient for potions and bombs.", components: nil),
    Item(name: "Herbs", description: "Rare herbs found in the wild.", imageName: "herbs", category: .alchemy, additionalInfo: "Used in crafting healing potions.", components: nil),
    Item(name: "Monster Blood", description: "Blood of a powerful monster.", imageName: "monster_blood", category: .alchemy, additionalInfo: "Valuable alchemical reagent.", components: nil),
    Item(name: "Sulfur", description: "A volatile yellow mineral.", imageName: "sulfur", category: .alchemy, additionalInfo: "Used in crafting bombs.", components: nil)
]


let alchemyItems = [
    Item(name: "Potion of Healing", description: "Restores 50 HP.", imageName: "healing_potion", category: .alchemy, additionalInfo: "Crafted using rare herbs.", components: [
        craftingComponents[11], // Herbs
        craftingComponents[10]  // Alcohol
    ]),
    Item(name: "Bomb", description: "Explodes on impact.", imageName: "bomb", category: .alchemy, additionalInfo: "Requires alchemy level 3.", components: [
        craftingComponents[13], // Sulfur
        craftingComponents[10]  // Alcohol
    ])
]

let monstersItems = [
    Item(name: "Griffin Trophy", description: "Trophy from a slain Griffin.", imageName: "griffin_trophy", category: .monsters, additionalInfo: "Increases sign intensity.", components: [
        craftingComponents[7] // Griffin Feather
    ]),
    Item(name: "Wyvern Hide", description: "Hide of a mighty Wyvern.", imageName: "wyvern_hide", category: .monsters, additionalInfo: "Used in crafting armor.", components: [
        craftingComponents[8] // Wyvern Hide
    ])
]

let armorItems = [
    Item(name: "Feline Armor", description: "Light armor for agile fighters.", imageName: "feline_armor", category: .armor, additionalInfo: "Part of the Cat School Gear.", components: [
        craftingComponents[0],  // Shirt
        craftingComponents[1],  // Dark Steel Plate
        craftingComponents[2],  // Hardened Leather
        craftingComponents[3],  // Powdered Monster Tissue
        craftingComponents[4]   // Meteorite Silver Ingot
    ]),
    Item(name: "Griffin Armor", description: "Heavy armor with bonuses to signs.", imageName: "griffin_armor", category: .armor, additionalInfo: "Part of the Griffin School Gear.", components: [
        craftingComponents[1],  // Dark Steel Plate
        craftingComponents[2],  // Hardened Leather
        craftingComponents[3],  // Powdered Monster Tissue
        craftingComponents[7],  // Griffin Feather
        craftingComponents[5]   // Ruby
    ])
]

let peopleItems = [
    Item(name: "Temerian Soldier", description: "A loyal soldier of Temeria.", imageName: "temerian_soldier", category: .people, additionalInfo: "Skilled in swordsmanship.", components: nil),
    Item(name: "Nilfgaardian Knight", description: "Elite warrior of the Empire.", imageName: "nilfgaardian_knight", category: .people, additionalInfo: "Wields a longsword.", components: nil)
]
