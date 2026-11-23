//
//  Feel.swift
//  Plop
//
//  Created by Purinutt Amartayavis on 22/11/2569 BE.
//

import Foundation

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
}
