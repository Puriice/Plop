//
//  HistoryView.swift
//  Plop
//
//  Created by Purinutt Amartayavis on 23/11/2569 BE.
//

import SwiftUI
import SwiftData

struct HistoryView: View {
    @Query(sort: \Session.startedAt, order: .reverse) private var sessions: [Session]
    @State private var viewModel = HistoryViewModel()
    @State private var filter: Options = .Week
    
    var body: some View {
        let filteredSessions = viewModel.filter(sessions, option: filter)
        
        NavigationStack {
            SegmentedPicker(options: Options.allCases, selection: $filter)
                .padding(.horizontal, Theme.Spacing.screenH)
            Group {
                if filteredSessions.isEmpty {
                    ContentUnavailableView {
                        Label("No History", systemImage: "toilet.fill")
                    } description: {
                        Text("The recorded session will appear here")
                    }
                } else {
                    List {
                        ForEach(viewModel.groupByDay(filteredSessions)) { group in
                            Section {
                                VStack(spacing: 0) {
                                    ForEach(group.sessions) { session in
                                        SessionCard(session: session)
                                            .padding(Theme.Spacing.tilePadding)
                                        if session.id != group.sessions.last?.id {
                                            Divider()
                                                .frame(height: 2)
                                                .overlay(Theme.Colors.border)
                                        }
                                    }
                                }
                                .background(Theme.Colors.surface)
                                .clipShape(.rect(cornerRadius: Theme.Radius.card))
                                .overlay(
                                    RoundedRectangle(cornerRadius: Theme.Radius.card)
                                        .stroke(Theme.Colors.border, lineWidth: 2)
                                )
                                .listRowBackground(Color.clear)
                                .listRowSeparator(.hidden)
                                .listRowInsets(
                                    EdgeInsets(
                                        top: 0, leading: 1, bottom: 0, trailing: 1
                                    )
                                )
                            } header: {
                                HStack {
                                    Text(viewModel.dayTitle(group.day)).textStyle(.groupHeader)
                                    Spacer()
                                    Text("\(group.sessions.count) visits").font(Theme.Fonts.insightTitle).foregroundStyle(Theme.Colors.textSecondary)
                                }
                                .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: Theme.Spacing.group, trailing: 0))
                            }
                            
                        }
                    }
                    .listStyle(.plain)
                    .scrollContentBackground(.hidden)
                    .listRowSeparator(.hidden)
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
        }
    }
}

#Preview {
    let container = try! ModelContainer(for: Session.self, configurations:  ModelConfiguration(isStoredInMemoryOnly: true))
    
    
    let now = Date.now
    
    container.mainContext.insert(Session(
        startedAt: now.addingTimeInterval(-90000),
        endedAt: now.addingTimeInterval(-89500),
        bristolType: .SmoothAndSoft
    ))
    container.mainContext.insert(Session(
        startedAt: now.addingTimeInterval(-3600),
        endedAt: now.addingTimeInterval(-3200),
        bristolType: .LumpySausage,
        note: "Coffee this morning"
    ))
    
    container.mainContext.insert(Session(
        startedAt: now.addingTimeInterval(-1600),
        endedAt: now.addingTimeInterval(-1450),
        bristolType: .Watery ,
        note: "Coffee this morning"
    ))

    container.mainContext.insert(Session(
        startedAt: now.addingTimeInterval(-7 * 86400),
        endedAt: now.addingTimeInterval(-7 * 86400 + 300),
        feel: .Easy,
        bristolType: .SausageWithCracks
    ))

    container.mainContext.insert(Session(
        startedAt: now.addingTimeInterval(-32 * 86400),
        endedAt: now.addingTimeInterval(-32 * 86400 + 420),
        feel: .Tough,
        bristolType: .SeparateHardLumps,
        note: "Not enough water"
    ))

    let notes = [nil, nil, "Spicy dinner", "Big lunch", "After the gym", "Morning coffee"]
    for _ in 0..<10 {
        let start = now.addingTimeInterval(-Double.random(in: 0...(30 * 86400)))
        container.mainContext.insert(Session(
            startedAt: start,
            endedAt: start.addingTimeInterval(Double.random(in: 60...900)),
            feel: Feel.allCases.randomElement()!,
            bristolType: Bristol.allCases.randomElement()!,
            note: notes.randomElement()!
        ))
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
