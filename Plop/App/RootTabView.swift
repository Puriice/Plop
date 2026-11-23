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
            HistoryView().tabItem {
                Label(Tabs.historyString, systemImage: Tabs.historyIcon)
            }.tag(AppTab.history)
        }
        .fullScreenCover(isPresented: $router.isTimerPresented, onDismiss: router.timerDismiss) {
            NavigationStack {
                TimerView(service: timer, router: router)
                    .navigationDestination(item: $router.draft) { draft in
                        FeedbackView(session: draft)
                    }
                    .containerBackground(Theme.Colors.background, for: .navigation)
            }
        }
        .environment(router)
    }

}

#Preview {
    let timer = TimerService()
    RootTabView(timer: timer)
        .environment(timer)
        .environment(TimerService())
        .modelContainer(for: Session.self, inMemory: true)
}
