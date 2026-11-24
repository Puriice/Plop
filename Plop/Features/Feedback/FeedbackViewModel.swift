//
//  FeedbackViewModel.swift
//  Plop
//
//  Created by Purinutt Amartayavis on 24/11/2569 BE.
//

import Foundation
import SwiftData

@Observable
final class FeedbackViewModel {
    
    private var session: Session
    
    var draft: Bool {
        session.draft 
    }
    
    var duration: String {
        Duration.seconds(session.duration).formatted(.units(
            allowed: [.hours, .minutes, .seconds],
            width: .narrow
        ))
    }
    
    var timeline: String {
        "\(session.startedAt.formatted(.dateTime.hour().minute())) to \(session.endedAt.formatted(.dateTime.hour().minute()))"
    }
    
    var bristolType: String {
        session.bristolType.Description()
    }
    
    var note: String {
        get {
            session.note
        }
        set {
            session.note = newValue
        }
    }
    
    init(session: Session) {
        self.session = session
    }
    
    func isSelect(_ feel: Feel) -> Bool {
        return feel == session.feel
    }
    
    func setFeel(_ feel: Feel) {
        session.feel = feel
    }

    func isSelect(_ type: Bristol) -> Bool {
        return type == session.bristolType
    }
    
    func setType(_ type: Bristol) {
        session.bristolType = type
    }
    
    func save(context: ModelContext) {
        guard session.draft else { return }
        
        session.draft = false
        context.insert(session)
    }
}
