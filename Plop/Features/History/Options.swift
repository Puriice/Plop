//
//  Options.swift
//  Plop
//
//  Created by Purinutt Amartayavis on 24/11/2569 BE.
//
import Foundation

enum Options: String, CaseIterable, Hashable {
    case Week, Month, All
    
    func filter(basedOn now: Date = Date.now) -> Date? {
        return switch self {
        case .Week: Calendar.current.date(byAdding: .weekOfYear, value: -1,  to: now)
        case .Month: Calendar.current.date(byAdding: .month, value: -1, to: now)
        default:
            nil
        }
    }
}
