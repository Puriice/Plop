//
//  SettingService.swift
//  Plop
//
//  Created by Purinutt Amartayavis on 25/11/2569 BE.
//
import Foundation
import SwiftData

@Observable
final class SettingService {
    private let defaults: UserDefaults
    
    var isNudgeOn: Bool {
        didSet {
            defaults.set(isNudgeOn, forKey: SettingKey.isNudgeOn)
        }
    }
    
    var nudgeDuration: Int {
        didSet {
            defaults.set(nudgeDuration, forKey: SettingKey.nudgeDuration)
        }
    }
    
    var isTimerOnLockScreen: Bool {
        didSet {
            defaults.set(isTimerOnLockScreen, forKey: SettingKey.isTimerOnLockScreen)
        }
    }
    
    var isHaptics: Bool {
        didSet {
            defaults.set(isHaptics, forKey: SettingKey.isHapticOn)
        }
    }
    
    var isDailyCheckin: Bool {
        didSet {
            defaults.set(isDailyCheckin, forKey: SettingKey.isDailyCheckinOn)
        }
    }
    
    var isFaceIDOn: Bool {
        didSet {
            defaults.set(isFaceIDOn, forKey: SettingKey.isLockWithFaceID)
        }
    }
    
    var isCloudSyncOn: Bool {
        didSet {
            defaults.set(isCloudSyncOn, forKey: SettingKey.isCloudSync)
        }
    }
    
    init(defaults: UserDefaults = .standard) {
        self.defaults = defaults
        
        isNudgeOn = defaults.bool(forKey: SettingKey.isNudgeOn)
        nudgeDuration = defaults.object(forKey: SettingKey.nudgeDuration) as? Int ?? 10
        isTimerOnLockScreen = defaults.bool(forKey: SettingKey.isTimerOnLockScreen)
        isHaptics = defaults.bool(forKey: SettingKey.isHapticOn)
        isDailyCheckin = defaults.bool(forKey: SettingKey.isDailyCheckinOn)
        isFaceIDOn = defaults.bool(forKey: SettingKey.isLockWithFaceID)
        isCloudSyncOn = defaults.bool(forKey: SettingKey.isCloudSync)
    }
}
