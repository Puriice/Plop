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
    @State private var timer = TimerService()

    var body: some Scene {
        WindowGroup {
            ZStack {
                Theme.Colors.background.ignoresSafeArea()
                RootTabView(timer: timer)
                    .environment(timer)
                    .tint(Color.purple)
                    .fontDesign(.rounded)
            }
        }
        .modelContainer(for: Session.self)
    }
}
