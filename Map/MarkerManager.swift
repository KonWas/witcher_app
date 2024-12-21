//
//  MarkerManager.swift
//  witcher_3_glossary
//
//  Created by Konrad Waszczuk on 21/12/2024.
//


import Foundation
import SwiftUI

class MarkerManager: ObservableObject {
    @Published var markers: [Marker] = []
    private var regionName: String
    
    init(regionName: String) {
        self.regionName = regionName
        loadMarkers()
    }
    
    private func getDocumentsDirectory() -> URL {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    }
    
    private func getFileURL() -> URL {
        getDocumentsDirectory().appendingPathComponent("\(regionName)_markers.json")
    }
    
    func loadMarkers() {
        let url = getFileURL()
        guard let data = try? Data(contentsOf: url) else {
            markers = []
            return
        }
        let decoder = JSONDecoder()
        if let decoded = try? decoder.decode([Marker].self, from: data) {
            markers = decoded
        } else {
            markers = []
        }
    }
    
    func saveMarkers() {
        let url = getFileURL()
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        if let encoded = try? encoder.encode(markers) {
            try? encoded.write(to: url)
        }
    }
    
    func addMarker(_ marker: Marker) {
        markers.append(marker)
        saveMarkers()
    }
    
    func removeMarker(_ marker: Marker) {
        markers.removeAll { $0.id == marker.id }
        saveMarkers()
    }
}
