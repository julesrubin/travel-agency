//
//  Item.swift
//  travel-agency
//
//  Created by Jules RUBIN on 01/11/2025.
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
