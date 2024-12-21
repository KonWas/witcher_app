//
//  MarkerView.swift
//  witcher_3_glossary
//
//  Created by Konrad Waszczuk on 21/12/2024.
//


//import SwiftUI
//
//struct MarkerView: View {
//    let marker: Marker
//    let mapSize: CGSize
//    @EnvironmentObject var markerManager: MarkerManager
//    @State private var showingDeleteAlert = false
//    
//    var body: some View {
//        VStack {
//            Image(systemName: "mappin.circle.fill")
//                .resizable()
//                .frame(width: 30, height: 30)
//                .foregroundColor(.red)
//                .shadow(radius: 2)
//            Text(marker.name)
//                .font(.caption)
//                .foregroundColor(.white)
//                .padding(5)
//                .background(Color.black.opacity(0.7))
//                .cornerRadius(5)
//        }
//        .position(x: mapSize.width * marker.xPosition, y: mapSize.height * marker.yPosition)
//        .onTapGesture {
//            showingDeleteAlert = true
//        }
//        .alert(isPresented: $showingDeleteAlert) {
//            Alert(
//                title: Text("Delete marker"),
//                message: Text("Are You sure You want to delete \"\(marker.name)\"?"),
//                primaryButton: .destructive(Text("Delete")) {
//                    markerManager.removeMarker(marker)
//                },
//                secondaryButton: .cancel()
//            )
//        }
//    }
//}
import SwiftUI

struct MarkerView: View {
    let marker: Marker
    let mapSize: CGSize
    @EnvironmentObject var markerManager: MarkerManager
    @State private var showingDeleteAlert = false
    
    // Przykładowy kształt od razu "do góry nogami"
    struct UpsideDownTriangle: Shape {
        func path(in rect: CGRect) -> Path {
            var path = Path()
            // Wierzchołek na dole (środek)
            path.move(to: CGPoint(x: rect.midX, y: rect.maxY))
            // Górny prawy róg
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
            // Górny lewy róg
            path.addLine(to: CGPoint(x: rect.minX, y: rect.minY))
            path.closeSubpath()
            
            return path
        }
    }
    
    var body: some View {
        // Przeliczamy procentowe współrzędne na piksele
        let xPos = marker.xPosition * mapSize.width
        let yPos = marker.yPosition * mapSize.height
        
        VStack(spacing: 5) {
            ZStack {
                // Tło - okrąg
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
                
                // Od razu "do góry nogami"
                UpsideDownTriangle()
                    .fill(Color(red: 1, green: 0.94, blue: 0.74).opacity(0.70))
                    .frame(width: 20, height: 20)
            }
            
            // Nazwa znacznika
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
        // Ustawiamy całą tę „kolumnę” (znacznik + nazwa) w obliczonej pozycji
        .position(x: xPos, y: yPos)
        // Możesz dodać .offset, jeśli chcesz coś skorygować w pionie
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

