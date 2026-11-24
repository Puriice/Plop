//
//  SessionCard.swift
//  Plop
//
//  Created by Purinutt Amartayavis on 22/11/2569 BE.
//

import SwiftUI

struct SessionCard: View {
    private var session: Session
    
    init(session: Session) {
        self.session = session
    }
    
    var body: some View {
        HStack {
            ZStack {
                RoundedRectangle(cornerRadius: Theme.Radius.chip)
                    .fill(session.bristolType.Background())
                    .aspectRatio(1, contentMode: .fit)
                    .frame(height: Theme.Size.iconButton)
                Text(String(session.bristolType.rawValue))
                    .foregroundStyle(session.bristolType.Foreground())
                    .fontWeight(.heavy)
            }
            VStack(alignment: .leading, spacing: 4) {
                Text("\(session.startedAt.formatted(.dateTime.hour().minute())) - \(session.endedAt.formatted(.dateTime.hour().minute()))")
                    .textStyle(.rowTitle)
                Text("\(session.feel) • \(session.bristolType.Description())")
                    .textStyle(.rowMeta)
                    .multilineTextAlignment(.leading)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            Spacer()
            Text(Duration.seconds(session.duration).formatted(.units(
                allowed: [.hours, .minutes, .seconds],
                width: .narrow
            )))
                .textStyle(.rowDuration)
            
        }
        .frame(maxWidth: .infinity)
        .background(Theme.Colors.surface)

    }
}

#Preview {
    let now = Date.now
    
    SessionCard(session: Session(
        startedAt: now.addingTimeInterval(-13600),
        endedAt: now.addingTimeInterval(-3200),
        bristolType: .SmoothAndSoft ,
        note: "Coffee this morning"
    ))
    .padding()
    .clipShape(.rect(cornerRadius: Theme.Radius.card))
    .overlay(
        RoundedRectangle(cornerRadius: Theme.Radius.card)
            .stroke(Theme.Colors.border, lineWidth: 2)
    )
}
