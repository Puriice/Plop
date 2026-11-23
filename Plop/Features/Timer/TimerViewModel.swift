//
//  TimerViewModel.swift
//  Plop
//
//  Created by Purinutt Amartayavis on 23/11/2569 BE.
//

import SwiftUI
import SwiftData
import Combine

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
