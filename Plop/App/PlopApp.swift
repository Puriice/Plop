//
//  plopApp.swift
//  plop
//
//  Created by Purinutt Amartayavis on 19/11/2569 BE.
//

import SwiftUI
import SwiftData

@main
struct PlopApp: App {
    @State private var settings: SettingService
    @State private var timer: TimerService
    
    init() {
        let settings = SettingService()
        
        self.settings = settings
        timer = TimerService(settings: settings)
    }

    var body: some Scene {
        WindowGroup {
            ZStack {
                Theme.Colors.background.ignoresSafeArea()
                RootTabView(timer: timer)
                    .environment(timer)
                    .environment(settings)
                    .tint(Color.purple)
                    .fontDesign(.rounded)
            }
        }
        .modelContainer(for: Session.self)
    }
}
