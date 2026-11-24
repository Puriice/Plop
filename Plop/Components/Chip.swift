//
//  Chip.swift
//  Plop
//
//  Created by Purinutt Amartayavis on 21/11/2569 BE.
//
import SwiftUI

struct Chip: View {
    let title: String
    let isSelected: Bool
    var height: CGFloat = Theme.Size.chipHeight
    var selectedForeground: Color = Theme.Colors.mintDeep   // text & border when selected
    var selectedBackground: Color = Theme.Colors.mintSoft   // fill when selected
    let action: () -> Void
    
    init(_ title: String, isSelected: Bool = false, height: CGFloat = Theme.Size.chipHeight,
         selectedForeground: Color = Theme.Colors.mintDeep, selectedBackground: Color = Theme.Colors.mintSoft,
         action: @escaping () -> Void) {
        self.title = title
        self.isSelected = isSelected
        self.height = height
        self.selectedForeground = selectedForeground
        self.selectedBackground = selectedBackground
        self.action = action
    }
    
    var body: some View {
        let shape = RoundedRectangle(cornerRadius: Theme.Radius.chip, style: .continuous)
        Button(action: action) {
            Text(title)
                .font(Theme.Fonts.rowTitle)
                .foregroundStyle(isSelected ? selectedForeground : Theme.Colors.textPrimary)
                .frame(maxWidth: .infinity, minHeight: height)
                .background(isSelected ? selectedBackground : Theme.Colors.surface, in: shape)
                .overlay(shape.strokeBorder(isSelected ? selectedForeground : Theme.Colors.borderStrong,
                                            lineWidth: isSelected ? 2 : 1))
        }
        .buttonStyle(.plain)
        .accessibilityAddTraits(isSelected ? .isSelected : [])
    }
}
