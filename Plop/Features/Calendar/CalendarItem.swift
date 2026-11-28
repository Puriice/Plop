//
//  CalendarItem.swift
//  Plop
//
//  Created by Purinutt Amartayavis on 28/11/2569 BE.
//

import SwiftUI

struct CalendarItem: View {
    private var frequency: SessionFrequency = .None
    private var date: Date = .now
    private var onClick: () -> Void
    private var isSelected: Bool = false

    init(
        frequency: SessionFrequency = .None,
        date: Date = .now,
        isSelected: Bool = false,
        onClick: @escaping () -> Void
    ) {
        self.frequency = frequency
        self.date = date
        self.isSelected = isSelected
        self.onClick = onClick
    }

    var body: some View {
        let isDisabled = date > Calendar.current.startOfDay(for: .now)
        Button {
            onClick()
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: Theme.Radius.dayCell)
                    .fill(frequency.background())
                Text(date.formatted(.dateTime.day()))
                    .textStyle(.calendarDay, color: isDisabled ? .textSecondary : .textPrimary)
            }
            .opacity(isDisabled ? 0.55 : 1)
            .aspectRatio(1, contentMode: .fit)
            .overlay(
                RoundedRectangle(cornerRadius: Theme.Radius.dayCell)
                    .stroke(Theme.Colors.mintDeep, lineWidth: isSelected ? 2 : 0)
            )
        }
        .disabled(isDisabled)
    }
}

#Preview("None") {
    CalendarItem {

    }
    .padding()
}

#Preview("Low") {
    CalendarItem(frequency: .Low) {

    }
    .padding()
}

#Preview("Middle") {
    CalendarItem(frequency: .Mid) {

    }
    .padding()
}
#Preview("High") {
    CalendarItem(frequency: .High) {

    }
    .padding()
}
