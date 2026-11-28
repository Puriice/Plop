//
//  UserDefaults+Preview.swift
//  Plop
//
//  Created by Purinutt Amartayavis on 25/11/2569 BE.
//

#if DEBUG
import Foundation

extension UserDefaults {
    static func preview(_ values: [String: Any] = [:]) -> UserDefaults {
        let suiteName = "Plop.preview"
        let defaults = UserDefaults(suiteName: suiteName)!
        defaults.removePersistentDomain(forName: suiteName)

        for (key, value) in values {
            defaults.set(value, forKey: key)
        }
        return defaults
    }
}
#endif
