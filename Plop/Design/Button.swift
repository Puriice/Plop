//
//  Button.swift
//  Plop
//
//  Created by Purinutt Amartayavis on 23/11/2569 BE.
//

import SwiftUI

struct PlopButtonStyle: ButtonStyle {
    enum Kind {
        case mint        // Save session
        case highlight   // Done, yellow
        case outline     // Pause / Resume, dark border on mint
    }
    
    var kind: Kind
    @Environment(\.isEnabled) private var isEnabled
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(kind == .outline ? Theme.Fonts.buttonOutline : Theme.Fonts.button)
            .foregroundStyle(kind == .outline ? Theme.Colors.textPrimary : Theme.Colors.textOnAccent) // dark text on every fill, never white
            .labelStyle(.titleAndIcon)
            .frame(maxWidth: .infinity, minHeight: Theme.Size.buttonHeight)
            .background(fill, in: Capsule())
            .overlay {
                // pressed: darken slightly
                Capsule().fill(Theme.Colors.textPrimary.opacity(configuration.isPressed ? 0.08 : 0))
            }
            .overlay {
                if kind == .outline {
                    Capsule().strokeBorder(Theme.Colors.textPrimary, lineWidth: 2)
                }
            }
            .contentShape(Capsule())
            .scaleEffect(configuration.isPressed ? 0.97 : 1)
            .opacity(isEnabled ? 1 : 0.45)
            .animation(.easeOut(duration: 0.15), value: configuration.isPressed)
    }
    
    private var fill: Color {
        switch kind {
        case .mint:      Theme.Colors.mint
        case .highlight: Theme.Colors.highlight
        case .outline:   .clear
        }
    }
}

extension ButtonStyle where Self == PlopButtonStyle {
    static func plop(_ kind: PlopButtonStyle.Kind) -> PlopButtonStyle { .init(kind: kind) }
}
