//
//  Timer.swift
//  Plop
//
//  Created by Purinutt Amartayavis on 23/11/2569 BE.
//

import Foundation
import SwiftData

@Observable
final class TimerService {
    private struct State: Codable {
        var startedAt: Date
        var pausedAt: Date?
        var totalPaused: TimeInterval = 0
    }
    
    private var state: State? {
        didSet { save() }
    }
    
    private let defaults: UserDefaults
    private static let storageKey = "timer.state"
    
    init(defaults: UserDefaults = .standard) {
        self.defaults = defaults
        self.state = Self.load(from: defaults)
    }
    
    var isRunning: Bool {
        state != nil
    }
    
    var isPaused: Bool {
        state?.pausedAt != nil
    }
    
    var startedAt: Date? {
        state?.startedAt
    }
    
    func start(at now: Date = .now)  {
        guard state == nil else { return }
        
        state = State(startedAt: now)
    }
    
    func elapsed(at now: Date = .now) -> TimeInterval {
        guard let state else { return 0}
        
        let end = state.pausedAt ?? now
        let total = end.timeIntervalSince(state.startedAt) - state.totalPaused
        
        return max(0, total)
    }
    
    func pause(at now: Date = .now) {
        guard var current = state, current.pausedAt == nil else { return }
        
        current.pausedAt = now
        state = current
    }
    
    func stop(at now:Date = .now) -> Session? {
        pause(at: now)
        
        guard let state, let endedAt = state.pausedAt else { return nil }
        
        return Session(startedAt: state.startedAt, endedAt: endedAt, pauseDuration: state.totalPaused, draft: true)
    }
    
    func reset() {
        state = nil
    }
    
    func resume(at now: Date = .now) {
        guard var current = state, let pausedAt = current.pausedAt else { return }
        
        current.totalPaused += now.timeIntervalSince(pausedAt)
        current.pausedAt = nil
        state = current
    }
    
    private func save() {
        if let state, let data = try? JSONEncoder().encode(state) {
            defaults.set(data, forKey: Self.storageKey)
        } else {
            defaults.removeObject(forKey: Self.storageKey)
        }
    }
    
    private static func load(from defaults: UserDefaults) -> State? {
        guard let data = defaults.data(forKey: storageKey) else { return nil}
        
        return try? JSONDecoder().decode(State.self, from: data)
    }
}
