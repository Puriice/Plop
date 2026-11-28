//
//  SettingItem.swift
//  Plop
//
//  Created by Purinutt Amartayavis on 25/11/2569 BE.
//

import SwiftUI

struct SettingItemLayout<Content: View> : View {
    var systemName: String = "gear"
    var backgroundIcon: Color
    var foregroundIcon: Color
    @ViewBuilder let content: () -> Content

    init(
        systemName: String = "gear",
        style: IconStyle = .primary,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.systemName = systemName
        self.backgroundIcon = style.background()
        self.foregroundIcon = style.foreground()
        self.content = content
    }

    var body: some View {
        HStack(spacing: Theme.Spacing.tile) {
            ZStack {
                RoundedRectangle(cornerRadius: Theme.Radius.iconTile)
                    .fill(backgroundIcon)
                    .aspectRatio(1, contentMode: .fit)
                    .frame(height: Theme.Size.iconButton)
                Image(systemName: systemName)
                    .foregroundStyle(foregroundIcon)
                    .fontWeight(.heavy)
            }
            content()
            .tint(Theme.Colors.alwaysDeep)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Theme.Colors.surface)
    }
}

#Preview {
    @Previewable @State var isOn = false

    SettingItemLayout {
        
    }
        .padding()
}
