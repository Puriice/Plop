//
//  SettingItem.swift
//  Plop
//
//  Created by Purinutt Amartayavis on 25/11/2569 BE.
//

import SwiftUI

struct SettingToggle: View {
    var label: String = "label"
    var systemName: String = "gear"
    var style: IconStyle
    @Binding var isOn: Bool

    init(
        _ label: String,
        systemName: String = "gear",
        style: IconStyle = .primary,
        isOn: Binding<Bool>
    ) {
        self.label = label
        self.systemName = systemName
        self.style = style
        self._isOn = isOn
    }

    var body: some View {
        SettingItemLayout(systemName: systemName, style: style) {
            Toggle(isOn: $isOn) {
                Text(label)
                    .textStyle(.settingTitle)
            }
            .tint(Theme.Colors.alwaysDeep)
        }
    }
}

#Preview {
    @Previewable @State var isOn = false

    SettingToggle("Gentle nudge", isOn: $isOn)
        .padding()
}
