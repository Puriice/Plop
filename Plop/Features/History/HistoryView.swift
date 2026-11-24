//
//  HistoryView.swift
//  Plop
//
//  Created by Purinutt Amartayavis on 23/11/2569 BE.
//

import SwiftData
import SwiftUI

struct HistoryView: View {
    @Query(sort: \Session.startedAt, order: .reverse) private var sessions:
        [Session]
    @State private var viewModel = HistoryViewModel()
    @State private var filter: Options = .Week

    var body: some View {
        let filteredSessions = viewModel.filter(sessions, option: filter)

        NavigationStack {
            SegmentedPicker(options: Options.allCases, selection: $filter)
                .padding(.horizontal, Theme.Spacing.screenH)
                .padding(.top, Theme.Spacing.screenTop)
                .padding(.bottom, Theme.Spacing.tight)
            Group {
                if filteredSessions.isEmpty {
                    ContentUnavailableView {
                        Label("No History", systemImage: "toilet.fill")
                    } description: {
                        Text("The recorded session will appear here")
                    }
                } else {
                    ScrollView {
                        LazyVStack(spacing: Theme.Spacing.listSection) {
                            ForEach(viewModel.groupByDay(filteredSessions)) {
                                group in
                                Section {
                                    VStack(spacing: 0) {
                                        ForEach(group.sessions) { session in
                                            NavigationLink(value: session) {
                                                HStack {
                                                    SessionCard(session: session)
                                                    Image(systemName: "chevron.right")
                                                        .font(.footnote.weight(.semibold))
                                                        .foregroundStyle(Theme.Colors.textSecondary)
                                                }
                                                    .padding(.vertical)
                                                    .padding(.leading)
                                            }
                                            if session.id
                                                != group.sessions.last?.id
                                            {
                                                Divider()
                                                    .frame(height: 2)
                                                    .overlay(
                                                        Theme.Colors.border
                                                    )
                                            }
                                        }
                                    }
                                    .padding(.trailing)
                                    .background(Theme.Colors.surface)
                                    .overlay(
                                        RoundedRectangle(
                                            cornerRadius: Theme.Radius.card
                                        )
                                        .stroke(
                                            Theme.Colors.border,
                                            lineWidth: 4
                                        )
                                    )
                                    .clipShape(
                                        .rect(cornerRadius: Theme.Radius.card)
                                    )
                                } header: {
                                    HStack {
                                        Text(viewModel.dayTitle(group.day))
                                            .textStyle(.groupHeader)
                                        Spacer()
                                        Text("\(group.sessions.count) visits")
                                            .font(Theme.Fonts.insightTitle)
                                            .foregroundStyle(
                                                Theme.Colors.textSecondary
                                            )
                                    }
                                }

                            }
                        }
                    }
                }
            }
            .padding(.horizontal, Theme.Spacing.screenH)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Text("History")
                        .textStyle(.largeTitle)
                        .fixedSize()
                }
                .sharedBackgroundVisibility(.hidden)
            }
            .containerBackground(Theme.Colors.background, for: .navigation)
            .navigationDestination(for: Session.self) { session in
                FeedbackView(session: session)
            }
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
            bristolType: .LumpySausage,
            note: "Coffee this morning"
        )
    )

    container.mainContext.insert(
        Session(
            startedAt: now.addingTimeInterval(-1600),
            endedAt: now.addingTimeInterval(-1450),
            bristolType: .Watery,
            note: "Coffee this morning"
        )
    )

    container.mainContext.insert(
        Session(
            startedAt: now.addingTimeInterval(-7 * 86400),
            endedAt: now.addingTimeInterval(-7 * 86400 + 300),
            feel: .Easy,
            bristolType: .SausageWithCracks
        )
    )

    container.mainContext.insert(
        Session(
            startedAt: now.addingTimeInterval(-32 * 86400),
            endedAt: now.addingTimeInterval(-32 * 86400 + 420),
            feel: .Tough,
            bristolType: .SeparateHardLumps,
            note: "Not enough water"
        )
    )

    let notes = [
        nil, nil, "Spicy dinner", "Big lunch", "After the gym",
        "Morning coffee",
    ]
    for _ in 0..<10 {
        let start = now.addingTimeInterval(-Double.random(in: 0...(30 * 86400)))
        container.mainContext.insert(
            Session(
                startedAt: start,
                endedAt: start.addingTimeInterval(Double.random(in: 60...900)),
                feel: Feel.allCases.randomElement()!,
                bristolType: Bristol.allCases.randomElement()!,
                note: notes.randomElement()!
            )
        )
    }

    return HistoryView()
        .background(Theme.Colors.background)
        .tint(Theme.Colors.mintDeep)
        .modelContainer(container)
        .environment(AppRouter(timer: TimerService()))
}

#Preview("No Session") {
    HistoryView()
        .background(Theme.Colors.background)
        .tint(Theme.Colors.mintDeep)
        .tint(Theme.Colors.mintDeep)
        .modelContainer(for: Session.self, inMemory: true)
        .environment(AppRouter(timer: TimerService()))
}
