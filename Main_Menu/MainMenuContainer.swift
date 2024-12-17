//
//  MainMenuContainer.swift
//  witcher_3_glossary
//
//  Created by Konrad Waszczuk on 23/11/2024.
//


import SwiftUI

struct MainMenuContainer: View {
    @State private var currentView: Int = 1
    @State private var slideDirection: Edge = .trailing

    var body: some View {
        ZStack {
            switch currentView {
            case 1:
                MainMenu1()
                    .transition(
                        .asymmetric(
                            insertion: .move(edge: slideDirection),
                            removal: .move(edge: slideDirection.opposite)
                        )
                    )
                    .gesture(
                        DragGesture()
                            .onEnded { value in
                                if value.translation.width < -100 {
                                    slideDirection = .trailing
                                    withAnimation {
                                        currentView = 2
                                    }
                                }
                            }
                    )
            case 2:
                MainMenu2()
                    .transition(
                        .asymmetric(
                            insertion: .move(edge: slideDirection),
                            removal: .move(edge: slideDirection.opposite)
                        )
                    )
                    .gesture(
                        DragGesture()
                            .onEnded { value in
                                if value.translation.width < -100 {
                                    slideDirection = .trailing
                                    withAnimation {
                                        currentView = 3
                                    }
                                } else if value.translation.width > 100 {
                                    slideDirection = .leading
                                    withAnimation {
                                        currentView = 1
                                    }
                                }
                            }
                    )
            case 3:
                MainMenu3()
                    .transition(
                        .asymmetric(
                            insertion: .move(edge: slideDirection),
                            removal: .move(edge: slideDirection.opposite)
                        )
                    )
                    .gesture(
                        DragGesture()
                            .onEnded { value in
                                if value.translation.width < -100 {
                                    slideDirection = .trailing
                                    withAnimation {
                                        currentView = 4
                                    }
                                } else if value.translation.width > 100 {
                                    slideDirection = .leading
                                    withAnimation {
                                        currentView = 2
                                    }
                                }
                            }
                    )
            case 4:
                MainMenu4()
                    .transition(
                        .asymmetric(
                            insertion: .move(edge: slideDirection),
                            removal: .move(edge: slideDirection.opposite)
                        )
                    )
                    .gesture(
                        DragGesture()
                            .onEnded { value in
                                if value.translation.width > 100 {
                                    slideDirection = .leading
                                    withAnimation {
                                        currentView = 3
                                    }
                                }
                            }
                    )
            default:
                EmptyView()
            }
        }
        .animation(.easeInOut, value: currentView)
    }
}

extension Edge {
    var opposite: Edge {
        switch self {
        case .leading:
            return .trailing
        case .trailing:
            return .leading
        case .top:
            return .bottom
        case .bottom:
            return .top
        }
    }
}

struct MainMenuContainer_Previews: PreviewProvider {
    static var previews: some View {
        MainMenuContainer()
    }
}
