//
//  Item.swift
//  Learn Connect
//
//  Created by kadir on 23.11.2024.
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
