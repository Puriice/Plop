//
//  HistoryViewModel.swift
//  Plop
//
//  Created by Purinutt Amartayavis on 23/11/2569 BE.
//

import Foundation

@Observable
@MainActor
final class HistoryViewModel {
    
    struct DayGroup: Identifiable {
        let day: Date          // midnight of that day
        let sessions: [Session]
        var id: Date { day }
    }
    
    func filter(_ sessions: [Session], option: Options) -> [Session] {
        guard !sessions.isEmpty else { return [] }
        
        let filterDate = option.filter()
        
        guard let filterDate else { return sessions }
        
        return sessions.filter {
            $0.startedAt > filterDate
        }
    }
    
    func groupByDay(_ sessions: [Session]) -> [DayGroup] {
        let calendar = Calendar.current
        let grouped = Dictionary(grouping: sessions) { calendar.startOfDay(for: $0.startedAt) }
        
        return grouped
            .map { DayGroup(day: $0.key, sessions: $0.value.sorted { $0.startedAt > $1.startedAt }) }
            .sorted { $0.day > $1.day }   // newest day first
    }
    
    func dayTitle(_ day: Date) -> String {
        let calendar = Calendar.current
        if calendar.isDateInToday(day) { return String(localized: "Today") }
        if calendar.isDateInYesterday(day) { return String(localized: "Yesterday") }
        return day.formatted(.dateTime.weekday(.wide).day().month(.abbreviated))  // "Friday, 20 Nov"
    }
}
