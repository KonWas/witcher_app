//
//  witcher_3_glossaryApp.swift
//  witcher_3_glossary
//
//  Created by Konrad Waszczuk on 19/11/2024.
//

import SwiftUI

@main
struct witcher_3_glossaryApp: App {
    @StateObject var buildModel: BuildModel
    
    init() {
        let allItems = armorItems + swordItems
        _buildModel = StateObject(wrappedValue: BuildModel(allItems: allItems))
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(buildModel)
                .preferredColorScheme(.dark)
        }
    }
}
