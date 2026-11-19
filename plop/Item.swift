//
//  Item.swift
//  plop
//
//  Created by Purinutt Amartayavis on 19/11/2569 BE.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
