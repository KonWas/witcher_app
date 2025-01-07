//
//  BuildModel.swift
//  witcher_3_glossary
//
//  Created by Konrad Waszczuk on 23/12/2024.
//


import Foundation
import SwiftUI

class BuildModel: ObservableObject {
    @Published var armor: Item?
    @Published var trousers: Item?
    @Published var gauntlets: Item?
    @Published var boots: Item?
    @Published var silverSword: Item?
    @Published var steelSword: Item?
    
    // list of armours and swords
    private let allItems: [Item]

    init(allItems: [Item]) {
        self.allItems = allItems
        // load the build from memory
        loadBuild()
    }

    func clearBuild() {
        armor = nil
        trousers = nil
        gauntlets = nil
        boots = nil
        silverSword = nil
        steelSword = nil
    }

    // save to user UserDefaults
    func saveBuild() {
        let defaults = UserDefaults.standard
        
        defaults.set(armor?.name,        forKey: "armorName")
        defaults.set(trousers?.name,     forKey: "trousersName")
        defaults.set(gauntlets?.name,    forKey: "gauntletsName")
        defaults.set(boots?.name,        forKey: "bootsName")
        defaults.set(silverSword?.name,  forKey: "silverSwordName")
        defaults.set(steelSword?.name,   forKey: "steelSwordName")
        
        print("Build saved to UserDefaults.")
    }
    
    func loadBuild() {
        let defaults = UserDefaults.standard
        
        let armorName        = defaults.string(forKey: "armorName")
        let trousersName     = defaults.string(forKey: "trousersName")
        let gauntletsName    = defaults.string(forKey: "gauntletsName")
        let bootsName        = defaults.string(forKey: "bootsName")
        let silverSwordName  = defaults.string(forKey: "silverSwordName")
        let steelSwordName   = defaults.string(forKey: "steelSwordName")
        
        // look for Item in allItems to load it to the build
        self.armor        = allItems.first(where: { $0.name == armorName })
        self.trousers     = allItems.first(where: { $0.name == trousersName })
        self.gauntlets    = allItems.first(where: { $0.name == gauntletsName })
        self.boots        = allItems.first(where: { $0.name == bootsName })
        self.silverSword  = allItems.first(where: { $0.name == silverSwordName })
        self.steelSword   = allItems.first(where: { $0.name == steelSwordName })
        
        print("Build loaded from UserDefaults.")
    }
}

