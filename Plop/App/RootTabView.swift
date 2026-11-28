//
//  ContentView.swift
//  plop
//
//  Created by Purinutt Amartayavis on 19/11/2569 BE.
//

import SwiftUI
import SwiftData

struct RootTabView: View {
    @State private var router: AppRouter
    @Environment(TimerService.self) private var timer
    @Environment(SettingService.self) private var settings
    
    init(timer: TimerService) {
        self.router = AppRouter(timer: timer)
    }

    var body: some View {
        @Bindable var router = router
        
        TabView (selection: $router.selectedTab) {
            HomeView()
                .tabItem{
                 Label(Tabs.homeString, systemImage: Tabs.homeIcon)
            }
            .tag(AppTab.home)
            CalendarView().tabItem {
                Label(Tabs.calendarString, systemImage: Tabs.calendarIcon)
            }.tag(AppTab.calendar)
            HistoryView().tabItem {
                Label(Tabs.historyString, systemImage: Tabs.historyIcon)
            }.tag(AppTab.history)
        }
        .fullScreenCover(isPresented: $router.isSettingsPresented) {
            NavigationStack {
                SettingView(service: settings)
            }
        }
        .fullScreenCover(isPresented: $router.isTimerPresented, onDismiss: router.timerDismiss) {
            NavigationStack {
                TimerView(timer: timer, router: router)
                    .navigationDestination(item: $router.draft) { draft in
                        FeedbackView(session: draft)
                    }
                    .containerBackground(Theme.Colors.background, for: .navigation)
            }
        }
        .task {
            guard timer.isRunning else { return }
            router.isTimerPresented = true
        }
        .environment(router)
    }

}

#Preview {
    let timer = TimerService()
    RootTabView(timer: timer)
        .environment(timer)
        .environment(SettingService())
        .modelContainer(Session.previewContainer())
}

