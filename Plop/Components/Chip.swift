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
    let action: () -> Void
    
    init(_ title: String, isSelected: Bool = false, height: CGFloat = Theme.Size.chipHeight, action: @escaping () -> Void) {
        self.title = title
        self.isSelected = isSelected
        self.height = height
        self.action = action
    }
    
    var body: some View {
        let shape = RoundedRectangle(cornerRadius: Theme.Radius.chip, style: .continuous)
        Button(action: action) {
            Text(title)
                .font(Theme.Fonts.rowTitle)
                .foregroundStyle(isSelected ? Theme.Colors.mintDeep : Theme.Colors.textPrimary)
                .frame(maxWidth: .infinity, minHeight: height)
                .background(isSelected ? Theme.Colors.mintSoft : Theme.Colors.surface, in: shape)
                .overlay(shape.strokeBorder(isSelected ? Theme.Colors.mintDeep : Theme.Colors.borderStrong,
                                            lineWidth: isSelected ? 2 : 1))
        }
        .buttonStyle(.plain)
        .accessibilityAddTraits(isSelected ? .isSelected : [])
    }
}
