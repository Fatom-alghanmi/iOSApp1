//
//  Order.swift
//  TimHortonsRun
//
//  Created by Fatom on 2025-09-17.
//

import Foundation

struct Order: Identifiable, Codable, Hashable {
    let id = UUID()
    var name: String
    var drink: String
    var size: String
    var notes: String?  // optional
    var date: Date = Date() 

    // Sample data
    static let sampleOrders: [Order] = [
        Order(name: "Fatom", drink: "Iced Capp", size: "Large", notes: nil),
        Order(name: "Ali", drink: "Double Double", size: "Medium", notes: "Extra sugar"),
        Order(name: "Sara", drink: "Steeped Tea", size: "Small", notes: nil)
    ]

    // Conform to Hashable manually (optional, for more safety)
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    static func == (lhs: Order, rhs: Order) -> Bool {
        lhs.id == rhs.id
    }
}
