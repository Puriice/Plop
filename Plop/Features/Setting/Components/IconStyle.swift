//
//  IconStyle.swift
//  Plop
//
//  Created by Purinutt Amartayavis on 25/11/2569 BE.
//
import SwiftUI

enum IconStyle {
    case primary, green, yellow, none
    
    func background() -> Color {
        return switch self {
        case .primary: Theme.Colors.surfaceMuted
        case .green: Theme.Colors.mintSoft
        case .yellow: Theme.Colors.highlightSoft
        case .none: Color.clear
        }
    }
    
    func foreground() -> Color {
        return switch self {
        case .primary: Theme.Colors.textPrimary
        case .green: Theme.Colors.mintDeep
        case .yellow: Theme.Colors.highlightIcon
        case .none: Color.clear
        }
    }
}
