//
//  HomeViewModel.swift
//  Plop
//
//  Created by Purinutt Amartayavis on 21/11/2569 BE.
//

import Foundation
import SwiftData

@Observable
@MainActor
final class HomeViewModel {

    func filterToday(_ sessions: [Session]) -> [Session] {
        guard !sessions.isEmpty else { return [] }
        
        let start = Calendar.current.startOfDay(for: .now)
        let end = Calendar.current.date(byAdding: .day, value: 1, to: start)!
        
        return sessions.filter{ $0.startedAt >= start && $0.endedAt < end }
    }
    
    func averageSession(_ sessions: [Session]) -> String {
        guard !sessions.isEmpty else { return "0:00" }

        let total = sessions.reduce(0) { $0 + $1.endedAt.timeIntervalSince($1.startedAt) }
        let average = Int((total / Double(sessions.count)).rounded())

        let hours = average / 3600
        let minutes = (average % 3600) / 60
        let seconds = average % 60

        if hours > 0 {
            return String(format: "%d:%02d:%02d", hours, minutes, seconds)
        }
        return String(format: "%d:%02d", minutes, seconds)
    }
}
