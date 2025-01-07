//
//  MarkerView.swift
//  witcher_3_glossary
//
//  Created by Konrad Waszczuk on 21/12/2024.
//


import SwiftUI

struct MarkerView: View {
    let marker: Marker
    let mapSize: CGSize
    @EnvironmentObject var markerManager: MarkerManager
    @State private var showingDeleteAlert = false
    
    struct UpsideDownTriangle: Shape {
        func path(in rect: CGRect) -> Path {
            var path = Path()
            path.move(to: CGPoint(x: rect.midX, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.minX, y: rect.minY))
            path.closeSubpath()
            
            return path
        }
    }
    
    var body: some View {
        let xPos = marker.xPosition * mapSize.width
        let yPos = marker.yPosition * mapSize.height
        
        VStack(spacing: 5) {
            ZStack {
                Circle()
                    .fill(Color.black.opacity(0.30))
                    .frame(width: 40, height: 40)
                    .overlay(
                        Circle()
                            .stroke(
                                Color(red: 1, green: 0.94, blue: 0.74).opacity(0.70),
                                lineWidth: 1
                            )
                    )
                
                UpsideDownTriangle()
                    .fill(Color(red: 1, green: 0.94, blue: 0.74).opacity(0.70))
                    .frame(width: 20, height: 20)
            }
            
            Text(marker.name)
                .foregroundColor(Color(red: 1, green: 0.94, blue: 0.74).opacity(0.70))
                .font(.caption)
                .padding(4)
                .background(Color.black.opacity(0.30))
                .cornerRadius(4)
                .overlay(
                    RoundedRectangle(cornerRadius: 4)
                        .stroke(
                            Color(red: 1, green: 0.94, blue: 0.74).opacity(0.70),
                            lineWidth: 0.50
                        )
                )
        }
        .position(x: xPos, y: yPos)
        .onTapGesture {
            showingDeleteAlert = true
        }
        .alert(isPresented: $showingDeleteAlert) {
            Alert(
                title: Text("Delete marker"),
                message: Text("Are You sure You want to delete \"\(marker.name)\"?"),
                primaryButton: .destructive(Text("Delete")) {
                    markerManager.removeMarker(marker)
                },
                secondaryButton: .cancel()
            )
        }
    }
}

