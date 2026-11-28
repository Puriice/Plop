//
//  SessionFrequency.swift
//  Plop
//
//  Created by Purinutt Amartayavis on 28/11/2569 BE.
//
import SwiftUI

enum SessionFrequency: String, Hashable, CaseIterable {
    case None = "0", Low = "1", Mid = "2", High = "3+"

    static func from(count: Int) -> SessionFrequency {
        return switch abs(count) {
        case 0: .None
        case 1: .Low
        case 2: .Mid
        default: .High
        }
    }

    func background() -> Color {
        return switch self {
        case .None:
            Color.clear
        case .Low:
            Theme.Colors.visitsLow
        case .Mid:
            Theme.Colors.visitsMid
        case .High:
            Theme.Colors.visitsHigh
        }
    }
}
