//
//  CustomButtonStyle.swift
//  Project_Version1
//
//  Created by Pro on 10/7/23.
//

import SwiftUI

struct TiltButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 1.3 : 1)
            .rotationEffect(.degrees(configuration.isPressed ? 20 : 0))
            .animation(.easeOut(duration: 0.1), value: configuration.isPressed)
    }
}
struct ScaleButtonStyle: ButtonStyle {
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 1.3 : 1)
            .animation(.easeOut(duration: 0.1), value: configuration.isPressed)
    }
}
