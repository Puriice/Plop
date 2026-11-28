//
//  Calendar.swift
//  Plop
//
//  Created by Purinutt Amartayavis on 28/11/2569 BE.
//
import SwiftUI

struct CalendarPicker: View {
    private static let columns = Array(
        repeating: GridItem(.flexible()),
        count: 7
    )

    private var viewModel: CalendarViewModel
    @Binding private var selectedDate: Date
    private let sessions: [Session]

    init(
        viewModel: CalendarViewModel,
        sessions: [Session],
        selectedDate: Binding<Date>
    ) {
        self.viewModel = viewModel
        self.sessions = sessions
        self._selectedDate = selectedDate
    }

    var body: some View {
        let days = viewModel.days
        let sessionsGroupByDay = viewModel.groupByDay(sessions)

        VStack(spacing: Theme.Spacing.group) {
            HStack {
                Button {
                    viewModel.previous()
                } label: {
                    ZStack {
                        Circle()
                            .fill(Theme.Colors.surfaceMuted)
                        Image(systemName: "chevron.left")
                    }
                    .frame(height: Theme.Size.iconButton)
                    .tint(Theme.Colors.textPrimary)
                }
                Spacer()
                VStack(spacing: Theme.Spacing.tight) {
                    Text(viewModel.monthTitle)
                        .textStyle(.rowTitle)
                    Text("\(sessionsGroupByDay.count) days, \(sessions.count) visits, avg \(viewModel.average(sessions))")
                        .textStyle(.rowMeta)
                }
                Spacer()
                Button {
                    viewModel.next()
                } label: {
                    ZStack {
                        Circle()
                            .fill(Theme.Colors.surfaceMuted)
                        Image(systemName: "chevron.right")
                    }
                    .frame(height: Theme.Size.iconButton)
                    .tint(Theme.Colors.textPrimary)
                }
                .disabled(viewModel.monthIndex >= 0)
            }

            LazyVGrid(columns: CalendarPicker.columns) {
                ForEach(viewModel.weekdaySymbols, id: \.self) { symbol in
                    Text(symbol)
                        .textStyle(.rowMeta)
                }

                ForEach(0..<viewModel.padding, id: \.self) { _ in
                    Color.clear
                }

                ForEach(days, id: \.self) { day in
                    let frequency = SessionFrequency.from(
                        count: sessionsGroupByDay[day]?.count ?? 0
                    )

                    CalendarItem(
                        frequency: frequency,
                        date: day,
                        isSelected: viewModel.isThe(
                            day,
                            sameDayAs: selectedDate
                        )
                    ) {
                        selectedDate = day
                    }
                }
            }
            HStack {
                Text("Visits")
                    .textStyle(.axisLabel)
                ForEach(SessionFrequency.allCases, id: \.self) { frequency in
                    RoundedRectangle(cornerRadius: Theme.Radius.legendSwatch)
                        .fill(frequency.background())
                        .frame(
                            width: Theme.Size.legendSwatch,
                            height: Theme.Size.legendSwatch
                        )
                        .overlay(
                            RoundedRectangle(
                                cornerRadius: Theme.Radius.legendSwatch
                            )
                            .stroke(
                                Theme.Colors.border,
                                lineWidth: frequency == .None ? 1 : 0
                            )
                        )
                    Text(frequency.rawValue)
                        .textStyle(.legend)
                }
            }
            .padding(.top, Theme.Spacing.legend)
        }  // Calendar Picker
        .frame(maxWidth: .infinity)
        .padding(Theme.Spacing.tile)
        .background(Theme.Colors.surface)
        .clipShape(.rect(cornerRadius: Theme.Radius.card))
        .overlay(
            RoundedRectangle(cornerRadius: Theme.Radius.card)
                .stroke(Theme.Colors.border, lineWidth: 1)
        )
    }
}

#Preview {
    @Previewable @State var selectedDate = Date.now
    CalendarPicker(
        viewModel: CalendarViewModel(),
        sessions: Session.previewSamples(),
        selectedDate: $selectedDate
    ).padding()
}
