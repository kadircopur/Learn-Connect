//
//  Profile.swift
//  Learn Connect
//
//  Created by kadir on 25.11.2024.
//

import Foundation
import SwiftUI

enum Appearance: String, CaseIterable, Identifiable {
    case system
    case light
    case dark

    var id: String { self.rawValue }
    
    // Map Appearance cases to SwiftUI's ColorScheme
    var colorScheme: ColorScheme? {
        switch self {
        case .system: return .light // Follow system
        case .light: return .light
        case .dark: return .dark
        }
    }
}
