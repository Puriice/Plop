//
//  CalendarViewModel.swift
//  Plop
//
//  Created by Purinutt Amartayavis on 26/11/2569 BE.
//

import Foundation
import SwiftData

@Observable
final class CalendarViewModel {
    private(set) var monthIndex: Int = 0 
    
    var selectedDate: Date = .now

    var currentMonth: Date {
        return Calendar.current.date(
            byAdding: .month,
            value: monthIndex,
            to: Date.now
        ) ?? Date.now
    }

    var monthTitle: String {
        return currentMonth.formatted(
            Date.VerbatimFormatStyle(
                format: "\(month: .wide) \(year: .defaultDigits)",
                locale: .current,
                timeZone: .current,
                calendar: .current
            )
        )
    }

    var monthInterval: DateInterval? {
        return Calendar.current.dateInterval(of: .month, for: currentMonth)
    }

    var weekdaySymbols: [String] {
        let symbols = Calendar.current.shortWeekdaySymbols
        let shift = Calendar.current.firstWeekday - 1
        return Array(symbols[shift...] + symbols[..<shift])
    }

    var days: [Date] {
        guard let monthInterval else { return [] }

        return [monthInterval.start]
            + Array(
                Calendar.current.dates(
                    byAdding: .day,
                    startingAt: monthInterval.start,
                    in: monthInterval.start..<monthInterval.end
                )
            )
    }

    var padding: Int {
        guard let month = monthInterval else { return 0 }

        let weekday = Calendar.current.component(.weekday, from: month.start)

        return (weekday - Calendar.current.firstWeekday + 7) % 7
    }
    
    func next() {
        guard monthIndex < 0 else { return }
        
        monthIndex += 1
        
        let targetDate = Calendar.current.date(byAdding: .month, value: 1, to: selectedDate)
        
        guard let targetDate else { return }
        
        guard targetDate < Calendar.current.startOfDay(for: .now) else {
            selectedDate = .now
            return
        }
        
        selectedDate = targetDate
    }
    
    func previous() {
        monthIndex -= 1
        
        let targetDate = Calendar.current.date(byAdding: .month, value: -1, to: selectedDate)
        
        guard let targetDate else { return }
        
        selectedDate = targetDate
    }
    
    
    func groupByDay(_ sessions: [Session]) -> Dictionary<Date, [Session]> {
        return Dictionary(grouping: sessions) {
            Calendar.current.startOfDay(for: $0.startedAt)
        }
    }
    
    func isThe(_ date: Date = .now, sameDayAs: Date) -> Bool {
        return Calendar.current.isDate(date, inSameDayAs: sameDayAs)
    }
    
    func average(_ sessions: [Session]) -> String {
        guard !sessions.isEmpty else { return "0:00" }
        
        let total = sessions.reduce(0) { $0 + $1.endedAt.timeIntervalSince($1.startedAt) }
        return Duration.seconds(total / Double(sessions.count)).formatted(.units(
            allowed: [.hours, .minutes, .seconds],
            width: .narrow
        ))
    }
    
    func dayTitle(_ date: Date = .now) -> String {
        let formatted = date.formatted(.dateTime.weekday().day().month(.abbreviated))
        
        if Calendar.current.isDateInToday(date) {
            return "Today - \(formatted)"
        }
        return formatted
    }
    
    func filterByDate(_ sessions: [Session], filterBy date: Date = .now) -> [Session] {
        guard !sessions.isEmpty else { return [] }
        
        return sessions.filter { isThe($0.startedAt, sameDayAs: date)}
    }
}
