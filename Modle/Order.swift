//
//  Order.swift
//  TimHortonsRun
//
//  Created by Fatom on 2025-09-17.
//

struct Order: Identifiable, Codable {
    let id = UUID()
    var name: String   // e.g. "Fatom"
    var drink: String  // e.g. "Double Double"
    var size: String   // e.g. "Medium"
    var notes: String? // optional

    static let sampleOrders: [Order] = [
        Order(name: "Fatom", drink: "Iced Capp", size: "Large"),
        Order(name: "Ali", drink: "Double Double", size: "Medium"),
        Order(name: "Sara", drink: "Steeped Tea", size: "Small")
    ]
}

