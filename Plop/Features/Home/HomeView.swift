//
//  HomeView.swift
//  plop
//
//  Created by Purinutt Amartayavis on 19/11/2569 BE.
//

import SwiftData
import SwiftUI

struct HomeView: View {
    @Query(sort: \Session.endedAt, order: .reverse) private var sessions:
        [Session]
    @Environment(AppRouter.self) private var router
    @State private var viewModel = HomeViewModel()

    var body: some View {
        let today = viewModel.filterToday(sessions)

        NavigationStack {
            VStack(spacing: Theme.Spacing.homeSection) {
                VStack(spacing: Theme.Spacing.tight) {
                    if let first = sessions.first {
                        Text(
                            "Last visit \(first.endedAt.formatted(.relative(presentation: .named)))"
                        ).textStyle(.rowTitle).fixedSize()
                    } else {
                        Text("Welcome to the Plop").textStyle(.rowTitle)
                    }
                    ZStack {
                        Circle()
                            .fill(Theme.Colors.haloOuter)
                            .frame(
                                width: Theme.Size.startButton
                                + Theme.Size.haloOuter
                            )
                        Circle()
                            .fill(Theme.Colors.haloInner)
                            .frame(
                                width: Theme.Size.startButton
                                + Theme.Size.haloInner
                            )
                        Button{
                            router.startSession()
                        }  label: {
                            ZStack {
                                Circle()
                                    .fill(Theme.Colors.highlight)
                                    .frame(width: Theme.Size.startButton)
                                VStack(spacing: Theme.Spacing.tight) {
                                    Image(systemName: "play.fill")
                                        .font(
                                            .system(size: Theme.Size.iconButton)
                                        )
                                    Text("Start").font(Theme.Fonts.startLabel)
                                }
                            }
                        }
                        .tint(Theme.Colors.textOnAccent)
                    }
                    Text("Tap to start the clock").textStyle(.rowMeta)
                }
                .padding()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .aspectRatio(1, contentMode: .fit)
                .layoutPriority(1)
                .background(Theme.Colors.heroBackground)
                .clipShape(.rect(cornerRadius: Theme.Radius.card))
                .overlay(
                    RoundedRectangle(cornerRadius: Theme.Radius.card)
                        .stroke(Color.clear, lineWidth: 0)
                )
                HStack(spacing: Theme.Spacing.tile) {
                    Card("Today", String(today.count), unit: "Sessions")
                    Card("Avg. Time", viewModel.averageSession(today))
                }
                HStack {
                    Text("Recent").textStyle(.section)
                    Spacer()
                    Button("See all") {
                        router.selectedTab = AppTab.history
                    }
                    .font(Theme.Fonts.seeAll)
                    .foregroundStyle(Theme.Colors.mintDeep)
                    .buttonStyle(.plain)
                }
                if sessions.isEmpty {
                    ContentUnavailableView {
                        Label("No Session", systemImage: "toilet.fill")
                    } description: {
                        Text("The most recent session will appear here")
                    }
                } else {
                    SessionCard(session: sessions.first!)
                        .padding()
                        .background(Theme.Colors.surface)
                        .clipShape(.rect(cornerRadius: Theme.Radius.card))
                        .overlay(
                            RoundedRectangle(cornerRadius: Theme.Radius.card)
                                .stroke(Theme.Colors.border, lineWidth: 2)
                        )
                }
                Spacer()
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    VStack {
                        Text(
                            Date.now.formatted(
                                .dateTime
                                    .weekday(.abbreviated)
                                    .day(.twoDigits)
                                    .month(.abbreviated)
                            )
                        )
                        .textStyle(.eyebrow)
                        .fixedSize()
                        Text("Plop")
                            .font(Theme.Fonts.largeTitle)
                            .fixedSize()
                    }
                }
                .sharedBackgroundVisibility(.hidden)
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        router.openSetting()
                    } label: {
                        Image(systemName: "gear")
                    }
                }
            }
            .padding(Theme.Spacing.screenH)
            .containerBackground(Theme.Colors.background, for: .navigation)
        }
    }
}

#Preview {
    let container = try! ModelContainer(
        for: Session.self,
        configurations: ModelConfiguration(isStoredInMemoryOnly: true)
    )

    let now = Date.now

    container.mainContext.insert(
        Session(
            startedAt: now.addingTimeInterval(-90000),
            endedAt: now.addingTimeInterval(-89500),
            bristolType: .SmoothAndSoft
        )
    )
    container.mainContext.insert(
        Session(
            startedAt: now.addingTimeInterval(-3600),
            endedAt: now.addingTimeInterval(-3200),
            bristolType: .SmoothAndSoft,
            note: "Coffee this morning"
        )
    )

    return HomeView()
        .tint(Theme.Colors.mintDeep)
        .modelContainer(container)
        .environment(AppRouter(timer: TimerService()))
}

#Preview("No Session") {
    HomeView()
        .tint(Theme.Colors.mintDeep)
        .modelContainer(for: Session.self, inMemory: true)
        .environment(AppRouter(timer: TimerService()))
}
