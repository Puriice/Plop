//
//  CalendarView.swift
//  Plop
//
//  Created by Purinutt Amartayavis on 26/11/2569 BE.
//

import SwiftData
import SwiftUI

struct CalendarView: View {
    @State private var viewModel = CalendarViewModel()

    var body: some View {
        CalendarContentView(viewModel: viewModel)
    }
}

private struct CalendarContentView: View {
    @Query private var sessions: [Session]

    private var viewModel: CalendarViewModel

    init(viewModel: CalendarViewModel) {
        let monthInterval = viewModel.monthInterval
        let start = monthInterval?.start ?? .distantPast
        let end = monthInterval?.end ?? .distantFuture

        self.viewModel = viewModel
        self._sessions = Query(
            filter: #Predicate {
                !$0.draft
                    && $0.startedAt >= start
                    && $0.startedAt < end
            },
            sort: \.startedAt
        )
    }

    var body: some View {
        @Bindable var viewModel = viewModel
        
        let selectedDate = viewModel.selectedDate
        let selectedDateSessions = viewModel.filterByDate(sessions, filterBy: selectedDate)
        
        
        VStack(alignment: .leading) {
            Text("Calendar")
                .textStyle(.largeTitle)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, Theme.Spacing.screenH)
            VStack(spacing: Theme.Spacing.logSection) {
                CalendarPicker(
                    viewModel: viewModel,
                    sessions: sessions,
                    selectedDate: $viewModel.selectedDate
                )
                .padding(.horizontal, Theme.Spacing.screenH)
                ScrollView {
                    Section {
                        Group {
                            if selectedDateSessions.isEmpty {
                                ContentUnavailableView {
                                    Label("No record found", systemImage: "magnifyingglass")
                                } description: {
                                    Text("The recorded session will appear here")
                                }
                            } else {
                                VStack(spacing: 0) {
                                    ForEach(selectedDateSessions, id: \.id) { session in
                                        NavigationLink(value: session) {
                                            HStack {
                                                SessionCard(session: session)
                                                Image(systemName: "chevron.right")
                                                    .font(.footnote.weight(.semibold))
                                                    .foregroundStyle(
                                                        Theme.Colors.textSecondary
                                                    )
                                            }
                                            .padding(.vertical)
                                            .padding(.leading)
                                        }
                                        if session.id
                                            != selectedDateSessions.last?.id
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
                            }
                        }
                        .padding(.horizontal, Theme.Spacing.screenH)
                        .id(selectedDateSessions.first)
                        .transition(.slide)
                    } header: {
                        HStack {
                            Text(viewModel.dayTitle(selectedDate))
                                .textStyle(.groupHeader)
                            Spacer()
                            Text("\(selectedDateSessions.count) visits")
                                .font(Theme.Fonts.insightTitle)
                                .foregroundStyle(
                                    Theme.Colors.textSecondary
                                )
                        }
                        .padding(.horizontal, Theme.Spacing.screenH)
                    }
                }
                .animation(.snappy, value: selectedDate)
            }
        }
        .padding(.top, Theme.Spacing.screenTop)
    }
}

#Preview {
    CalendarView()
        .modelContainer(Session.previewContainer())
}
