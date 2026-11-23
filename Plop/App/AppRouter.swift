//
//  AppRouter.swift
//  plop
//
//  Created by Purinutt Amartayavis on 19/11/2569 BE.
//
import Observation

enum AppTab: Hashable {
    case home, history, stats
}

@Observable
final class AppRouter {
    private var timer: TimerService
    
    var selectedTab: AppTab = .home
    var isTimerPresented = false
    var isSettingsPresented = false
    
    
    var draft: Session? = nil
    
    init(timer: TimerService) {
        self.timer = timer
    }
    
    func startSession() {
        draft = nil
        isTimerPresented = true
        timer.start()
    }
    
    func feedback(with draft: Session) {
        self.draft = draft
    }
    
    func home() {
        isTimerPresented = false
    }
    
    func timerDismiss() {
        draft = nil
        timer.reset()
    }
}
