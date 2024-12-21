//
//  Marker.swift
//  witcher_3_glossary
//
//  Created by Konrad Waszczuk on 21/12/2024.
//


import SwiftUI

struct Marker: Identifiable, Codable {
    let id: UUID
    var name: String
    var description: String
    var xPosition: CGFloat
    var yPosition: CGFloat
}

