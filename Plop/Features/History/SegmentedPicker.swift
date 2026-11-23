//
//  SegmentedPicker.swift
//  Plop
//
//  Created by Purinutt Amartayavis on 24/11/2569 BE.
//

import SwiftUI
struct SegmentedPicker<T: Hashable>: View {
    let options: [T]
    @Binding var selection: T
    @Namespace private var ns
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(options, id: \.self) { value in
                let label = String(describing: value)
                let isOn = selection == value
                Button {
                    withAnimation(.snappy(duration: 0.25)) { selection = value }
                } label: {
                    Text(label)
                        .font(Theme.Fonts.tileLabel)
                        .foregroundStyle(isOn ? Theme.Colors.textPrimary : Theme.Colors.textSecondary)
                        .frame(maxWidth: .infinity, minHeight: Theme.Size.segmentHeight)
                        .contentShape(.rect)
                        .background {
                            if isOn {
                                RoundedRectangle(cornerRadius: Theme.Radius.segment, style: .continuous)
                                    .fill(Theme.Colors.surface)
                                    .shadow(color: .black.opacity(0.08), radius: 3, y: 1)
                                    .matchedGeometryEffect(id: "thumb", in: ns)
                            }
                        }
                }
                .buttonStyle(.plain)
                .accessibilityAddTraits(isOn ? .isSelected : [])
            }
        }
        .padding(4)
        .background(Theme.Colors.surfaceMuted,
                    in: RoundedRectangle(cornerRadius: Theme.Radius.segmentTrack, style: .continuous))
    }
}

// Usage in HistoryView
#Preview {
    @Previewable @State var selected = Options.Week
    
    SegmentedPicker(options: Options.allCases,
                    selection: $selected)
    .padding(.horizontal, 24)
}
