//
//  SettingViewModel.swift
//  Plop
//
//  Created by Purinutt Amartayavis on 25/11/2569 BE.
//

import Foundation
import SwiftData

@Observable
final class SettingViewModel {
    private let service: SettingService
    
    var isNudgeOn: Bool {
        get {
            service.isNudgeOn
        }
        set {
            service.isNudgeOn = newValue
        }
    }
    
    var nudgeDuration: Int {
        get {
            service.nudgeDuration
        }
        set {
            service.nudgeDuration = newValue
        }
    }
    
    var isTimerOnLockScreen: Bool {
        get {
            service.isTimerOnLockScreen
        }
        set {
            service.isTimerOnLockScreen = newValue
        }
    }
    
    var isHaptics: Bool {
        get {
            service.isHaptics
        }
        set {
            service.isHaptics = newValue
        }
    }
    
    var isDailyCheckin: Bool {
        get {
            service.isDailyCheckin
        }
        set {
            service.isDailyCheckin = newValue
        }
    }
    
    var isFaceIDOn: Bool {
        get {
            service.isFaceIDOn
        }
        set {
            service.isFaceIDOn = newValue
        }
    }
    
    var isCloudSyncOn: Bool {
        get {
            service.isCloudSyncOn
        }
        set {
            service.isCloudSyncOn = newValue
        }
    }

    init(service: SettingService) {
        self.service = service
    }
    
}
