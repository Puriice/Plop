//
//  Session.swift
//  plop
//
//  Created by Purinutt Amartayavis on 20/11/2569 BE.
//

import Foundation
import SwiftData

@Model
final class Session: Hashable {
    var startedAt: Date
    var endedAt: Date
    var pauseDuration: TimeInterval = 0
    var feel: Feel = Feel.Okay
    var bristolType: Bristol = Bristol.SmoothAndSoft
    var note: String
    var draft: Bool
    
    var duration: TimeInterval {
        let total = endedAt.timeIntervalSince(startedAt) - pauseDuration
        
        return max(0, total)
    }

    init(startedAt: Date, endedAt: Date, pauseDuration: TimeInterval = 0, feel: Feel = Feel.Okay, bristolType: Bristol = Bristol.SmoothAndSoft, note: String? = nil, draft: Bool = false) {
        self.startedAt = startedAt
        self.endedAt = endedAt
        self.pauseDuration = pauseDuration
        self.feel = feel
        self.bristolType = bristolType
        self.note = note ?? ""
        self.draft = draft
    }
}
