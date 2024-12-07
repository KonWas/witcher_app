////
////  DynamicItemDetailScreen.swift
////  witcher_3_glossary
////
////  Created by Konrad Waszczuk on 07/12/2024.
////
//
//
//import SwiftUI
//
//struct DynamicItemDetailScreen: View {
//    @Environment(\.presentationMode) var presentationMode
//    let item: Item
//    let backgroundImageName: String
//
//    init(item: Item, backgroundImageName: String) {
//        self.item = item
//        self.backgroundImageName = backgroundImageName
//    }
//    
//    var body: some View {
//        ZStack {
//            Image(backgroundImageName)
//                .resizable()
//                .scaledToFill()
//                .edgesIgnoringSafeArea(.all)
//
//            VStack(spacing: 20) {
//                HStack {
//                    Button(action: {
//                        presentationMode.wrappedValue.dismiss()
//                    }) {
//                        Image(systemName: "arrow.left")
//                            .foregroundColor(.white)
//                            .padding()
//                            .background(Color.black.opacity(0.7))
//                            .cornerRadius(12)
//                    }
//                    Spacer()
//                }
//                .padding(.top, 60)
//                .padding(.leading, 30)
//
//                Text(item.name)
//                    .font(.largeTitle)
//                    .foregroundColor(.white)
//                    .padding(.top, 20)
//                    .frame(maxWidth: .infinity, alignment: .leading)
//                    .padding(.leading, 20)
//
//                ScrollView {
//                    VStack(spacing: 20) {
//                        Image(item.imageName)
//                            .resizable()
//                            .frame(width: 100, height: 200)
//                            .clipShape(Rectangle())
//                            .overlay(Rectangle().stroke(Color.gray, lineWidth: 1))
//                            .padding()
//
//                        Text("Description")
//                            .font(.title2)
//                            .foregroundColor(.white)
//                            .padding(.top)
//
//                        Text(item.description)
//                            .font(.body)
//                            .foregroundColor(.white)
//                            .multilineTextAlignment(.center)
//                            .padding()
//
//                        Text("Category-Specific Info")
//                            .font(.title2)
//                            .foregroundColor(.white)
//                            .padding(.top)
//
//                        Text(item.additionalInfo)
//                            .font(.body)
//                            .foregroundColor(.white)
//                            .multilineTextAlignment(.center)
//                            .padding()
//                    }
//                }
//                .padding(.horizontal, 20)
//            }
//        }
//    }
//}


import SwiftUI

struct DynamicItemDetailScreen: View {
    @Environment(\.presentationMode) var presentationMode
    let item: Item
    let backgroundImageName: String

    @State private var selectedComponent: Item?

    init(item: Item, backgroundImageName: String) {
        self.item = item
        self.backgroundImageName = backgroundImageName
    }
    
    var body: some View {
        ZStack {
            Image(backgroundImageName)
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)

            VStack(spacing: 20) {
                // Strzałka powrotu
                HStack {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "arrow.left")
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.black.opacity(0.7))
                            .cornerRadius(12)
                    }
                    Spacer()
                }
                .padding(.top, 60)
                .padding(.leading, 30)

                // Tytuł
                Text(item.name)
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .padding(.top, 20)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 20)

                ScrollView {
                    VStack(spacing: 20) {
                        Image(item.imageName)
                            .resizable()
                            .frame(width: 200, height: 200)
                            .clipShape(Rectangle())
                            .overlay(Rectangle().stroke(Color.gray, lineWidth: 1))
                            .padding()

                        Text("Description")
                            .font(.title2)
                            .foregroundColor(.white)
                            .padding(.top)

                        Text(item.description)
                            .font(.body)
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                            .padding()

                        // Wyświetlenie składników (jeśli są)
                        if let components = item.components, !components.isEmpty {
                            Text("Components")
                                .font(.title2)
                                .foregroundColor(.white)
                                .padding(.top)

                            ForEach(components) { component in
                                Button(action: {
                                    selectedComponent = component
                                }) {
                                    HStack {
                                        Image(component.imageName)
                                            .resizable()
                                            .frame(width: 50, height: 50)
                                            .clipShape(Rectangle())
                                            .overlay(Rectangle().stroke(Color.gray, lineWidth: 1))

                                        Text(component.name)
                                            .font(.headline)
                                            .foregroundColor(.white)
                                            .padding(.leading, 10)
                                    }
                                    .padding()
                                    .background(Color.black.opacity(0.7))
                                    .cornerRadius(10)
                                }
                            }
                        }
                    }
                }
                .padding(.horizontal, 20)
            }
        }
        .fullScreenCover(item: $selectedComponent) { component in
            DynamicItemDetailScreen(item: component, backgroundImageName: backgroundImageName)
        }
    }
}
