//
//  TimerViewModel.swift
//  Plop
//
//  Created by Purinutt Amartayavis on 23/11/2569 BE.
//

import SwiftUI
import SwiftData
import Combine

extension Duration {
    var timeInterval: TimeInterval {
        TimeInterval(components.seconds) + (Double(components.attoseconds) / 1e18)
    }
}

@Observable
final class TimerViewModel {
    private let service: TimerService
    private let router: AppRouter
    
    init(service: TimerService, router: AppRouter) {
        self.service = service
        self.router = router
    }
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var isReady: Bool {
        service.isRunning && !service.isPaused
    }
    
    private(set) var clock = "0:00"
    private(set) var startedAt = Date.now.formatted(Date.FormatStyle().hour().minute())
    
    var willNudgeAt: String {
        let remaining = ceilToMinute(duration: calculateRemainingNudge())
        
        return remaining.formatted(
            .units(
                allowed: [.minutes],
                width: .condensedAbbreviated
            )
        )
    }
    
    var progress: Double {
        
        return (service.elapsed()/service.nudgeDuration.timeInterval) 
    }

    var pauseButtonText: String {
        if service.isPaused {
            return "Resume"
        }
        return "Pause"
    }
    
    var pauseButtonIcon: String {
        if service.isPaused {
            return "play.fill"
        }
        return "square.fill"
    }
    
    func ceilToMinute(duration: Duration) -> Duration {
        let (seconds, attoseconds) = duration.components
        let totalSeconds = seconds + (attoseconds > 0 ? 1 : 0)
        let (minutes, remainderSeconds) = totalSeconds.quotientAndRemainder(dividingBy: 60)
        return Duration.seconds((minutes + (remainderSeconds > 0 ? 1 : 0)) * 60)
    }
    
    func calculateRemainingNudge() -> Duration{
        return service.nudgeDuration - Duration.seconds(service.elapsed())
    }
    
    func start() {
        service.start()
    }
    
    func resume() {
        service.resume()
    }
    
    func togglePause() {
        if service.isPaused {
            service.resume()
            return
        }
        
        service.pause()
    }
    
    func tick() {
        let duration = Duration.seconds(service.elapsed())
        
        clock = duration.formatted(.time(pattern: .minuteSecond))
    }
    
    func done() {
        guard let draft = service.stop() else { return }
        
        router.feedback(with: draft)
    }
    
    func cancel() {
        service.reset()
        router.home()
    }
}
