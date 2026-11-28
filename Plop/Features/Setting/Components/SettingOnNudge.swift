//
//  SettingOnNudge.swift
//  Plop
//
//  Created by Purinutt Amartayavis on 25/11/2569 BE.
//

import SwiftUI

struct SettingOnNudge: View {
    @Binding var nudge: Int
    @State private var timer: Timer?

    init(nudge: Binding<Int>) {
        self._nudge = nudge
    }

    var body: some View {
        SettingItemLayout(style: .none) {
            HStack {
                Text("Nudge after")
                    .textStyle(.settingTitle)
                Spacer()
                HStack {
                    Button {
                        nudge = max(5, nudge - 1)
                    } label: {
                        Text("-")
                            .font(Theme.Fonts.stepperSymbol)
                    }
                    .buttonStyle(.plain)
                    .padding(.vertical, Theme.Spacing.tight)
                    .padding(.horizontal, Theme.Spacing.tilePadding)
                    Spacer()
                    Text(
                        "\(Duration.seconds(nudge * 60).formatted(.units( allowed: [.minutes], width: .condensedAbbreviated )))"
                    )
                    .textStyle(.stepperValue)
                    .fixedSize()
                    Spacer()
                    Button {
                        nudge = min(30, nudge + 1)
                    } label: {
                        Text("+")
                            .font(Theme.Fonts.stepperSymbol)
                    }
                    .buttonStyle(.plain)
                    .padding(.vertical, Theme.Spacing.tight)
                    .padding(.horizontal, Theme.Spacing.tilePadding)
                }
                .containerRelativeFrame(.horizontal) { width, _ in
                    width / 2.5
                }
                .background(Theme.Colors.surfaceMuted)
                .clipShape(RoundedRectangle(cornerRadius: Theme.Radius.stepper))
            }
        }
    }
}

#Preview {
    @Previewable @State var nudge = 10
    SettingOnNudge(nudge: $nudge)
        .padding()
}
