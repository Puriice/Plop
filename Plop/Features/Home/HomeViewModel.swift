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
        return Duration.seconds(total).formatted(.units(
            allowed: [.hours, .minutes, .seconds],
            width: .narrow
        ))
    }
}
