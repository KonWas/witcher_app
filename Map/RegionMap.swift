//
//  RegionMap.swift
//  witcher_3_glossary
//
//  Created by Konrad Waszczuk on 03/12/2024.
//


import SwiftUI

struct RegionMap: View {
    @Environment(\.presentationMode) var presentationMode
    let regionName: String
    @StateObject private var markerManager: MarkerManager
    
    @State private var showingAddMarker = false
    @State private var newMarkerPosition: CGPoint?
    @State private var tempMarkerName = ""
    @State private var tempMarkerDescription = ""
    
    init(regionName: String) {
        self.regionName = regionName
        _markerManager = StateObject(wrappedValue: MarkerManager(regionName: regionName))
    }
    
    var body: some View {
        ZStack {
            ZoomableScrollView {
                GeometryReader { geo in
                    ZStack {
                        Image("\(regionName.lowercased())_map")
                            .resizable()
                            .scaledToFill()
                            .frame(width: geo.size.width, height: geo.size.height)
                            .onTapGesture { location in
                                guard showingAddMarker else { return }
                                let pos = CGPoint(x: location.x / geo.size.width, y: location.y / geo.size.height)
                                newMarkerPosition = pos
                            }
                        
                        // Wyświetlanie istniejących znaczników dla danego regionu
                        ForEach(markerManager.markers) { marker in
                            MarkerView(marker: marker, mapSize: geo.size)
                                .environmentObject(markerManager)
                        }
                    }
                }
            }
            .edgesIgnoringSafeArea(.all)
            
            // Przyciski nawigacyjne
            VStack {
                HStack {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "arrow.left")
                            .foregroundColor(Color(red: 1, green: 0.94, blue: 0.74).opacity(0.70))
                            .frame(width: 40, height: 40)
                            .background(Color.black.opacity(0.30))
                            .cornerRadius(50)
                            .overlay(
                                RoundedRectangle(cornerRadius: 50)
                                    .stroke(Color(red: 1, green: 0.94, blue: 0.74).opacity(0.70), lineWidth: 0.50)
                            )
                    }
                    Spacer()
                    
                    Button(action: {
                        showingAddMarker.toggle()
                    }) {
                        Image(systemName: "plus")
                            .foregroundColor(Color(red: 1, green: 0.94, blue: 0.74).opacity(0.70))
                            .frame(width: 40, height: 40)
                            .background(Color.black.opacity(0.30))
                            .cornerRadius(50)
                            .overlay(
                                RoundedRectangle(cornerRadius: 50)
                                    .stroke(Color(red: 1, green: 0.94, blue: 0.74).opacity(0.70), lineWidth: 0.50)
                            )
                    }
                }
                .padding(.top, 60)
                .padding(.horizontal, 30)
                
                Spacer()
            }
            
            // Formularz dodawania znacznika
            if showingAddMarker, let pos = newMarkerPosition {
                            VStack {
                                Spacer()
                                
                                VStack(spacing: 20) {
                                    Text("Add marker")
                                        .font(.headline)
                                        .foregroundColor(Color(red: 1, green: 0.94, blue: 0.74).opacity(0.70))
                                    
                                    // Pole na nazwę znacznika
                                    TextField("Name", text: $tempMarkerName)
                                        .foregroundColor(Color(red: 1, green: 0.94, blue: 0.74).opacity(0.70))
                                        .padding(.horizontal, 20)
                                        .padding(.vertical, 10)
                                        .background(Color.black.opacity(0.30))
                                        .cornerRadius(50)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 50)
                                                .stroke(Color(red: 1, green: 0.94, blue: 0.74).opacity(0.70), lineWidth: 0.50)
                                        )
                                    
                                    // Pole na opis znacznika
                                    TextField("Description", text: $tempMarkerDescription)
                                        .foregroundColor(Color(red: 1, green: 0.94, blue: 0.74).opacity(0.70))
                                        .padding(.horizontal, 20)
                                        .padding(.vertical, 10)
                                        .background(Color.black.opacity(0.30))
                                        .cornerRadius(50)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 50)
                                                .stroke(Color(red: 1, green: 0.94, blue: 0.74).opacity(0.70), lineWidth: 0.50)
                                        )
                                    
                                    HStack {
                                        Button(action: {
                                            showingAddMarker = false
                                            tempMarkerName = ""
                                            tempMarkerDescription = ""
                                        }) {
                                            Text("Cancel")
                                                .foregroundColor(Color(red: 1, green: 0.94, blue: 0.74).opacity(0.70))
                                                .padding(.horizontal, 20)
                                                .padding(.vertical, 10)
                                                .background(Color.black.opacity(0.30))
                                                .cornerRadius(50)
                                                .overlay(
                                                    RoundedRectangle(cornerRadius: 50)
                                                        .stroke(Color(red: 1, green: 0.94, blue: 0.74).opacity(0.70), lineWidth: 0.50)
                                                )
                                        }
                                        
                                        Spacer()
                                        
                                        Button(action: {
                                            let newMarker = Marker(
                                                id: UUID(),
                                                name: tempMarkerName,
                                                description: tempMarkerDescription,
                                                xPosition: pos.x,
                                                yPosition: pos.y
                                            )
                                            markerManager.addMarker(newMarker)
                                            showingAddMarker = false
                                            tempMarkerName = ""
                                            tempMarkerDescription = ""
                                        }) {
                                            Text("Add")
                                                .foregroundColor(Color(red: 1, green: 0.94, blue: 0.74).opacity(0.70))
                                                .padding(.horizontal, 20)
                                                .padding(.vertical, 10)
                                                .background(Color.black.opacity(0.30))
                                                .cornerRadius(50)
                                                .overlay(
                                                    RoundedRectangle(cornerRadius: 50)
                                                        .stroke(Color(red: 1, green: 0.94, blue: 0.74).opacity(0.70), lineWidth: 0.50)
                                                )
                                        }
                                        .disabled(tempMarkerName.isEmpty || tempMarkerDescription.isEmpty)
                                    }
                                }
                                .padding()
                                .background(Color.black.opacity(0.30))
                                .cornerRadius(10)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color(red: 1, green: 0.94, blue: 0.74).opacity(0.70), lineWidth: 0.50)
                                )
                                .padding()
                            }
                            .transition(.move(edge: .bottom))
                            .animation(.easeInOut, value: showingAddMarker)
                        }
                    }
                    .background(Color.black)
                    .ignoresSafeArea()
                }
            }

struct RegionMap_Previews: PreviewProvider {
    static var previews: some View {
        RegionMap(regionName: "Novigrad")
    }
}
