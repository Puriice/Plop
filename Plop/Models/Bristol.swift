//
//  Bristol.swift
//  plop
//
//  Created by Purinutt Amartayavis on 20/11/2569 BE.
//

import SwiftUI

enum Bristol: Int, Codable, CaseIterable, Identifiable {
    case SeparateHardLumps = 1,
         LumpySausage, SausageWithCracks, SmoothAndSoft, SoftBlobs, Mushy, Watery
    
    var id: Self { self }
    
    func Description() -> String {
        return switch self {
        case .SeparateHardLumps:
            String(localized: "Separate hard lumps")
        case .LumpySausage:
            String(localized: "Lumpy, sausage-shaped")
        case .SausageWithCracks:
            String(localized: "Sausage with cracks")
        case .SmoothAndSoft:
            String(localized: "Smooth and soft")
        case .SoftBlobs:
            String(localized: "Soft blobs")
        case .Mushy:
            String(localized: "Mushy")
        case .Watery:
            String(localized: "Watery")
        }
    }
    
    func Background() -> Color {
        return switch self {
        case .SausageWithCracks,.SmoothAndSoft, .SoftBlobs:
            Theme.Colors.mintSoft
        case .LumpySausage,  .Mushy:
            Theme.Colors.highlightSoft
        case .SeparateHardLumps, .Watery:
            Theme.Colors.dangerSoft
        }
    }
    
    func Foreground() -> Color {
        return switch self {
        case .SausageWithCracks, .SmoothAndSoft, .SoftBlobs:
            Theme.Colors.mintDeep
        case .LumpySausage, .Mushy:
            Theme.Colors.highlightText
        case .SeparateHardLumps, .Watery:
            Theme.Colors.dangerText
        }
        
    }
}
