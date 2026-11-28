//
//  SettingSection.swift
//  Plop
//
//  Created by Purinutt Amartayavis on 25/11/2569 BE.
//

import SwiftUI

struct SettingSection<Content: View>: View {
    let title: String
    @ViewBuilder let content: () -> Content

    init(_ title: String, @ViewBuilder content: @escaping () -> Content) {
        self.title = title
        self.content = content
    }

    var body: some View {
        VStack (alignment: .leading, spacing: Theme.Spacing.tight) {
            HStack {
                Text(title)
                    .textStyle(.listHeader)
                    .textCase(.uppercase)
                    .padding(.leading)
                Spacer()
            }
            VStack(spacing: 0) {
                Group(subviews: content()) { rows in
                    ForEach(rows) { content in
                        content
                            .padding()
                        
                        if content.id != rows.last?.id {
                            Divider()
                                .frame(height: 2)
                                .overlay(
                                    Theme.Colors.border
                                )
                        }
                    }
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
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
}

#Preview {
    SettingSection("Timer") {
        SettingToggle("Gentle nudge", isOn: .constant(false))
        SettingToggle("Timer on Lock Screen", isOn: .constant(false))
        SettingToggle("Haptics", isOn: .constant(false))
    }
    .padding()
}
