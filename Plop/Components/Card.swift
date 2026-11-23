//
//  Card.swift
//  Plop
//
//  Created by Purinutt Amartayavis on 21/11/2569 BE.
//

import SwiftUI

struct Card: View {
    var title = "Title"
    var value = "1"
    var unit: String?
    
    init(_ title: String, _ value: String, unit: String? = nil) {
        self.title = title;
        self.value = value;
        self.unit = unit;
    }
    
    var body: some View {
        VStack (alignment: .leading, spacing: Theme.Spacing.tight){
            Text(title).textStyle(.rowMeta)
            HStack (alignment: .bottom){
                Text(value).textStyle(.largeTitle)
                if let unit {
                    Text(unit).textStyle(.rowMeta).padding(.bottom, 6)
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(Theme.Colors.surface)
        .clipShape(.rect(cornerRadius: Theme.Radius.card))
        .overlay(
            RoundedRectangle(cornerRadius: Theme.Radius.card)
                .stroke(Theme.Colors.border, lineWidth: 2)
        )
    }
}

#Preview {
    Card("Title", "2", unit:"session")
//        .background(Theme.Colors.background)
        .padding()
}
