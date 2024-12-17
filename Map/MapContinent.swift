//
//  MapContinent.swift
//  witcher_3_glossary
//
//  Created by Konrad Waszczuk on 25/11/2024.
//

import SwiftUI

struct MapContinent: View {
    @Environment(\.presentationMode) var presentationMode
        @State private var selectedLocation: Location?

        var body: some View {
            ZStack {
                ZoomableScrollView {
                    Image("continent_map")
                        .resizable()
                        .scaledToFill()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .clipped()
                        .overlay(locationButtons)
                }
                
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
                    }
                    .padding(.top, 60)
                    .padding(.leading, 30)
                    Spacer()
                }
            }
            .ignoresSafeArea()
            .fullScreenCover(item: $selectedLocation) { location in
                RegionMap(regionName: location.name)
            }
        }
        
        private var locationButtons: some View {
            GeometryReader { geo in
                ZStack {
                    Button(action: {
                        selectedLocation = Location(name: "Novigrad")
                    }) {
                        Color.clear
                    }
                    .frame(width: 100, height: 100)
                    .position(x: geo.size.width * 0.35, y: geo.size.height * 0.39)
                    
                    Button(action: {
                        selectedLocation = Location(name: "Velen")
                    }) {
                        Color.clear
                    }
                    .frame(width: 100, height: 100)
                    .position(x: geo.size.width * 0.35, y: geo.size.height * 0.50)
                    
                    Button(action: {
                        selectedLocation = Location(name: "Skellige")
                    }) {
                        Color.clear
                    }
                    .frame(width: 220, height: 130)
                    .position(x: geo.size.width * 0.12, y: geo.size.height * 0.7)
                    
                    Button(action: {
                        selectedLocation = Location(name: "Vizima_Palace")
                    }) {
                        Color.clear
                    }
                    .frame(width: 120, height: 100)
                    .position(x: geo.size.width * 0.445, y: geo.size.height * 0.58)
                    
                    Button(action: {
                        selectedLocation = Location(name: "White_Orchard")
                    }) {
                        Color.clear
                    }
                    .frame(width: 70, height: 70)
                    .position(x: geo.size.width * 0.532, y: geo.size.height * 0.57)
                    
                    Button(action: {
                        selectedLocation = Location(name: "Kaer_Mohren")
                    }) {
                        Color.clear
                    }
                    .frame(width: 70, height: 70)
                    .position(x: geo.size.width * 0.645, y: geo.size.height * 0.075)
                }
            }
        }
    }

struct Location: Identifiable {
    let id = UUID()
    let name: String
}

struct ZoomableScrollView<Content: View>: UIViewRepresentable {
    let content: Content

    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    func makeUIView(context: Context) -> UIScrollView {
        let scrollView = UIScrollView()
        scrollView.delegate = context.coordinator
        scrollView.maximumZoomScale = 5.0
        scrollView.minimumZoomScale = 1.0
        scrollView.bounces = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false

        let hostingController = UIHostingController(rootView: content)
        hostingController.view.translatesAutoresizingMaskIntoConstraints = true
        hostingController.view.frame = CGRect(origin: .zero, size: CGSize(width: 1407, height: 1022))
        scrollView.addSubview(hostingController.view)
        scrollView.contentSize = hostingController.view.frame.size

        return scrollView
    }

    func updateUIView(_ uiView: UIScrollView, context: Context) {}

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, UIScrollViewDelegate {
        let parent: ZoomableScrollView

        init(_ parent: ZoomableScrollView) {
            self.parent = parent
        }

        func viewForZooming(in scrollView: UIScrollView) -> UIView? {
            scrollView.subviews.first
        }
    }
}

struct MapContinent_Previews: PreviewProvider {
    static var previews: some View {
        MapContinent()
    }
}
