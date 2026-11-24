//
//  Feel.swift
//  Plop
//
//  Created by Purinutt Amartayavis on 22/11/2569 BE.
//

import SwiftUI

enum Feel: String, Codable, CaseIterable, CustomLocalizedStringResourceConvertible, Identifiable {
    case Easy, Okay, Tough
    
    var localizedStringResource: LocalizedStringResource {
        switch self {
        case .Easy:  "Easy"
        case .Okay:  "Okay"
        case .Tough: "Tough"
        }
    }
    
    var id: Self { self }
    
    func Background() -> Color {
        return switch self {
        case .Easy:  Theme.Colors.mintSoft
        case .Okay:  Theme.Colors.highlightSoft
        case .Tough: Theme.Colors.dangerSoft
        }
    }
    
    func Foreground() -> Color {
        return switch self {
        case .Easy:  Theme.Colors.mintDeep
        case .Okay:  Theme.Colors.highlightText
        case .Tough: Theme.Colors.dangerText
        }
    }
}
