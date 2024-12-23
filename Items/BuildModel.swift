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

    func clearBuild() {
        armor = nil
        trousers = nil
        gauntlets = nil
        boots = nil
        silverSword = nil
        steelSword = nil
    }
}

