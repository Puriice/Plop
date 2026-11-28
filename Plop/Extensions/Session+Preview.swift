//
//  Session+Preview.swift
//  Plop
//
//  Created by Purinutt Amartayavis on 28/11/2569 BE.
//

#if DEBUG
import Foundation
import SwiftData

extension Session {
    /// Deterministic sample sessions for previews. Same `seed` always produces the same pattern,
    /// covering `days` days back from `until` (inclusive).
    static func previewSamples(
        days: Int = 90,
        until: Date = .now,
        seed: UInt64 = 42
    ) -> [Session] {
        var rng = SeededGenerator(seed: seed)
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: until)
        var sessions: [Session] = []

        for offset in 0..<days {
            guard let day = calendar.date(byAdding: .day, value: -offset, to: today) else { continue }

            // Weighted so most days have 0–1 visits and a few have more
            let count = [0, 0, 1, 1, 1, 2, 2, 3].randomElement(using: &rng)!

            for _ in 0..<count {
                let startedAt = day.addingTimeInterval(TimeInterval(Int.random(in: 6 * 3600..<23 * 3600, using: &rng)))
                let duration = TimeInterval(Int.random(in: 60...900, using: &rng))

                sessions.append(
                    Session(
                        startedAt: startedAt,
                        endedAt: startedAt.addingTimeInterval(duration),
                        feel: Feel.allCases.randomElement(using: &rng)!,
                        bristolType: Bristol.allCases.randomElement(using: &rng)!
                    )
                )
            }
        }

        return sessions.sorted { $0.startedAt > $1.startedAt }
    }
    
    @MainActor
    static func previewContainer() -> ModelContainer {
        let container = try! ModelContainer(
            for: Session.self,
            configurations: ModelConfiguration(isStoredInMemoryOnly: true)
        )
        Session.previewSamples().forEach { container.mainContext.insert($0) }
        return container
    }
}

/// SplitMix64 — tiny seedable RNG so previews stay stable between renders.
struct SeededGenerator: RandomNumberGenerator {
    private var state: UInt64

    init(seed: UInt64) {
        state = seed
    }

    mutating func next() -> UInt64 {
        state &+= 0x9E3779B97F4A7C15
        var z = state
        z = (z ^ (z >> 30)) &* 0xBF58476D1CE4E5B9
        z = (z ^ (z >> 27)) &* 0x94D049BB133111EB
        return z ^ (z >> 31)
    }
}
#endif
